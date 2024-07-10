# MV Pattern Implementation with SwiftUI

This project demonstrates an alternative architectural pattern to MVVM (Model-View-ViewModel) when working with SwiftUI applications. Instead of using separate view models for each view, this approach simplifies the architecture by allowing views to directly interact with models.

## Overview

The MV (Model-View) pattern emphasizes direct communication between views and models, eliminating the need for additional view models. This results in a more streamlined codebase, reducing complexity and maintenance overhead, especially in large-scale applications.

### Key Features

- **Modular Architecture**: The project follows a modular design philosophy, organizing components into self-contained modules. This promotes easier testing and independent maintenance of each module.
  
- **Direct View-Model Interaction**: Views are designed to interact directly with models, reducing the need for intermediary view models. This approach simplifies the code structure and enhances development efficiency.

- **SwiftUI Integration**: The pattern integrates seamlessly with SwiftUI, leveraging its declarative syntax and state management features such as `@State`, `@Binding`, and `@EnvironmentObject`.

## Implementation Details

The project includes an implementation of a simple Weather client that shows the current weather data using Open Weather Map.


Using te MV pattern, we have the model `WeatherData` the keeps the request from the Open Weather API. We also have the model `CityWeatherModel` that is responsible for keep the datasource of the `WeatherData` and fetch the request using a client (`WeatherHTTPClient`).

The app just have one screen where it does communicate with the model `CityWeatherModel` and the `LocationManager` which fetch information from the API.

There are unit tests implemented for `CityWeatherModel`.

## Getting Started
To run the project locally:

1. Clone this repository.
2. Open the project in Xcode.
3. Build and run on a simulator or device.

## Requirements

- Swift 5.0+
- Xcode 12.0+
- SwiftUI 2.0+
