//
//  MyWeatherApp.swift
//  MyWeather
//

import SwiftUI

@main
struct MyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CityWeatherModel(weatherHTTPClient: WeatherHTTPClientImplementation()))
                .environmentObject(LocationManager())
        }
    }
}
