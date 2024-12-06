//
//  MemorizeWidgetLiveActivity.swift
//  MemorizeWidget
//
//  Created by 정다연 on 12/6/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MemorizeWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MemorizeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MemorizeWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MemorizeWidgetAttributes {
    fileprivate static var preview: MemorizeWidgetAttributes {
        MemorizeWidgetAttributes(name: "World")
    }
}

extension MemorizeWidgetAttributes.ContentState {
    fileprivate static var smiley: MemorizeWidgetAttributes.ContentState {
        MemorizeWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MemorizeWidgetAttributes.ContentState {
         MemorizeWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MemorizeWidgetAttributes.preview) {
   MemorizeWidgetLiveActivity()
} contentStates: {
    MemorizeWidgetAttributes.ContentState.smiley
    MemorizeWidgetAttributes.ContentState.starEyes
}
