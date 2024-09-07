//  Created by Jordain Gijsbertha on 07/09/2024.

import Alamofire
import Foundation

struct DependencyContainer {
    private static var shared = DependencyContainer()

    /// A static subscript for accessing the `value` of `InjectionKey` instances.
    static subscript<Key: InjectionKey>(key: Key.Type) -> Key.Value {
        key.value
    }

    /// A static subscript accessor for reading dependencies in the shared container.
    static subscript<Value>(_ keyPath: KeyPath<DependencyContainer, Value>) -> Value {
        shared[keyPath: keyPath]
    }
}

// MARK: - Network

extension DependencyContainer {
    private struct NetworkKey: InjectionKey {
        static let value: Network = NetworkManager(session: .default)
    }

    var network: Network {
        DependencyContainer[NetworkKey.self]
    }
}
