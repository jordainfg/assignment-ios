//  Created by Jordain Gijsbertha on 07/09/2024.
import Foundation
import UIKit

extension URL {
    static var abnAmro: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.main.infoDictionary?["ABN_AMRO_API_HOST"] as? String
        return components.url!
    }
    
    static var wikipedia: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.main.infoDictionary?["WIKIPEDIA_API_HOST"] as? String
        return components.url!
    }
}

