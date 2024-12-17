//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by 정다연 on 12/6/24.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), city: "London",
                           temperature: 89, description: "Thunder Storm",
                                icon: "cloud.bolt.rain", image: "thunder",
                                                    url: thunderUrl)

    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(date: Date(), city: "London",
                    temperature: 89, description: "Thunder Storm",
                         icon: "cloud.bolt.rain", image: "thunder",
                                 url: thunderUrl)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var chosenLocation: LocationData
            
        if configuration.locations == .londonUK {
            chosenLocation = .london
        } else {
            chosenLocation = .miami
        }
        
        var entries: [WeatherEntry] = []
        var eventDate = Date()
        let halfMinute: TimeInterval = 30
    
        for var entry in chosenLocation.timeline {
            entry.date = eventDate
            eventDate += halfMinute
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        ZStack {
            Color("weatherBackgroundColor")
            HStack {
                WeatherSubView(entry: entry)
                if widgetFamily == .systemMedium {
                    Image(entry.image)
                        .resizable()
                }
            }
            .containerBackground(for: .widget) {
                Color("weatherBackgroundColor")
            }
        }
        .widgetURL(entry.url)
    }
}

struct WeatherSubView: View {
    
    var entry: WeatherEntry
    
    var body: some View {
        
        VStack {
            VStack {
                Text("\(entry.city)")
                    .font(.title)
                Image(systemName: entry.icon)
                    .font(.largeTitle)
                Text("\(entry.description)")
                    .frame(minWidth: 125, minHeight: nil)
            }
            .padding(.bottom, 2)
            .background(ContainerRelativeShape()
                       .fill(Color("weatherInsetColor")))
            Label("\(entry.temperature)°F", systemImage: "thermometer")
        }
        .foregroundColor(.white)
        .padding()
    }
}

@main
struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Weather Widget")
        .description("A demo weather widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            WeatherWidgetEntryView(entry: WeatherEntry(date: Date(),
                                                       city: "London", temperature: 89,
                                                       description: "Thunder Storm",
                                                       icon: "cloud.bolt.rain", image: "thunder",
                                                       url: thunderUrl))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    
            WeatherWidgetEntryView(entry: WeatherEntry(date: Date(),
                  city: "London", temperature: 89,
                  description: "Thunder Storm", icon: "cloud.bolt.rain",
                        image: "thunder", url: thunderUrl))
                .previewContext(WidgetPreviewContext(
                                         family: .systemMedium))
            
        }
        
    }
}
