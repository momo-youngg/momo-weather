//
//  OpenWeatherResponse.swift
//  MomoWeather
//
//  Created by momo on 2022/01/28.
//

import Foundation

struct CurrentWeatherDataResponse: Decodable, Hashable {
    
    //TODO hashable 수정하기
    func hash(into hasher: inout Hasher) {
        
    }

    static func == (lhs: CurrentWeatherDataResponse, rhs: CurrentWeatherDataResponse) -> Bool {
        return false
    }
    
    
    enum CodingKeys: String, CodingKey {
        case coord, weather, base, main, visibility, wind, clouds, dt, sys, timezone, id, name, cod
    }
    
    let coord: OpenWeatherCoord
    let weather: [OpenWeatherWeather]
    let base: String
    let main: OpenWeatherMain
    let visibility: Int
    let wind: OpenWeatherWind
    let clouds: OpenWeatherClouds
    let dt: Int
    let sys: OpenWeatherSys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coord = try container.decode(OpenWeatherCoord.self, forKey: .coord)
        weather = try container.decode([OpenWeatherWeather].self, forKey: .weather)
        base = try container.decode(String.self, forKey: .base)
        main = try container.decode(OpenWeatherMain.self, forKey: .main)
        visibility = try container.decode(Int.self, forKey: .visibility)
        wind = try container.decode(OpenWeatherWind.self, forKey: .wind)
        clouds = try container.decode(OpenWeatherClouds.self, forKey: .clouds)
        dt = try container.decode(Int.self, forKey: .dt)
        sys = try container.decode(OpenWeatherSys.self, forKey: .sys)
        timezone = try container.decode(Int.self, forKey: .timezone)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        cod = try container.decode(Int.self, forKey: .cod)
    }

}

struct OpenWeatherCoord: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case lon, lat
    }
    
    let lon: Double
    let lat: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lon = try container.decode(Double.self, forKey: .lon)
        lat = try container.decode(Double.self, forKey: .lat)
    }
}

struct OpenWeatherWeather: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id, main, description, icon
    }
    
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        main = try container.decode(String.self, forKey: .main)
        description = try container.decode(String.self, forKey: .description)
        icon = try container.decode(String.self, forKey: .icon)
    }
}

struct OpenWeatherMain: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temp = try container.decode(Double.self, forKey: .temp)
        feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        tempMin = try container.decode(Double.self, forKey: .tempMin)
        tempMax = try container.decode(Double.self, forKey: .tempMax)
        pressure = try container.decode(Int.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
    }
}

struct OpenWeatherWind: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case speed, deg
    }
    
    let speed: Double
    let deg: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speed = try container.decode(Double.self, forKey: .speed)
        deg = try container.decode(Int.self, forKey: .deg)
    }
}

struct OpenWeatherClouds: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case all
    }
    
    let all: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        all = try container.decode(Int.self, forKey: .all)
    }
}

struct OpenWeatherSys: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case type, id, country, sunrise, sunset
    }
    
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(Int.self, forKey: .type)
        id = try container.decode(Int.self, forKey: .id)
        country = try container.decode(String.self, forKey: .country)
        sunrise = try container.decode(Int.self, forKey: .sunrise)
        sunset = try container.decode(Int.self, forKey: .sunset)
    }
}

