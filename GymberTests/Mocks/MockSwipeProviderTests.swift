import XCTest
import Domain
@testable import Gymber

final class MockSwipeProvider: SwipeProviderInterface {
    var isMatch: Bool!

    func swipe(type: SwipeType, id: String, onMatch: () -> Void) {
        if isMatch { onMatch() }
    }
}
