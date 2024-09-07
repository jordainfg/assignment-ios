//  Created by Jordain Gijsbertha on 07/09/2024.

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder {
        .default()
    }

    static func `default`(
        keyDecodingStrategy: KeyDecodingStrategy = .convertFromSnakeCase,
        dateDecodingStrategy: DateDecodingStrategy = .iso8601
    ) -> JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
        jsonDecoder.dateDecodingStrategy = dateDecodingStrategy
        return jsonDecoder
    }
}
