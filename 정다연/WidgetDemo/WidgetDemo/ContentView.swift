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
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
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
            .onOpenURL(perform: { url in
                if !path.isEmpty {
                    path.removeLast(path.count)
                }
                
                if url == hailUrl {
                    path.append(WeatherType(name: "Hail Storm", icon: "cloud.hail"))
                } else if url == thunderUrl {
                    path.append(WeatherType(name: "Thunder Storm", icon: "cloud.bolt.rain"))
                } else if url == tropicalUrl {
                    path.append(WeatherType(name: "Tropical Storm", icon: "tropicalstorm"))
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
