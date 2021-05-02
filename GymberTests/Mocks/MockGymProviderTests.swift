import XCTest
import Domain
@testable import Gymber

final class MockGymProvider: GymProviderInterface {
    var completionResult: Result<[Gym], Error>!

    func getNearbyGyms(completion: @escaping (Result<[Gym], Error>) -> Void) {
        completion(completionResult)
    }
}
