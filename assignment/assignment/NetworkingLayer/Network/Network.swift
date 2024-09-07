//  Created by Jordain Gijsbertha on 07/09/2024.

import Alamofire
import Foundation

protocol Network: AnyObject {
    typealias DownloadDestination = DownloadRequest.Destination

    // MARK: - Request

    @discardableResult
    func request<Response: Decodable>(
        _ request: URLRequestConvertible,
        response: Response.Type,
        decoder: JSONDecoder,
        interceptor: RequestInterceptor?
    ) async throws -> Response

    func request(_ request: URLRequestConvertible, interceptor: RequestInterceptor?) async throws
}

extension Network {
    // MARK: - Request

    @discardableResult
    func request<Response: Decodable>(
        _ request: URLRequestConvertible,
        response: Response.Type = Response.self,
        decoder: JSONDecoder = .default,
        interceptor: RequestInterceptor? = nil
    ) async throws -> Response {
        try await self.request(request, response: response, decoder: decoder, interceptor: interceptor)
    }

    func request(_ request: URLRequestConvertible) async throws {
        try await self.request(request, interceptor: nil)
    }
}
