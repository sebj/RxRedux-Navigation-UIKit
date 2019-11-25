public struct Thunk<State>: Action {
    public typealias Body = (_ getState: @escaping GetStateFunction<State>, _ dispatch: @escaping DispatchFunction) -> Void

    let body: Body

    public init(_ body: @escaping Body) {
        self.body = body
    }
}

public func createThunksMiddleware<State>() -> Middleware<State> {
    { dispatch, getState in
        { next in 
            { action in
                switch action {
                case let thunk as Thunk<State>:
                    thunk.body(getState, dispatch)
                default:
                    next(action)
                }
            }
        }
    }
}
