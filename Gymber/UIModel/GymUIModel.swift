import Foundation
import Domain

struct GymUIModel {
    let id: Int
    let name: String

    init(gym: Gym) {
        id = gym.id
        name = gym.name
    }
}
