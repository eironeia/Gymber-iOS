import Foundation
import Domain

public struct SwipeProvider: APIInterface, SwipeProviderInterface {
    public init() {}

    public func swipe(type: SwipeType, id: String) {
        switch type {
        case .left: break
        case let .right(onMatch):
            // TODO: Implement match algorithm
            onMatch()
        }
    }
}
