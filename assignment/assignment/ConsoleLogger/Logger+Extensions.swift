//  Created by Jordain Gijsbertha on 07/09/2024.

import OSLog

public extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier!

    static let network = Logger(
        subsystem: subsystem,
        category: "Network"
    )

    static let domain = Logger(
        subsystem: subsystem,
        category: "Domain"
    )

    static let ui = Logger(
        subsystem: subsystem,
        category: "UI"
    )
}
