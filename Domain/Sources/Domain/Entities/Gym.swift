import Foundation

public struct Gym: Codable {
    public let id: Int
    public let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
