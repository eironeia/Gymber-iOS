import Foundation

public struct GymsDTO: Decodable {
    public let gyms: [Gym]

    enum CodingKeys: String, CodingKey {
        case gyms = "data"
    }
}
