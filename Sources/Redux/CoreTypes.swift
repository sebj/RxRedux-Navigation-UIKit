public protocol Action {}

public typealias DispatchFunction = (Action) -> Void

public typealias GetStateFunction<State> = () -> State?

public typealias Middleware<State> = (@escaping DispatchFunction, @escaping GetStateFunction<State>)
    -> (@escaping DispatchFunction) -> DispatchFunction

public typealias Reducer<State> = (_ state: State, _ action: Action) -> State
