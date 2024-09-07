//  Created by Jordain Gijsbertha on 07/09/2024.

import Alamofire
import Foundation

enum EndpointError: Error {
    case invalidURL
}

struct Endpoint: URLConvertible {
    let baseURL: URL
    let path: String
    var queryItems: [URLQueryItem]?

    func asURL() throws -> URL {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.path = path
        components?.queryItems = queryItems
        guard let url = components?.url else {
            throw EndpointError.invalidURL
        }
        return url
    }
}

extension URLConvertible where Self == Endpoint {
    static func location(_ location: Endpoint.Location, with queryItems: [URLQueryItem]? = nil) -> Endpoint {
        Endpoint(baseURL: .abnAmro, path: location.path, queryItems: queryItems)
    }
}

extension Endpoint {
    // MARK: - Locations

    enum Location {
        case all

        var path: String {
            switch self {
            case .all:
                "/abnamrocoesd/assignment-ios/main/locations.json"
            }
        }
    }
}
