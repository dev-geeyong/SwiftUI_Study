//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 우승현 on 12/3/24.
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
