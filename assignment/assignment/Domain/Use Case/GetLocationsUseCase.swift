//  Created by Jordain Gijsbertha on 07/09/2024.

import Foundation

enum GetLocationsError: Error {
    case invalidDomain
    case notConnectedToInternet
    case invalidFormat

    init(_ error: Error) throws {
        switch error {
        case NetworkError.unacceptableStatusCode(let statusCode, _) where statusCode == 404:
            self = .invalidDomain
        case NetworkError.notConnectedToInternet:
            self = .notConnectedToInternet
        case NetworkError.responseDecodingFailed:
            self = .invalidFormat
        default:
            throw error
        }
    }
}

struct GetLocationsUseCase {
    private let locationsRepository: LocationsRepository

    init(
        locationsRepository: LocationsRepository
    ) {
        self.locationsRepository = locationsRepository
    }

    init() {
        @Injected(\.locationsRepository) var locationsRepository
        self.init(
            locationsRepository: locationsRepository
        )
    }

    func getLocations() async throws -> [Location] {
        do {
            return try await locationsRepository.getLocations()
        } catch {
            throw try GetLocationsError(error)
        }
    }
}
