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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = OpenWeatherClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
