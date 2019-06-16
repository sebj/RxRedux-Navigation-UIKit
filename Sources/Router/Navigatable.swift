protocol Navigatable {
    /// Navigation to this view has completed
    /// - Note: This is likely to be viewDidAppear for a UIViewController
    var didNavigate: (() -> Void)? { get set }

    /// The user has initiated a backwards navigation event
    /// - Note: This is likely to be viewDidDisappear for a UIViewController
    var didPop: (() -> Void)? { get set }
}