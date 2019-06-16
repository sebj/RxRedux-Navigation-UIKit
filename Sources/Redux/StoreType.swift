import RxSwift

protocol StoreType {
    associatedtype State

    var state: State { get }

    /// Dispatches an action to trigger a state change.
    func dispatch(_ action: Action)

    /// Subscribes to changes to the state.
    func observe<T: Equatable>(_ keyPath: KeyPath<State, T>) -> Observable<T>
}