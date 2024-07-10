//
//  MockWeatherClient.swift
//  MyWeatherTests
//
//  Created by Willian Honda on 10/07/24.
//

@testable import MyWeather
import Foundation

struct MockWeatherHTTPClient: WeatherHTTPClient {
    let weatherDataMock = WeatherData(
        coord: WeatherData.Coord(longitude: -122.08, latitude: 37.39),
        weather: [
            WeatherData.WeatherItem(id: 801, main: "Clouds", description: "few clouds", icon: "02d")
        ],
        base: "stations",
        main: WeatherData.Main(
            temp: 290.92,
            feelsLike: 289.74,
            tempMin: 289.82,
            tempMax: 292.04,
            pressure: 1013,
            humidity: 62,
            seaLevel: nil,
            grndLevel: nil
        ),
        visibility: 10000,
        wind: WeatherData.Wind(speed: 5.1, deg: 210, gust: 6.2),
        clouds: WeatherData.Clouds(all: 20),
        dt: 1609344000,
        sys: WeatherData.Sys(
            type: nil,
            id: 5311,
            country: "US",
            sunrise: 1609327100,
            sunset: 1609366650
        ),
        timezone: -28800,
        id: 420006353,
        name: "Mountain View",
        cod: 200
    )

    func fetchWeather(id: Int) async throws -> MyWeather.WeatherData {
        return weatherDataMock
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> MyWeather.WeatherData {
        return weatherDataMock
    }
    
}

