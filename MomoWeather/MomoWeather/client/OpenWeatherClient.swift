//
//  OpenWeatherClient.swift
//  MomoWeather
//
//  Created by momo on 2022/01/28.
//

import Foundation

struct City {
    let name: String
    let description: String
}

class OpenWeatherClient {
    
    private let openWeatherBaseUrl = "https://api.openweathermap.org"
    private let apiKey: String = "68f9e68965e089052e717dac85da6b48"
    
    func getCurrentWeatherData(cityName: String,
                               completionHandler:
                               @escaping (Bool, CurrentWeatherDataResponse) -> Void) {
        get(uri: "/data/2.5/weather",
            parameters: ["q": cityName],
            responseType: CurrentWeatherDataResponse.self,
            completionHandler: completionHandler)
    }
    
    func getCities() -> [City] {
        //TODO 할수 있다면 동적으로 받아오도록 수정
        return [
            City(name: "Seoul", description: "서울")
        ]
    }
    
    private func generateUrl(uri: String, parameters: Dictionary<String, String>) -> URL? {
        guard var urlComponents = URLComponents(string: "\(openWeatherBaseUrl)\(uri)") else {
            return nil
        }
        urlComponents.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key])
        }
        urlComponents.queryItems?.append(URLQueryItem(name: "appId", value: apiKey))
        return urlComponents.url
    }
    
    private func get<T: Decodable>(uri: String,
                                   parameters: Dictionary<String, String>,
                                   responseType: T.Type,
                                   completionHandler: @escaping (Bool, T) -> Void) {
        guard let url = generateUrl(uri: uri, parameters: parameters) else {
            //TODO handling error
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                //TODO handling error
                print("error with http reqeust")
                print(error!)
                return
            }
            guard let response = response as? HTTPURLResponse, 200 == response.statusCode else {
                //TODO handling error
                print("error http status is not 200.")
                return
            }
            guard let data = data else {
                //TODO handling error
                print("error data is nil")
                return
            }
            
            do {
                let output = try JSONDecoder().decode(responseType, from: data)
                completionHandler(true, output)
            } catch {
                //TODO handling error
                print("error parsing data")
                print(error)
                return
            }
        }.resume()
    }
    
}
