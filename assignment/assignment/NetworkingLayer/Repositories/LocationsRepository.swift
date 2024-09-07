//  Created by Jordain Gijsbertha on 07/09/2024.

import Foundation

protocol LocationsRepository {
    func getLocations() async throws -> [Location]
}

actor LocationsRepositoryImpl: LocationsRepository {
    private let network: Network

    init(
        network: Network
    ) {
        self.network = network
    }

    init() {
        @Injected(\.network) var network
        self.init(
            network: network
        )
    }

    func getLocations() async throws -> [Location] {
        struct Response: Decodable {
            let locations: [Location]
        }

        let response = try await network.request(
            Route(
                .get,
                .location(.all)
            ),
            response: Response.self
        )
        return response.locations
    }
}
