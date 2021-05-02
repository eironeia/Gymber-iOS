import Foundation
import Domain

protocol DiscoverGymsUseCaseInterface {
    func getNearbyGyms(completion: @escaping DiscoverGymsUseCase.GetNearbyGymsClosure)
    func swipe(type: SwipeType, id: String, onMatch: @escaping () -> Void)
}

struct DiscoverGymsUseCase: DiscoverGymsUseCaseInterface {
    typealias GetNearbyGymsClosure = (Result<[Gym],Error>) -> Void
    
    let gymProvider: GymProviderInterface
    let swipeProvider: SwipeProviderInterface

    func getNearbyGyms(completion: @escaping GetNearbyGymsClosure) {
        gymProvider.getNearbyGyms(completion: completion)
    }

    func swipe(type: SwipeType, id: String, onMatch: @escaping () -> Void) {
        swipeProvider.swipe(type: type, id: id, onMatch: onMatch)
    }
}
