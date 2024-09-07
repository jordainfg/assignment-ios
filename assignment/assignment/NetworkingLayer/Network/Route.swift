//  Created by Jordain Gijsbertha on 07/09/2024.

import Alamofire
import Foundation

struct Route<Parameters>: URLRequestConvertible {
    private var method: HTTPMethod
    private var url: any URLConvertible
    private var parameters: Parameters?
    private var headers: HTTPHeaders?
    private var encoder: JSONEncoder?

    typealias RequestModifier = (inout URLRequest) throws -> Void
    private var requestModifier: RequestModifier?

    init(
        _ method: HTTPMethod,
        _ url: any URLConvertible,
        with parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        requestModifier: RequestModifier? = nil
    ) where Parameters == Alamofire.Parameters {
        self.method = method
        self.url = url
        self.parameters = parameters
        self.headers = headers
        self.requestModifier = requestModifier
    }

    init<T: Encodable>(
        _ method: HTTPMethod,
        _ url: any URLConvertible,
        with parameters: T,
        encoder: JSONEncoder = .default,
        headers: HTTPHeaders? = nil,
        requestModifier: RequestModifier? = nil
    ) where Parameters == AnyEncodable {
        self.method = method
        self.url = url
        self.parameters = AnyEncodable(parameters)
        self.encoder = encoder
        self.headers = headers
        self.requestModifier = requestModifier
    }

    private var parameterEncoder: ParameterEncoder {
        switch method {
        case .get, .delete, .head:
            return URLEncodedFormParameterEncoder.default
        default:
            if let encoder {
                return JSONParameterEncoder(encoder: encoder)
            } else {
                return JSONParameterEncoder.default
            }
        }
    }

    private var encoding: ParameterEncoding {
        switch method {
        case .get, .head:
            return URLEncoding(
                destination: .methodDependent,
                arrayEncoding: .noBrackets,
                boolEncoding: .literal
            )
        default:
            return JSONEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        var request = try URLRequest(
            url: url,
            method: method,
            headers: headers
        )

        try requestModifier?(&request)

        switch parameters {
        case let parameters as AnyEncodable:
            return try parameterEncoder.encode(parameters, into: request)

        case let parameters as Alamofire.Parameters:
            return try encoding.encode(request, with: parameters)

        default:
            return request
        }
    }
}
