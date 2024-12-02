//
//  widgetTest.swift
//  widgetTest
//
//  Created by 윤지용 on 12/2/24.
//

import WidgetKit
import SwiftUI

/*
 Provider (TimelineProvider)

 위젯의 데이터를 제공하고 업데이트하는 역할을 합니다.
 placeholder: 위젯이 로딩될 때 보여줄 임시 데이터
 getSnapshot: 위젯 갤러리에서 보여질 미리보기
 getTimeline: 실제 위젯이 언제 어떤 데이터로 업데이트될지 결정
 
 */
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀",city: "seoul",temperature: "21")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀",city: "seoul",temperature: "21")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), emoji: "😀",city: "seoul",temperature: "21")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
    let city: String
    let temperature: String
}

struct widgetTestEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("City: \(entry.city)")
            Text("Temperature: \(entry.temperature)")
        }
    }
}

struct widgetTest: Widget {
    let kind: String = "widgetTest"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                widgetTestEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                widgetTestEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    widgetTest()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀",city: "seoul",temperature: "21")
    SimpleEntry(date: .now, emoji: "😀",city: "seoul",temperature: "21")
}
