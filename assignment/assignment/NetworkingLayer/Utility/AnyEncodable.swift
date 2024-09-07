//  Created by Jordain Gijsbertha on 07/09/2024.

struct AnyEncodable: Encodable {
    private var encodable: Encodable

    init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
