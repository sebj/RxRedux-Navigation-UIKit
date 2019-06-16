protocol Reducible {
    static func reduce(_ state: Self, _ action: Action) -> Self
}

extension Store where State: Reducible {
    convenience init(state: State, middleware: [Middleware<State>]) {
        self.init(reducer: State.reduce, state: state, middleware: middleware)
    }
}
