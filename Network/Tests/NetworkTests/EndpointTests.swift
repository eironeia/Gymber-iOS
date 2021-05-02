import XCTest
@testable import Network

final class EndpointsTest: XCTestCase {
    func test_nearbyGyms() {
        let endpoint = Endpoint.nearbyGyms
        let urlRequest = endpoint.urlRequest

        XCTAssertEqual(
            urlRequest.url?.relativeString,
            "https://api.one.fit/v2/en-nl/partners/city/UTR"
        )
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["User-Agent": "OneFit/1.19.0"])
        XCTAssertEqual(urlRequest.httpMethod, "GET")
    }
}
