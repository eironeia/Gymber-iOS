import Foundation
import Domain
import CoreLocation

struct GymUIModel {
    let id: Int
    let name: String
    let imageUrl: String
    let distanceText: String

    init(gym: Gym, userLocation: CLLocation) {
        id = gym.id
        name = gym.name
        imageUrl = gym.imageUrl
        let distance = Int(userLocation.distance(from: gym.coordinates) / 1000)
        distanceText = "\(distance) km from you"
    }
}

private extension GymUIModel {
    func getDistanceInKm(coordinate1: CLLocation, coordinate2: CLLocation) -> Double {
        coordinate1.distance(from: coordinate2) / 1000
    }
}
