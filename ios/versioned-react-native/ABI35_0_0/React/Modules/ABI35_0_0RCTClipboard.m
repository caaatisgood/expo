/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI35_0_0RCTClipboard.h"

#import <UIKit/UIKit.h>

@implementation ABI35_0_0RCTClipboard

ABI35_0_0RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}


ABI35_0_0RCT_EXPORT_METHOD(setString:(NSString *)content)
{
  UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
  clipboard.string = (content ? : @"");
}

ABI35_0_0RCT_EXPORT_METHOD(getString:(ABI35_0_0RCTPromiseResolveBlock)resolve
                  rejecter:(__unused ABI35_0_0RCTPromiseRejectBlock)reject)
{
  UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
  resolve((clipboard.string ? : @""));
}

@end
