//  Created by Jordain Gijsbertha on 07/09/2024.

import SwiftUI

struct ColorSchemeView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        List {
            Toggle(isOn: $isDarkMode) {
                Text("endable_dark_mode")
            }
            .padding(10)
        }
        .navigationTitle("color_scheme_nav_title")
    }
}

#Preview {
    ColorSchemeView()
}
