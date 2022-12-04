//
//  PictureDataSource.swift
//  ApodTests
//
//  Created by Sivaraj Selvaraj on 04/12/22.
//

import XCTest


class MockAPIManager: APIManager {
    
    override func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(Result<T,Error>)-> Void)
    {
        completionHandler(.success(Picmodel(title: "Stereo Mars near Opposition", hdurl: "", date: "2022-12-03", explanation: "") as! T))

    }

}

class PictureDataSourceTestCases: XCTestCase {
    
    
    private var mockAPIManager : MockAPIManager!
    private var sut : PictureDataSource!

    override func setUpWithError() throws {
        mockAPIManager = MockAPIManager()
        sut = PictureDataSource(apiManager: mockAPIManager)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockAPIManager = nil
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPicDatasFromApi_Success_Scenario()  {
        sut.getPicDatasFromApi(dateString: "2022/12/03") { result in
            
            switch(result){
            case .success(let picmodel):
                XCTAssertEqual(picmodel.title, "Stereo Mars near Opposition")
                XCTAssertEqual(picmodel.date, "2022-12-03")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
