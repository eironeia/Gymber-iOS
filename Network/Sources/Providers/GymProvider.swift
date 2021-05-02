import Foundation
import Domain

struct GymProvider: APIInterface, GymProviderInterface {
    func getNearbyGyms(completion: @escaping (Result<[Gym], Error>) -> Void) {
        fetch(.nearbyGyms) { (result: (Result<GymsDTO, Error>)) in
            switch result {
            case let .success(gymsDTO):
                completion(.success(gymsDTO.gyms))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
