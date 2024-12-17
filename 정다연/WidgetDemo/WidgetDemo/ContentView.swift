//
//  ContentView.swift
//  WidgetDemo
//
//  Created by 정다연 on 12/6/24.
//

import SwiftUI

struct WeatherType: Hashable {
    var name: String
    var icon: String
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(value: WeatherType(name: "Hail Storm", icon: "cloud.hail")) {
                    Label ("Hail Storm", systemImage: "cloud.hail")
                }
                NavigationLink(value: WeatherType(name: "Thunder Storm", icon: "cloud.bolt.rain")) {
                    Label ("Thunder Storm", systemImage: "cloud.bolt.rain")
                }
                NavigationLink(value: WeatherType(name: "Tropical Storm", icon: "tropicalstorm")) {
                    Label ("Tropical Storm", systemImage: "tropicalstorm")
                }
            }
            .navigationDestination(for: WeatherType.self) { weather in
                WeatherDetailView(weather: weather)
            }
            .navigationTitle("Severe Weather")
        }
    }
}

#Preview {
    ContentView()
}
