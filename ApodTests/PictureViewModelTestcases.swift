//
//  PictureViewModelTestcases.swift
//  ApodTests
//
//  Created by Sivaraj Selvaraj on 04/12/22.
//

import XCTest

class MockDataSource : PictureDataSourceProtocol {
        
    func getPicDatasFromApi(dateString: String, completion: @escaping (Result<Picmodel, Error>) -> Void) {
        if (dateString == "2022/12/03") {
            completion(.success(Picmodel(title: "Stereo Mars near Opposition", hdurl: "https://apod.nasa.gov/apod/image/2212/Mars-Stereo.png", date: "2022-12-03", explanation: "Mars looks sharp in these two rooftop telescope views captured in late November from Singapore")))
        }else{
            completion(.failure(MyError.apiError))
        }
    }
}

class MockViewModelDelegate : PictureViewModelDelegate {
    
    var updateViewArray: [Picmodel] = []
    
    func dataToDispaly(picModel: Picmodel) {
        updateViewArray.append(picModel)
    }
    
    
}

class PictureViewModelTestcases: XCTestCase {
    
    private var sut : PictureViewModel!
    private var dataSource : MockDataSource!
    private var delegate: MockViewModelDelegate!

    override func setUpWithError() throws {
        
        dataSource = MockDataSource()
        sut = PictureViewModel(dataSource: dataSource, dateString: Constants.Max_Date)
        delegate = MockViewModelDelegate()
        sut.delegate = delegate
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        
        sut = nil
        dataSource = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_GetPicDetails_Success_Scenario()  {
        
        // when
        sut.getPicDetails(date: "2022/12/03")
        
        // then
        XCTAssertEqual(delegate.updateViewArray.count, 1)
        XCTAssertEqual(delegate.updateViewArray[0].title, "Stereo Mars near Opposition")
        XCTAssertEqual(delegate.updateViewArray[0].date, "2022-12-03")
        
    }
    
    func test_GetPicDetails_failure_Scenario()  {
        
        // when
        sut.getPicDetails(date: "2022/11/03")
        
        // then
        XCTAssertEqual(delegate.updateViewArray.count, 0)
    }


}
