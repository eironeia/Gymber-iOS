import Foundation

public protocol GymProviderInterface {
    func getNearbyGyms(completion: @escaping (Result<[Gym], Error>) -> Void)
}

// TODO: Move on different file
public protocol SwipeProviderInterface {
    func swipe(type: SwipeType, id: String, onMatch: () -> Void)
}
