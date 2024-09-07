//  Created by Jordain Gijsbertha on 07/09/2024.

import Alamofire
import Foundation
import OSLog

final class NetworkManager: Network {
    private let session: Session

    init(session: Session) {
        self.session = session
    }

    // MARK: Request

    @discardableResult
    func request<Response: Decodable>(
        _ request: URLRequestConvertible,
        response: Response.Type,
        decoder: JSONDecoder,
        interceptor: RequestInterceptor?
    ) async throws -> Response {
        let response = await session
            .request(request, interceptor: interceptor)
            .validate()
            .serializingDecodable(
                Response.self,
                automaticallyCancelling: true,
                decoder: decoder
            )
            .response

        #if DEBUG
          log(response)
        #endif

        switch response.result {
        case .success(let response):
            return response
        case .failure(let error):
            throw NetworkError(error, responseData: response.data)
        }
    }

    func request(_ request: URLRequestConvertible, interceptor: RequestInterceptor?) async throws {
        let response = await session
            .request(request, interceptor: interceptor)
            .validate()
            .serializingData(
                automaticallyCancelling: true
            )
            .response

        switch response.result {
        case .success:
            return
        case .failure(let error):
            throw NetworkError(error, responseData: response.data)
        }
    }
    
    private func log<T>(_ response: DataResponse<T, AFError>) {
        let method = "\(response.request?.urlRequest?.method?.rawValue)"
        let url = "\(response.request?.urlRequest?.url?.absoluteString.removingPercentEncoding)"
        let requestBody = "\(json: response.request?.httpBody)"
        let statusCode = "\(response.response?.statusCode)"
        let responseBody = "\(json: response.data)"

        let level = switch response.result {
        case .success:
            OSLogType.debug
        case .failure(.responseValidationFailed(.unacceptableStatusCode(let statusCode))) where statusCode >= 500:
            OSLogType.fault
        case .failure:
            OSLogType.error
        }

        let requestString = "REQUEST \(method) \(url) \(requestBody)"
        let responseString = "RESPONSE \(statusCode) \(responseBody)"

        Logger.network.log(level: level, "\(requestString)\n\(responseString)")
    }
}
