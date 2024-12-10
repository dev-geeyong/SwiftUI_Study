//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by 정다연 on 12/6/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(
            date: Date(),
            city: "London",
            temperature: 89,
            description: "Thunder Storm",
            icon: "cloud.bolt.rain",
            image: "thunder"
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WeatherEntry {
        let entry = WeatherEntry(
            date: Date(),
            city: "London",
            temperature: 89,
            description: "Thunder Storm",
            icon: "cloud.bolt.rain",
            image: "thunder"
        )
        
        return entry
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<WeatherEntry> {
        // 초기에 런던의 타임라인을 반환
        // interval마다 콘텐츠를 변경
        var entries: [WeatherEntry] = []
        var eventDate = Date()
        let interval: TimeInterval = 5
        for var entry in londonTimeline {
            entry.date = eventDate
            eventDate += interval
            entries.append(entry)
        }

        // 첫번째 타임라인이 끌날 때 새로운 타임라인을 요청하지 않음
        return Timeline(entries: entries, policy: .never)
    }
}


struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            WeatherSubView(entry: entry)
        }
        .containerBackground(for: .widget) {
            Color("weatherBackgroundColor")
        }
    }
}

struct WeatherSubView: View { 
    var entry: WeatherEntry
    
    var body: some View {
        VStack {
            VStack {
                Text("\(entry.city)")
                    .font(.title)
                Image (systemName: entry.icon)
                    .font(.largeTitle)
                Text("\(entry.description)")
                    .frame(minWidth: 125, minHeight: nil)
            }
            .padding(.bottom, 2)
            .background(ContainerRelativeShape().fill(Color("weatherInsetColor")))
            Label("\(entry.temperature)ºF", systemImage: "thermometer")
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidgetEntryView(entry: WeatherEntry(date: Date(),
                                                   city: "London",
                                                   temperature: 89,
                                                   description: "Thunder Storm",
                                                   icon: "cloud.bolt.rain",
                                                   image: "thunder"))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
        
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationAppIntent
//}

//#Preview(as: .systemSmall) {
//    WeatherWidget()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
//}
