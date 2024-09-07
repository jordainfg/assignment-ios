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
                    dismissButton: .default(Text("alert_dismiss_button"))
                )
            }
            .navigationTitle(Text("places_view_navigation_title"))
        }
    }

    private func getLocations() async {
        do {
            locations = try await getLocationsUseCase.getLocations()
        } catch let error as GetLocationsError {
            handleGetLocationsError(error)
        } catch {
            alert = WikiPlacesAlert(
                title: String(localized: "alert_unknown_error_title"),
                description: String(localized: "alert_unknown_error_description")
            )
        }
    }

    private func handleGetLocationsError(_ error: GetLocationsError) {
        switch error {
        case .invalidDomain:
            alert = WikiPlacesAlert(
                title: String(localized: "alert_invalid_domain_title"),
                description: String(localized: "alert_invalid_domain_description")
            )
        case .notConnectedToInternet:
            alert = WikiPlacesAlert(
                title: String(localized: "alert_no_internet_title"),
                description: String(localized: "alert_no_internet_description")
            )
        case .invalidFormat:
            alert = WikiPlacesAlert(
                title: String(localized: "alert_invalid_format_title"),
                description: String(localized: "alert_invalid_format_description")
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
                        Text(location.name ?? String(localized: "location_unknown"))
                            .font(.headline)

                        HStack(spacing: 20) {
                            VStack(alignment:.leading) {
                                Text("location_latitude")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                Text("\(location.lat)")
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(alignment:.leading) {
                                Text("location_longitude")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                Text("\(location.long)")
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                            }
                        }
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
