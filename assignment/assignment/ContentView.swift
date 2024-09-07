//
//  ContentView.swift
//  assignment
//
//  Created by Jordain Gijsbertha on 07/09/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        TabView {
            PlacesView()
                .tabItem {
                    Label(String(localized: "tab_item_places"), systemImage: "mappin.circle.fill")
                }

            SettingsView()
                .tabItem {
                    Label(String(localized: "tab_item_settings"), systemImage: "gearshape.fill")
                }
        }
        .colorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
