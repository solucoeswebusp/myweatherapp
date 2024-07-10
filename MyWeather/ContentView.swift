//
//  ContentView.swift
//  MyWeather
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var weatherModel: CityWeatherModel
    @EnvironmentObject private var locationManager: LocationManager

    @ViewBuilder
    private func cityWeatherRow(item: WeatherData) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .bold()
                if let description = item.weather.first?.description?.capitalized {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
            if let temp = item.main?.temp {
                VStack(alignment: .trailing) {
                    HStack {
                        if let imageURL = item.weather.first?.imageURL {
                            AsyncImage(url: URL(string: imageURL)){ result in
                                result.image?
                                    .resizable()
                                    .scaledToFill()
                            }
                            .frame(width: 44, height: 44)
                        }
                        Text(String(format: "%.2f°C", temp))
                            .bold()
                    }
                    HStack {
                        if let tempMin = item.main?.tempMin {
                            Image(systemName: "arrowshape.down.fill")
                                .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.blue)
                                    .font(.system(size: 12))
                            Text(String(format: "%.2f°C", tempMin))
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        if let tempMax = item.main?.tempMax {
                            Image(systemName: "arrowshape.up.fill")
                                .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.orange)
                                    .font(.system(size: 12))
                            Text(String(format: "%.2f°C", tempMax))
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
        }
    }

    private func fetchLocations() async {
        do {
            try await weatherModel.loadWeatherFromLocations(from: City.allCases)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func fetchUserLocation(coordinates: CLLocationCoordinate2D) async {
        do {
            try await weatherModel.fetchUserCoordinates(coordinates: coordinates)
        } catch {
            print(error.localizedDescription)
        }
    }

    var body: some View {
        NavigationView {
            List {
                if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
                    if let userWeatherData = weatherModel.userWeatherData {
                        Section {
                            cityWeatherRow(item: userWeatherData)
                        } header: {
                            Text("User location")
                        }
                    } else {
                        Section {
                            HStack {
                                Text("Loading weather from user location")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                Spacer()
                                ProgressView()
                            }
                        }
                    }
                }

                Section {
                    ForEach(weatherModel.weatherData) { item in
                        cityWeatherRow(item: item)
                    }
                } header: {
                    Text("Selected cities")
                }
            }
            .navigationTitle("My Weather")
            .refreshable {
                Task {
                    if let location = locationManager.location {
                        await fetchUserLocation(coordinates: location)
                    }
                    await fetchLocations()
                }
            }
            .onAppear {
                locationManager.requestAuthorization()
            }
            .task {
                await fetchLocations()
            }
            .onChange(of: locationManager.authorizationStatus) { status in
                if status == .authorizedWhenInUse || status == .authorizedAlways {
                    locationManager.requestLocation()
                }
            }
            .onChange(of: locationManager.location ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)) { coordinates in
                Task {
                    await fetchUserLocation(coordinates: coordinates)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CityWeatherModel(weatherHTTPClient: WeatherHTTPClientImplementation()))
}
