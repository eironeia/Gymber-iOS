import Foundation
import CoreLocation

struct GymLocation: Decodable {
    let latitude: Float
    let longitude: Float

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

public struct Gym: Decodable {
    public let id: Int
    public let name: String
    public let imageUrl: String
    public let coordinates: CLLocation

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "header_image"
        case location = "locations"
    }

    enum ImageKeys: String, CodingKey {
        case image = "mobile"
    }

    enum LocationKeys: String, CodingKey {
        case latitude
        case longitude
    }

    public init(from decoder: Decoder) throws {
        // id
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)

        let imageContainer = try container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        imageUrl = try imageContainer.decode(String.self, forKey: .image)

        var locationContainer = try container.nestedUnkeyedContainer(forKey: .location)
        if !locationContainer.isAtEnd {
            let nestedLocationContainer = try locationContainer.nestedContainer(keyedBy: LocationKeys.self)
            let latitude = try nestedLocationContainer.decode(Double.self, forKey: .latitude)
            let longitude = try nestedLocationContainer.decode(Double.self, forKey: .longitude)
            coordinates = CLLocation(latitude: latitude, longitude: longitude)
        } else {
            // TODO: Fake location if no location provided
            coordinates = CLLocation(latitude: 52.0907374, longitude: 5.1214201)
        }
    }
}
