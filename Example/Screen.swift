enum Screen: Equatable {
    case onboarding
    case auth
    case transactionList
    case transactionDetail(Transaction)
}