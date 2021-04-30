import Foundation

// MARK: - Photos
struct GetGymsResponse: Codable {
    let gyms: [Gym]

    enum CodingKeys: String, CodingKey {
        case gyms = "data"
    }
}

struct Gym: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
