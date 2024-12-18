//
//  MemorizeData.swift
//  Widget+Memorize09
//
//  Created by 정다연 on 12/6/24.
//

import Foundation
import WidgetKit

struct MemorizeEntry: TimelineEntry {
    var date: Date
    let city: String
    let temperature: Int
    let description: String 
    let icon: String
    let image: String
}
