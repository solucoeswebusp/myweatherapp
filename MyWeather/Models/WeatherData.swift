//
//  WeatherResponse.swift
//  MyWeather
//

import Foundation

struct WeatherData: Codable, Identifiable, Equatable {
    struct Coord: Codable, Equatable {
        let longitude: Double?
        let latitude: Double?

        enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }

    struct WeatherItem: Codable, Equatable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?

        var imageURL: String? {
            guard let icon else {
                return nil
            }
            return "https://openweathermap.org/img/wn/\(icon)@2x.png"
        }
    }

    struct Main: Codable, Equatable {
        let temp: Double?
        let feelsLike: Double?
        let tempMin: Double?
        let tempMax: Double?
        let pressure: Int?
        let humidity: Int?
        let seaLevel: Int?
        let grndLevel: Int?

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }

    struct Wind: Codable, Equatable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }

    struct Clouds: Codable, Equatable {
        let all: Int?
    }

    struct Sys: Codable, Equatable {
        let type: Int?
        let id: Int?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }

    let coord: Coord
    let weather: [WeatherItem]
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int
    var name: String
    let cod: Int?
}
