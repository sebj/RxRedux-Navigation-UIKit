final class OnboardingViewModel {
    private let dispatch: DispatchFunction

    init(dispatch: @escaping DispatchFunction) {
        self.dispatch = dispatch
    }

    // ...

    func didComplete() {
        // ...
        dispatch(NavigationAction.push(screen: .auth))
    }
}

final class AuthViewModel {
    // ...

    func didComplete() {
        // ...
        dispatch(NavigationAction.replace(screen: .transactionList))
    }
}

final class TransactionsViewModel {
    // ...

    func didPressTransaction(_ transaction: Transaction) {
        // ...
        dispatch(NavigationAction.push(screen: .transactionDetail(transaction)))
    }
}