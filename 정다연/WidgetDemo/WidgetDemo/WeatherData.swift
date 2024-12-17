//
//  WeatherData.swift
//  WidgetDemo
//
//  Created by 정다연 on 12/6/24.
//

import Foundation
import WidgetKit

struct WeatherEntry: TimelineEntry {
    var date: Date
    let city: String
    let temperature: Int
    let description: String
    let icon: String
    let image: String
    let url: URL?
}

let hailUrl = URL(string: "weatherwidget://hail")
let thunderUrl = URL(string: "weatherwidget://thunder'")
let tropicalUrl = URL(string: "weatherwidget://tropical")

let londonTimeline = [
    WeatherEntry(
        date: Date(),
        city: "London",
        temperature: 87,
        description: "Hail Storm",
        icon: "cloud.hail",
        image: "hail",
        url: hailUrl
    ),
    WeatherEntry(
        date: Date(),
        city: "London",
        temperature: 92,
        description: "Thunder Storm", 
        icon: "cloud.bolt.rain",
        image: "thunder",
        url: thunderUrl
    ),
    WeatherEntry(
        date: Date(),
        city: "London",
        temperature: 95,
        description: "Hail Storm",
        icon: "cloud.hail",
        image: "hail",
        url: hailUrl
    )
]

let miamiTimeline = [
    WeatherEntry(
        date: Date(),
        city: "Miami",
        temperature: 81,
        description: "Thunder Storm",
        icon: "cloud.bolt.rain",
        image: "thunder",
        url: thunderUrl
    ),
    WeatherEntry(
        date: Date(),
        city: "Miami",
        temperature: 74,
        description: "Tropical Storm",
        icon: "tropicalstorm",
        image: "tropical",
        url: tropicalUrl
    ),
    WeatherEntry(
        date: Date(),
        city: "Miami",
        temperature: 72,
        description: "Thunder Storm",
        icon: "cloud.bolt.rain",
        image: "thunder",
        url: thunderUrl
    )
]
