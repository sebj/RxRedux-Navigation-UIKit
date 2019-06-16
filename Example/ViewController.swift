import UIKit

class ViewController<ViewModel>: UIViewController, Navigatable {
    
    internal let viewModel: ViewModel

    internal var didNavigate: (() -> Void)?
    internal var didPop: (() -> Void)?

    // ...

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didNavigate?()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didPop?()
    }
}