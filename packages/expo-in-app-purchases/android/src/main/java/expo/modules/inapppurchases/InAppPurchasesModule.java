package expo.modules.inapppurchases;

import java.util.List;

import android.content.Context;
import android.app.Activity;

import expo.modules.core.ExportedModule;
import expo.modules.core.ModuleRegistry;
import expo.modules.core.Promise;
import expo.modules.core.interfaces.ExpoMethod;
import expo.modules.core.interfaces.ActivityProvider;
import expo.modules.core.interfaces.RegistryLifecycleListener;
import expo.modules.core.interfaces.services.EventEmitter;

public class InAppPurchasesModule extends ExportedModule implements RegistryLifecycleListener {
  private static final String TAG = InAppPurchasesModule.class.getSimpleName();
  private static final String NAME = "ExpoInAppPurchases";

  private BillingManager mBillingManager;
  private ModuleRegistry mModuleRegistry;
  private EventEmitter mEventEmitter;

  public InAppPurchasesModule(Context context) {
    super(context);
  }

  @Override
  public String getName() {
    return NAME;
  }

  @Override
  public void onCreate(ModuleRegistry moduleRegistry) {
    mModuleRegistry = moduleRegistry;
  }

  @ExpoMethod
  public void connectAsync(final Promise promise) {
    Activity activity = getCurrentActivity();
    if (activity == null) {
      promise.reject("E_ACTIVITY_UNAVAILABLE", "Activity is not available");
    }
    mEventEmitter = mModuleRegistry.getModule(EventEmitter.class);
    mBillingManager = new BillingManager(activity, mEventEmitter);
    mBillingManager.startConnection(promise);
  }

  @ExpoMethod
  public void getProductsAsync(List<String> itemList, final Promise promise) {
    mBillingManager.queryPurchasableItems(itemList, promise);
  }

  @ExpoMethod
  public void getPurchaseHistoryAsync(Boolean refresh, final Promise promise) {
    if (refresh != null && refresh) {
      // Makes a network request and provides more detailed information
      mBillingManager.queryPurchaseHistoryAsync(promise);
    } else {
      mBillingManager.queryPurchases(promise);
    }
  }

  @ExpoMethod
  public void purchaseItemAsync(String skuId, String oldSku, final Promise promise) {
    mBillingManager.purchaseItemAsync(skuId, oldSku, promise);
  }

  @ExpoMethod
  public void getBillingResponseCodeAsync(final Promise promise) {
    promise.resolve(mBillingManager.getBillingClientResponseCode());
  }

  @ExpoMethod
  public void finishTransactionAsync(String purchaseToken, Boolean consume, final Promise promise) {
    if (consume != null && consume) {
      mBillingManager.consumeAsync(purchaseToken, promise);
    } else {
      mBillingManager.acknowledgePurchaseAsync(purchaseToken, promise);
    }
  }

  @ExpoMethod
  public void disconnectAsync(final Promise promise) {
    if (mBillingManager != null) {
      mBillingManager.destroy();
      mBillingManager = null;
    }
    promise.resolve(null);
  }

  private Activity getCurrentActivity() {
    ActivityProvider activityProvider = mModuleRegistry.getModule(ActivityProvider.class);
    return activityProvider != null ? activityProvider.getCurrentActivity() : null;
  }
}
