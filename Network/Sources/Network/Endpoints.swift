import Foundation

public enum Endpoint {
    case nearbyGyms

    public var urlRequest: URLRequest {
        var url = baseUrl
        url.appendPathComponent(path)
        var urlRequest = URLRequest(url: url)
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        urlRequest.httpMethod = httpMethod
        return urlRequest
    }

    private var baseUrl: URL {
        guard let url = URL(string: "https://api.one.fit/v2/en-nl/") else {
            preconditionFailure("Invalid URL used to create URL instance")
        }
        return url
    }

    private var path: String {
        switch self {
        case .nearbyGyms:
            return "partners/city/UTR"
        }
    }

    private var headers: [String: String] {
        let defaultHeaders = ["User-Agent": "OneFit/1.19.0"]
        return defaultHeaders
    }

    private var httpMethod: String {
        return "GET"
    }
}

