import XCTest
import Domain
@testable import Gymber

class DiscoverGymsUseCaseTests: XCTestCase {
    var sut: DiscoverGymsUseCase!
    var mockGymProvider: MockGymProvider!
    var mockSwipeProvider: MockSwipeProvider!

    override func setUp() {
        super.setUp()
        mockGymProvider = MockGymProvider()
        mockSwipeProvider = MockSwipeProvider()
        sut = DiscoverGymsUseCase(
            gymProvider: mockGymProvider,
            swipeProvider: mockSwipeProvider
        )
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
//    func swipe(type: SwipeType, id: String, onMatch: @escaping () -> Void)

    func test_whenGetNearbyGyms_thenSuccess() {
        mockGymProvider.completionResult = .success([])
        let expectation = self.expectation(description: "Successful response called")
        sut.getNearbyGyms { result in
            switch result {
            case .success: expectation.fulfill()
            case .failure: XCTFail()
            }
        }
        waitForExpectations(timeout: 0.5)
    }

    func test_whenGetNearbyGyms_thenError() {
        mockGymProvider.completionResult = .failure(NSError())
        let expectation = self.expectation(description: "Failure response called")
        sut.getNearbyGyms { result in
            switch result {
            case .success: XCTFail()
            case .failure: expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.5)
    }

    func test_whenSwipeRight_andNoMatch_thenClosureNotTriggered() {
        mockSwipeProvider.isMatch = false
        let expectation = self.expectation(description: "Closure not triggered")
        expectation.isInverted = true

        sut.swipe(type: .right, id: "", onMatch: {
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0.5)
    }

    func test_whenSwipeRight_andIsMatch_thenClosureTriggered() {
        mockSwipeProvider.isMatch = true
        let expectation = self.expectation(description: "Closure triggered")

        sut.swipe(type: .right, id: "", onMatch: {
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0.5)
    }
}


