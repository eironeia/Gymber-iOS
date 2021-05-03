import Foundation
import Domain

struct GymUIModel {
    let id: Int
    let name: String
    let imageUrl: String
    let distanceText: String

    init(gym: Gym, distanceText: String) {
        id = gym.id
        name = gym.name
        imageUrl = gym.imageUrl
        self.distanceText = distanceText
    }
}
