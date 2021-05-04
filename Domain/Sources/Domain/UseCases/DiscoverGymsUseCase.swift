import Foundation

public protocol DiscoverGymsUseCaseInterface {
    func getNearbyGyms(completion: @escaping DiscoverGymsUseCase.GetNearbyGymsClosure)
    func swipe(type: SwipeType, id: Int)
}

public struct DiscoverGymsUseCase: DiscoverGymsUseCaseInterface {
    public typealias GetNearbyGymsClosure = (Result<[Gym], Error>) -> Void

    private let gymProvider: GymProviderInterface
    private let swipeProvider: SwipeProviderInterface

    public init(
        gymProvider: GymProviderInterface,
        swipeProvider: SwipeProviderInterface
    ) {
        self.gymProvider = gymProvider
        self.swipeProvider = swipeProvider
    }

    public func getNearbyGyms(completion: @escaping GetNearbyGymsClosure) {
        gymProvider.getNearbyGyms(completion: completion)
    }

    public func swipe(type: SwipeType, id: Int) {
        swipeProvider.swipe(type: type, id: id)
    }
}
