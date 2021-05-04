import XCTest
import Domain
import CoreLocation
@testable import Gymber

final class MockDiscoverGymsUseCase: DiscoverGymsUseCaseInterface {
    var getNearbyGymsResult: Result<[Gym], Error>!
    func getNearbyGyms(completion: @escaping DiscoverGymsUseCase.GetNearbyGymsClosure) {
        completion(getNearbyGymsResult)
    }

    var swipeTimesCalled: UInt = 0
    func swipe(type: SwipeType, id: Int) {
        swipeTimesCalled += 1
        switch type {
        case let .right(onMatch):
            onMatch(id)
        case .left:
            break
        }
    }
}

class DiscoverGymsViewModelTests: XCTestCase {
    var sut: DiscoverGymsViewModel!
    var mockUseCase: MockDiscoverGymsUseCase!

    override func setUp() {
        super.setUp()

        mockUseCase = MockDiscoverGymsUseCase()
        sut = DiscoverGymsViewModel(useCase: mockUseCase)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_whenGetNearbyGyms_andSuccess_thenReturnUIModel() {
        let expectation = self.expectation(description: "Successful response called")
        let location = CLLocation(latitude: 52.0907374, longitude: 5.1214201)
        let gym = Gym(
            id: 1,
            name: "Gym name",
            imageUrl: "www.google.com",
            coordinates: location
        )

        mockUseCase.getNearbyGymsResult = .success([gym])

        sut.getNearbyGyms(userLocation: location) { result in
            switch result {
            case let .success(uiModels):
                let expectedUIModels = [GymUIModel(gym: gym, userLocation: location)]
                XCTAssertEqual(uiModels, expectedUIModels)
                expectation.fulfill()
            case .failure: XCTFail()
            }
        }

        waitForExpectations(timeout: 0.5)
    }

    func test_whenGetNearbyGyms_andFailure_thenReturnErrorUIModel() {
        let expectation = self.expectation(description: "Failure response called")
        let location = CLLocation(latitude: 52.0907374, longitude: 5.1214201)

        mockUseCase.getNearbyGymsResult = .failure(
            NSError(domain: "Error", code: 1, userInfo: nil)
        )

        sut.getNearbyGyms(userLocation: location) { result in
            switch result {
            case .success: XCTFail()
            case let .failure(error):
                XCTAssertEqual(error, .somethingWentWrong)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 0.5)
    }

    func test_whenSwipeLeft_thenUseCaseCalled() {
        sut.swipeLeft(id: 1)
        XCTAssertEqual(mockUseCase.swipeTimesCalled, 1)
    }

    func test_whenSwipeRight_thenOnMatchCalled() {
        let expectation = self.expectation(description: "Successful onMatch called")

        sut.swipeRight(id: 1) { id in
            XCTAssertEqual(id, 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.5)
    }
}

extension GymUIModel: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

