//
//  WeatherHTTPClient.swift
//  MyWeather
//
//  Created by Willian Honda on 09/07/24.
//

import Foundation

protocol WeatherHTTPClient {
    func fetchWeather(id: Int) async throws -> WeatherData
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherData
}

struct WeatherHTTPClientImplementation: WeatherHTTPClient {
    private let apiKey = "1dd2fec9dc8d0adb65eb02b1cd337511"
    func fetchWeather(id: Int) async throws -> WeatherData {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?id=\(id)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try decodeData(data: data)
    }

    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherData {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try decodeData(data: data)
    }

    private func decodeData(data: Data) throws -> WeatherData {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherData.self, from: data)
        } catch {
            throw error
        }
    }
}
