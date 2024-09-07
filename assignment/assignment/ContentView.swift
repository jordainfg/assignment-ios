//
//  ContentView.swift
//  assignment
//
//  Created by Jordain Gijsbertha on 07/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PlacesView()
                .tabItem {
                    Label(String(localized: "tab_item_places"), systemImage: "mappin.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
