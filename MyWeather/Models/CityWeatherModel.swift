//
//  CityWeatherModel.swift
//  MyWeather
//
//  Created by Willian Honda on 09/07/24.
//

import CoreLocation
import Foundation

enum City: String, CaseIterable {
    case buenosAires
    case london
    case montevideo

    var coordinates: CLLocationCoordinate2D {
        switch self {
        case .buenosAires:
            return CLLocationCoordinate2D(latitude: -34.603722, longitude: -58.381592)
        case .london:
            return CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)
        case .montevideo:
            return CLLocationCoordinate2D(latitude: -34.9011, longitude: -56.1645)
        }
    }

    var id: Int {
        switch self {
        case .buenosAires:
            return 3435910
        case .london:
            return 2643743
        case .montevideo:
            return 3441575
        }
    }
}

@MainActor
class CityWeatherModel: ObservableObject {

    private var weatherHTTPClient: WeatherHTTPClient

    init(weatherHTTPClient: WeatherHTTPClient) {
        self.weatherHTTPClient = weatherHTTPClient
    }

    @Published var userWeatherData: WeatherData?
    @Published var weatherData: [WeatherData] = []

    func fetchUserCoordinates(coordinates: CLLocationCoordinate2D) async throws {
        userWeatherData = try await self.weatherHTTPClient.fetchWeather(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }

    func loadWeatherFromLocations(from cities: [City]) async throws {
        try await withThrowingTaskGroup(of: WeatherData.self) { taskGroup in
            for city in cities {
                taskGroup.addTask {
                    let data = try await self.weatherHTTPClient.fetchWeather(id: city.id)
                    return data
                }
            }
            for try await result in taskGroup {
                if let index = weatherData.firstIndex(where: { $0.id == result.id }) {
                    self.weatherData[index] = result
                } else {
                    self.weatherData.append(result)
                }
            }
            self.weatherData.sort { $0.name < $1.name }
        }
    }
}
