import UIKit
import RxSwift

protocol ViewControllerPresenter: class {
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

extension UINavigationController: ViewControllerPresenter {}

// TODO: Could this be a middleware?
final class Router {

    typealias ViewControllerFactory = (Screen) -> UIViewController

    private let viewControllerFactory: ViewControllerFactory
    private let dispatch: DispatchFunction
    private weak var presenter: ViewControllerPresenter?
    private let disposeBag = DisposeBag()

    private var lastScreenHierarchy: [Screen] = []

    init(
        viewControllerFactory: @escaping ViewControllerFactory,
        dispatch: @escaping DispatchFunction,
        navigationState: Observable<NavigationState>,
        presenter: ViewControllerPresenter)
    {
        self.viewControllerFactory = viewControllerFactory
        self.dispatch = dispatch
        self.presenter = presenter

        navigationState
            .subscribe(onNext: { [weak self] state in
                self?.route(to: state.screenHierarchy, animated: state.animated)
            })
            .disposed(by: disposeBag)
    }

    private func route(to screenHierarchy: [Screen], animated: Bool) {
        guard screenHierarchy != lastScreenHierarchy else {
            return
        }

        guard screenHierarchy != lastScreenHierarchy.dropLast() else {
            lastScreenHierarchy = lastScreenHierarchy.dropLast()
            return
        }

        guard let presenter = presenter else {
            return
        }

        guard !screenHierarchy.isEmpty else {
            return presenter.setViewControllers([], animated: animated)
        }

        let newScreen = screenHierarchy.last!
        let newViewController = viewControllerFactory(newScreen)
        if var navigatable = newViewController as? UIViewController & Navigatable {
            navigatable.didPop = { [weak self] in
                self?.dispatch(NavigationAction.didPop(screen: newScreen))
            }

            navigatable.didNavigate = { [weak self] in
                self?.dispatch(NavigationAction.didNavigate)
            }

            presenter.pushViewController(navigatable, animated: animated)

        } else {
            presenter.pushViewController(newViewController, animated: animated)
        }

        lastScreenHierarchy = screenHierarchy
    }
}
