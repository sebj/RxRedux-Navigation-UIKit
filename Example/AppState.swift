struct AppState {
    var navigation = NavigationState(
        animated: false,
        screenHierarchy: [],
        isAnimating: false
    )
    
    var auth: AuthState = ...
}

extension AppState: Reducible {
    static func reduce(_ state: AppState, _ action: Action) -> AppState {
        return AppState(
            navigation: NavigationState.reduce(state, action),
            auth: AuthState.reduce(state, action)
        )
    }
}