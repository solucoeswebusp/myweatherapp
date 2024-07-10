//
//  CityWeatherModelTests.swift
//  MyWeatherTests
//

@testable import MyWeather
import XCTest

final class CityWeatherModelTests: XCTestCase {
    @MainActor
    func test_fetch_user_coordinates() async {
        let mock = MockWeatherHTTPClient()
        let model = CityWeatherModel(weatherHTTPClient: mock)
        do {
            try await model.fetchUserCoordinates(coordinates: .init(latitude: 123, longitude: 123))
            XCTAssertEqual(model.userWeatherData, mock.weatherDataMock)
        } catch {
            XCTFail("Should fetch user coordinates")
        }
    }

    @MainActor
    func test_fetch_locations() async {
        let mock = MockWeatherHTTPClient()
        let model = CityWeatherModel(weatherHTTPClient: mock)
        do {
            try await model.loadWeatherFromLocations(from: City.allCases)
            XCTAssertFalse(model.weatherData.isEmpty)
        } catch {
            XCTFail("Should fetch user coordinates")
        }
    }
}
