import Foundation
import Domain

public struct SwipeProvider: APIInterface, SwipeProviderInterface {
    public init() {}

    public func swipe(type: SwipeType, id: Int) {
        switch type {
        case .left: break
        case let .right(onMatch):
            let number = Int.random(in: 1...100)
            if number == 5 {
                onMatch(id)
            }
        }
    }
}
