import Foundation

public struct GymsDTO: Codable {
    public let gyms: [Gym]

    enum CodingKeys: String, CodingKey {
        case gyms = "data"
    }
}
