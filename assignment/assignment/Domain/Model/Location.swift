//  Created by Jordain Gijsbertha on 07/09/2024.

import Foundation

struct Location: Decodable, Identifiable {
    var id: String {
        UUID().uuidString
    }

    let name: String?
    let lat: Double
    let long: Double
}
