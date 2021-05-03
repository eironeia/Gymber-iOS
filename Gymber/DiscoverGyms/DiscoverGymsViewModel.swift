import Foundation
import Domain
import CoreLocation

enum ErrorUIType: Error {
    case somethingWentWrong
}

protocol DiscoverGymsViewModelInterface {
    func getNearbyGyms(userLocation: CLLocation, completion: @escaping DiscoverGymsViewModel.GetNearbyGymsClosure)
    func swipeLeft(id: Int)
    func swipeRight(id: Int, onMatch: @escaping (Int) -> Void)
}

struct DiscoverGymsViewModel: DiscoverGymsViewModelInterface {
    typealias GetNearbyGymsClosure = (Result<[GymUIModel], ErrorUIType>) -> Void

    let useCase: DiscoverGymsUseCase

    func getNearbyGyms(userLocation: CLLocation, completion: @escaping GetNearbyGymsClosure) {
        useCase.getNearbyGyms { result in
            switch result {
            case let .success(gyms):
                let gymsUIModel = gyms.map { gym in
                    GymUIModel(
                        gym: gym,
                        userLocation: userLocation
                    )
                }
                completion(.success(gymsUIModel))
            case let .failure(error):
                debugPrint(error) // TODO: this should be gone
                completion(.failure(.somethingWentWrong)) // TODO: This should be handled better
            }
        }
    }

    func swipeLeft(id: Int) {
        useCase.swipe(type: .left, id: id)
    }

    func swipeRight(id: Int, onMatch: @escaping (Int) -> Void) {
        useCase.swipe(type: .right(onMath: onMatch), id: id)
    }
}
