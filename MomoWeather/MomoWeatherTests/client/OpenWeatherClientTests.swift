//
//  OpenWeatherClientTests.swift
//  MomoWeatherTests
//
//  Created by momo on 2022/01/29.
//
import XCTest
@testable import MomoWeather

class OpenWeatherClientTests: XCTestCase {
    
    var sut: OpenWeatherClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = OpenWeatherClient()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_getCurrentWeatherData() throws {
        // given
        let promise = expectation(description: "서울의 날씨 정보를 잘 응답 받아야 한다")
        let cityName = "Seoul"
        
        // when
        sut.getCurrentWeatherData(cityName: cityName) { result, response in            
            //then
            XCTAssertTrue(result)
            XCTAssertNotNil(response.coord.lon)
            XCTAssertNotNil(response.coord.lat)
            XCTAssertGreaterThan(response.weather.count, 0)
            XCTAssertEqual(response.name, cityName)
            XCTAssertNotNil(response.main.temp)
            XCTAssertNotNil(response.main.feelsLike)
            XCTAssertNotNil(response.main.tempMin)
            XCTAssertNotNil(response.main.tempMax)
            XCTAssertNotNil(response.main.pressure)
            XCTAssertNotNil(response.main.humidity)
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 2)
    }

}
