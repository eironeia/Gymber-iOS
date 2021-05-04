import XCTest
import Domain
@testable import Gymber

final class MockSwipeProvider: SwipeProviderInterface {
    var isMatch: Bool!

    func swipe(type: SwipeType, id: Int) {
        guard case let .right(onMatch) = type else { return }
        if isMatch { onMatch(id) }
    }
}
