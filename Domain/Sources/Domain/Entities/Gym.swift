import Foundation
import CoreLocation

public struct Gym: Decodable {
    public let id: Int
    public let name: String
    public let imageUrl: String
//    public let location: CLLocationCoordinate2D

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "header_image"
    }

    enum ImageKeys: String, CodingKey {
        case image = "mobile"
    }

    public init(from decoder: Decoder) throws {
        // id
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)

        let imageContainer = try container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        imageUrl = try imageContainer.decode(String.self, forKey: .image)
    }
}
