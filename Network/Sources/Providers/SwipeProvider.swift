import Foundation
import Domain

protocol SwipeProviderInterface {
    func swipe(type: SwipeType, id: String, onMatch: () -> Void)
}

struct SwipeProvider: APIInterface {
    func swipe(type: SwipeType, id: String, onMatch: () -> Void) {
        switch type {
        case .left: break
        case .right:
            // TODO: Implement match algorithm
            onMatch()
        }
    }
}
