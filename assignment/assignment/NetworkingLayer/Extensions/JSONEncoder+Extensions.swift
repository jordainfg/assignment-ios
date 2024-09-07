//  Created by Jordain Gijsbertha on 07/09/2024.

import Foundation

extension JSONEncoder {
    static var `default`: JSONEncoder {
        .default()
    }

    static func `default`(
        keyEncodingStrategy: KeyEncodingStrategy = .convertToSnakeCase,
        dateEncodingStrategy: DateEncodingStrategy = .iso8601
    ) -> JSONEncoder {
        let jsonEcoder = JSONEncoder()
        jsonEcoder.keyEncodingStrategy = keyEncodingStrategy
        jsonEcoder.dateEncodingStrategy = dateEncodingStrategy
        return jsonEcoder
    }
}
