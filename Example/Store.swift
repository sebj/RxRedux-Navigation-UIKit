let loggingMiddleware: Middleware<AppState> = { dispatch, getState in
    { next in 
        { action in
            print("> Action: \(String(describing: action))")
            return next(action)
        }
    }
}

let middleware: [Middleware<AppState>] = [loggingMiddleware]
let store = Store<AppState>(reducer: AppState.reduce, state: AppState(), middleware: middleware)

let router = Router(
    viewControllerFactory: self.viewController,
    dispatch: store.dispatch,
    navigationState: store.observe(\AppState.navigation),
    presenter: ...
)