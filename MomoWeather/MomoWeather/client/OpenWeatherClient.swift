//
//  OpenWeatherClient.swift
//  MomoWeather
//
//  Created by momo on 2022/01/28.
//

import Foundation

struct City {
    let nameInKorean: String
    let id: Int
}

class OpenWeatherClient {
    
    private let openWeatherBaseUrl = "https://api.openweathermap.org"
    private let apiKey: String = "68f9e68965e089052e717dac85da6b48"
    
    func getCurrentWeatherData(city: City,
                               completionHandler:
                               @escaping (Bool, CurrentWeatherDataResponse) -> Void) {
        get(uri: "/data/2.5/weather",
            parameters: ["id": String(city.id)],
            responseType: CurrentWeatherDataResponse.self,
            completionHandler: completionHandler)
    }
    
    func getCities() -> [City] {
        //TODO 할수 있다면 동적으로 받아오도록 수정
        return [
            City(nameInKorean: "공주", id: 1842616),
            City(nameInKorean: "광주(전라남도)", id: 1841808),
            City(nameInKorean: "구미", id: 1842225),
            City(nameInKorean: "군산", id: 1842025),
            City(nameInKorean: "대구", id: 1835327),
            City(nameInKorean: "대전", id: 1835224),
            City(nameInKorean: "목포", id: 1841066),
            City(nameInKorean: "부산", id: 1838519),
            City(nameInKorean: "서산", id: 1835895),
            City(nameInKorean: "서울", id: 1835847),
            City(nameInKorean: "속초", id: 1836553),
            City(nameInKorean: "수원", id: 1835553),
            City(nameInKorean: "순천", id: 1835648),
            City(nameInKorean: "울산", id: 1833742),
            City(nameInKorean: "익산", id: 1843491),
            City(nameInKorean: "전주", id: 1845457),
            City(nameInKorean: "제주시", id: 1846266),
            City(nameInKorean: "천안", id: 1845759),
            City(nameInKorean: "청주", id: 1845033),
            City(nameInKorean: "춘천", id: 1845136),
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
//        urlComponents.queryItems?.append(URLQueryItem(name: "lang", value: "kr"))
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
