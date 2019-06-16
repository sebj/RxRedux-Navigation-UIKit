struct NavigationState: Equatable {
    var animated: Bool
    var screenHierarchy: [Screen]
    var isAnimating: Bool
}

// MARK: - Actions
enum NavigationAction: Action {
    case replace(screen: Screen, animated: Bool)
    case push(screen: Screen, animated: Bool)

    case didNavigate
    case didPop(screen: Screen)
}

extension NavigationAction {
    static func replace(with screen: Screen, animated: Bool = false) -> NavigationAction {
        return .replace(screen: screen, animated: animated)
    }

    static func push(_ screen: Screen, animated: Bool = true) -> NavigationAction {
        return .push(screen: screen, animated: animated)
    }
}

// MARK: - Reducer
extension NavigationState {
    static func reduce(_ state: AppState, _ action: Action) -> NavigationState {
        var state = state.navigation

        switch action {
        case NavigationAction.didNavigate:
            state.isAnimating = false

        case let NavigationAction.didPop(screen):
            if state.screenHierarchy.last == screen {
                state.screenHierarchy = state.screenHierarchy.dropLast()
            }

        case let NavigationAction.replace(screen, animated):
            return NavigationState(
                animated: animated,
                screenHierarchy: [screen],
                isAnimating: true
            )

        case let NavigationAction.push(screen, animated):
            return NavigationState(
                animated: animated,
                screenHierarchy: state.screenHierarchy + [screen],
                isAnimating: true
            )

        case _ as SignOutAction:
            return NavigationState(
                animated: false,
                screenHierarchy: [.auth],
                isAnimating: false
            )

        default: ()
        }

        return state
    }
}
