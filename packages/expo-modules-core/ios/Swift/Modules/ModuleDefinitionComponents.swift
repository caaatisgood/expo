/**
 Extends all modules with the functions used to build a module definition.
 Unfortunately they need to be scoped here, but hopefully this proposal
 https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md#builder-scoped-name-lookup
 will be implemented in the future.
 */
extension AnyModule {
  /**
   Sets the name of the module that is exported to the JavaScript world.
   */
  public func name(_ name: String) -> AnyDefinition {
    return ModuleNameDefinition(name: name)
  }

  /**
   Definition function setting the module's constants to export.
   */
  public func constants(_ closure: () -> [String : Any?]) -> AnyDefinition {
    return ConstantsDefinition(constants: closure())
  }

  /**
   Factory function for methods without arguments.
   */
  public func method<R>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping () -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [],
      queue: queue,
      closure
    )
  }

  /**
   Factory function for methods with one argument.
   */
  public func method<R, A0: AnyMethodArgument>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping (A0) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self)],
      queue: queue,
      closure
    )
  }

  /**
   Factory function for methods with 2 arguments.
   */
  public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping (A0, A1) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self)],
      queue: queue,
      closure
    )
  }

  /**
   Factory function for methods with 3 arguments.
   */
  public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping (A0, A1, A2) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self)],
      queue: queue,
      closure
    )
  }

  /**
   Factory function for methods with 4 arguments.
   */
  public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping (A0, A1, A2, A3) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self)],
      queue: queue,
      closure
    )
  }

  /**
   Factory function for methods with 5 arguments.
   */
  public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping (A0, A1, A2, A3, A4) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self)],
      queue: queue,
      closure
    )
  }

  /**
   Factory function for methods with 6 arguments.
   */
  public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping (A0, A1, A2, A3, A4, A5) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self)],
      queue: queue,
      closure
    )
  }

  /**
   Factory function for methods with 7 arguments.
   */
  public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument, A6: AnyMethodArgument>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping (A0, A1, A2, A3, A4, A5, A6) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self), AnyArgumentType(A6.self)],
      queue: queue,
      closure
    )
  }

  /**
   Factory function for methods with 8 arguments.
   */
  public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument, A6: AnyMethodArgument, A7: AnyMethodArgument>(
    _ name: String,
    queue: DispatchQueue? = nil,
    _ closure: @escaping (A0, A1, A2, A3, A4, A5, A6, A7) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self), AnyArgumentType(A6.self), AnyArgumentType(A7.self)],
      queue: queue,
      closure
    )
  }

  /**
   Creates module's lifecycle listener that is called right after module initialization.
   */
  public func onCreate(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.moduleCreate, closure)
  }

  /**
   Creates module's lifecycle listener that is called when the module is about to be deallocated.
   */
  public func onDestroy(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.moduleDestroy, closure)
  }

  /**
   Creates module's lifecycle listener that is called when the app context owning the module is about to be deallocated.
   */
  public func onAppContextDestroy(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appContextDestroy, closure)
  }

  /**
   Creates a listener that is called when the client app is about to enter the foreground mode.
   */
  public func onClientAppEnterForeground(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.clientAppEnterForeground, closure)
  }

  /**
   Creates a listener that is called when the client app becomes active again.
   */
  public func onClientAppBecomeActive(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.clientAppBecomeActive, closure)
  }

  /**
   Creates a listener that is called when the client app enters the background mode.
   */
  public func onClientAppEnterBackground(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.clientAppEnterBackground, closure)
  }
}
