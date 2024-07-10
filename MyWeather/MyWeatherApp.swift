//
//  MyWeatherApp.swift
//  MyWeather
//

import SwiftUI

@main
struct MyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentScreen()
                .environmentObject(CityWeatherModel(weatherHTTPClient: WeatherHTTPClientImplementation()))
                .environmentObject(LocationManager())
        }
    }
}
