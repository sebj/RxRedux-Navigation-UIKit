import RxSwift
import RxCocoa

final class Store<State>: StoreType {

    private let reducer: Reducer<State>
    private let relay: BehaviorRelay<State>
    private var dispatchFunction: DispatchFunction!
    private var isDispatching = false

    init(reducer: @escaping Reducer<State>, state: State, middleware: [Middleware<State>] = []) {
        self.reducer = reducer
        self.relay = BehaviorRelay(value: state)

        self.dispatchFunction = middleware
            .reduce({ [unowned self] action in
                self._defaultDispatch(action)
            }, { dispatchFunction, middleware in
                let getState = { [weak self] in self?.state }
                let dispatch: DispatchFunction = { [weak self] in self?.dispatch($0) }
                return middleware(dispatch, getState)(dispatchFunction)
            })
    }

    var state: State {
        relay.value
    }

    private func _defaultDispatch(_ action: Action) {
        guard !isDispatching else {
            fatalError("Attempted to dispatch action while a previous action is being processed. A reducer is dispatching an action, or the store is being used from multiple threads.")
        }

        isDispatching = true
        let newState = reducer(state, action)
        isDispatching = false

        relay.accept(newState)
    }

    func dispatch(_ action: Action) {
        dispatchFunction(action)
    }

    /// Subscribes to changes to the state.
    func observe<T: Equatable>(_ keyPath: KeyPath<State, T>) -> Observable<T> {
        relay
            .map { $0[keyPath: keyPath] }
            .distinctUntilChanged()
    }
}
