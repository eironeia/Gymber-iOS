import Foundation
import Domain

enum ErrorUIType: Error {
    case somethingWentWrong
}

protocol DiscoverGymsViewModelInterface {
    func getNearbyGyms(completion: @escaping DiscoverGymsViewModel.GetNearbyGymsClosure)
    func swipe(type: SwipeType, id: String, onMatch: @escaping () -> Void)
}

struct DiscoverGymsViewModel: DiscoverGymsViewModelInterface {
    typealias GetNearbyGymsClosure = (Result<[GymUIModel], ErrorUIType>) -> Void

    let useCase: DiscoverGymsUseCase

    func getNearbyGyms(completion: @escaping GetNearbyGymsClosure) {
        useCase.getNearbyGyms { result in
            switch result {
            case let .success(gyms):
                let gymsUIModel = gyms.map(GymUIModel.init(gym:))
                completion(.success(gymsUIModel))
            case let .failure(error):
                debugPrint(error) // TODO: this should be gone
                completion(.failure(.somethingWentWrong)) // TODO: This should be handled better
            }
        }
    }

    func swipe(type: SwipeType, id: String, onMatch: @escaping () -> Void) {

    }
}
