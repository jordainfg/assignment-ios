//  Created by Jordain Gijsbertha on 07/09/2024.

import Foundation

@propertyWrapper
struct Injected<Value> {
    private let keyPath: KeyPath<DependencyContainer, Value>

    init(_ keyPath: KeyPath<DependencyContainer, Value>) {
        self.keyPath = keyPath
    }

    var wrappedValue: Value {
        DependencyContainer[keyPath]
    }
}
