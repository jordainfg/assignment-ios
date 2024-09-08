//  Created by Jordain Gijsbertha on 08/09/2024.

@testable import assignment
import XCTest

final class MockLocationsRepository: LocationsRepository {
    var getLocationsResult: Result<[Location], Error>?

    func getLocations() async throws -> [assignment.Location] {
        switch getLocationsResult {
        case .success(let locations):
            return locations
        case .failure(let error):
            throw error
        default:
            fatalError("please implement result")
        }
    }
}
