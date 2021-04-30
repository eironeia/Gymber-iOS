import Foundation

struct GymProvider: APIInterface {
    func getNearbyGyms(completion: @escaping (Result<GetGymsResponse, Error>) -> Void) {
        fetch(.nearbyGyms, completion: completion)
    }
}
