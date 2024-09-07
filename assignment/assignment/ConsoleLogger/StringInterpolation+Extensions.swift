//  Created by Jordain Gijsbertha on 07/09/2024.
import Foundation

public extension String.StringInterpolation {
    /// Interpolates a lowercased UUID value into the String.
    ///
    /// The UUID.uuidString value is uppercased by default which causes issues
    /// in the case-sensitive backend that expects lowercased id values.
    /// This function makes sure that any UUID will be lowercased when interpolated into a String.
    ///
    /// - Parameter value: UUID value to be interpolated
    mutating func appendInterpolation(_ value: UUID) {
        appendInterpolation(value.uuidString.lowercased())
    }

    
    /// Interpolates an unwrapped optional value or `nil`.
    ///
    /// - Parameter value: Optional value to be interpolated
    mutating func appendInterpolation<T: CustomStringConvertible>(_ value: T?) {
        appendInterpolation(value ?? "nil" as CustomStringConvertible)
    }

    /// Interpolates pretty printed JSON Data.
    ///
    /// - Parameter json: JSDO data to be interpolated
    mutating func appendInterpolation(json data: Data?) {
        guard let jsonString = data
            .flatMap({ try? JSONSerialization.jsonObject(with: $0) })
            .flatMap({ try? JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) })
            .map({ String(decoding: $0, as: UTF8.self) })
        else {
            return
        }
        appendInterpolation(jsonString)
    }
}
