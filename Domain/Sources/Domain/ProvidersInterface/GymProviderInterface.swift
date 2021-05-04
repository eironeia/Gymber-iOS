import Foundation

public protocol GymProviderInterface {
    func getNearbyGyms(completion: @escaping (Result<[Gym], Error>) -> Void)
}

public protocol SwipeProviderInterface {
    func swipe(type: SwipeType, id: Int)
}
