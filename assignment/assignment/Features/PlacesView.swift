//  Created by Jordain Gijsbertha on 07/09/2024.

import SwiftUI

struct PlacesView: View {
    @State var locations: [Location] = []
    @State private var alert: WikiPlacesAlert? = nil

    private let getLocationsUseCase = GetLocationsUseCase()

    var body: some View {
        NavigationStack {
            List(locations, id: \.id) { location in
                LocationRow(location: location)
            }
            .task {
                await getLocations()
            }
            .refreshable {
                await getLocations()
            }
            .alert(item: $alert) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.description),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
            .navigationTitle("Wikipedia Places")
        }
    }
    
    private func getLocations() async {
        do {
            locations = try await getLocationsUseCase.getLocations()
        } catch let error as GetLocationsError {
            handleGetLocationsError(error)
        } catch {
            alert = WikiPlacesAlert(
                title: "Unknown Error",
                description: "An unexpected error occurred. Please try again later."
            )
        }
    }

    private func handleGetLocationsError(_ error: GetLocationsError) {
        switch error {
        case .invalidDomain:
            alert = WikiPlacesAlert(
                title: "Invalid Domain",
                description: "The server could not be found. Please check the domain or try again later."
            )
        case .notConnectedToInternet:
            alert = WikiPlacesAlert(
                title: "No Internet Connection",
                description: "You appear to be offline. Please check your internet connection and try again."
            )
        case .invalidFormat:
            alert = WikiPlacesAlert(
                title: "Invalid Data Format",
                description: "The data received from the server is in an unexpected format. Please contact support."
            )
        }
    }

    struct LocationRow: View {
        @Environment(\.openURL) var openURL

        let location: Location

        var body: some View {
            Button(action: placeButtonAction) {
                HStack(spacing: 20) {
                    Image(systemName: "mappin.circle.fill")
                    VStack(alignment: .leading) {
                        Text(location.name ?? "Unknown")
                            .fontWeight(.bold)

                        Text("Latitude: \(location.lat)")
                            .font(.subheadline)

                        Text("Longitude: \(location.long)")
                            .font(.subheadline)
                    }
                }
            }
            .buttonStyle(.plain)
        }

        private func placeButtonAction() {
            let queryItems = [
                URLQueryItem(name: "longitude", value: "\(location.long)"),
                URLQueryItem(name: "latitude", value: "\(location.lat)")
            ]
            
            if var components = URLComponents(url: URL.wikipedia, resolvingAgainstBaseURL: false) {
                components.path = "/wiki/places"
                components.queryItems = queryItems
                
                if let url = components.url {
                    openURL(url)
                } else {
                    print("Invalid URL: \(components)")
                }
            }
        }
    }
}

#Preview {
    PlacesView()
}
