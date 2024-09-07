//  Created by Jordain Gijsbertha on 07/09/2024.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("tools") {
                    NavigationLink(destination: ColorSchemeView()) {
                        Text("color_scheme")
                    }
                }
            }
            .navigationTitle("settings_nav_title")
        }
    }
}

#Preview {
    SettingsView()
}
