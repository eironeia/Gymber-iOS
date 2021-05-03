import Foundation
import Domain

struct GymUIModel {
    let id: Int
    let name: String
    let imageUrl: String

    init(gym: Gym) {
        id = gym.id
        name = gym.name
        imageUrl = gym.imageUrl
    }
}
