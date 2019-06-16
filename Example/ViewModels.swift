final class OnboardingViewModel {
    private let dispatch: DispatchFunction

    init(dispatch: @escaping DispatchFunction) {
        self.dispatch = dispatch
    }

    // ...

    func didComplete() {
        // ...
        dispatch(NavigationAction.push(.auth))
    }
}

final class AuthViewModel {
    // ...

    func didComplete() {
        // ...
        dispatch(NavigationAction.replace(.transactionList))
    }
}

final class TransactionsViewModel {
    // ...

    func didPressTransaction(_ transaction: Transaction) {
        // ...
        dispatch(NavigationAction.push(.transactionDetail(transaction)))
    }
}