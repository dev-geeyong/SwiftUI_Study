//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 정다연 on 12/6/24.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetLiveActivity()
    }
}
