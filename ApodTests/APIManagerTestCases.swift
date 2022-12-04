//
//  APIManagerTestCases.swift
//  ApodTests
//
//  Created by Sivaraj Selvaraj on 04/12/22.
//

import XCTest

class APIManagerTestCases: XCTestCase {
    
    private var sut : APIManager!

    override func setUpWithError() throws {
        sut = APIManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetApi_Success_Scenario()  {
        
        let exp = expectation(description: "wait for Async response")
        sut.getApiData(requestUrl: URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2022-12-03")!, resultType: Picmodel.self) { result in
            switch(result){
            case .success(let picmodel):
                XCTAssertEqual(picmodel.title, "Stereo Mars near Opposition")
                XCTAssertEqual(picmodel.date, "2022-12-03")
                exp.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 25)
    }
    
    func testGetApi_Failure_Scenario()  {
        
        let exp = expectation(description: "wait for Async response")
        sut.getApiData(requestUrl: URL(string: "https://google.com/badpage")!, resultType: Picmodel.self) { result in
            switch(result){
            case .success(let picmodel):
                print(picmodel)
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
                exp.fulfill()
            }
        }
        self.waitForExpectations(timeout: 25)
    }

    

}
