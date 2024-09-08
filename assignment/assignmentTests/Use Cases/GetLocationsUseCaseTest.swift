//  Created by Jordain Gijsbertha on 08/09/2024.
import XCTest
@testable import assignment

final class GetLocationsUseCaseTests: XCTestCase {
    private var sut: GetLocationsUseCase!
    private var mockLocationsRepository: MockLocationsRepository!

    override func setUp() {
        super.setUp()
        mockLocationsRepository = MockLocationsRepository()
        sut = GetLocationsUseCase(locationsRepository: mockLocationsRepository)
    }
    
    func testReturnsValidResponse() async throws {
        // Given
        mockLocationsRepository.getLocationsResult = .success(
            Bundle.main.decode([Location].self, from: "LocationsResponse.json")
        )
        
        // When
        let locations = try await sut.getLocations()
        
        // Then
        XCTAssertEqual(locations.count, 3)
    }

    func testInvalidDomainThrowsError() async throws {
        // Given
        mockLocationsRepository.getLocationsResult = .failure(GetLocationsError.invalidDomain)

        // When / Then
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to throw an error, but no error was thrown.")
        } catch let error as GetLocationsError {
            XCTAssertEqual(error, .invalidDomain)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testNotConnectedToInternetThrowsError() async throws {
        // Given
        mockLocationsRepository.getLocationsResult = .failure(GetLocationsError.notConnectedToInternet)

        // When / Then
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to throw an error, but no error was thrown.")
        } catch let error as GetLocationsError {
            XCTAssertEqual(error, .notConnectedToInternet)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testInvalidFormatThrowsError() async throws {
        // Given
        mockLocationsRepository.getLocationsResult = .failure(GetLocationsError.invalidFormat)

        // When / Then
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to throw an error, but no error was thrown.")
        } catch let error as GetLocationsError {
            XCTAssertEqual(error, .invalidFormat)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testUnexpectedErrorThrows() async throws {
        // Given
        let unexpectedError = NSError(domain: "TestDomain", code: -1, userInfo: nil)
        mockLocationsRepository.getLocationsResult = .failure(unexpectedError)

        // When / Then
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to throw an error, but no error was thrown.")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, "TestDomain")
            XCTAssertEqual(error.code, -1)
        }
    }
}
