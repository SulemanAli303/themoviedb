//
//  Test_project_themoviedbTests.swift
//  Test project themoviedbTests
//
//  Created by Suleman on 14/10/2021.
//

import XCTest
@testable import Test_project_themoviedb

class Test_project_themoviedbTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testValidApiCallGetsHTTPStatusCode200() throws {
      // given
        let promise = expectation(description: "Status code: 200")
        ApiManager.getRequest(with: APPURL.popularMovies, parameters: ["api_key":APPURL.api_key,"page":1], completion: {
            result in
            switch result {
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                XCTFail("Status code: \(error.code)")
                return
                
            case .success(result: _):
                promise.fulfill()
                break
            }})
    

      // 3
      wait(for: [promise], timeout: 5)
    }
    func testValidApiCallGetsHTTPStatusCode401() throws {
      // given
        let promise = expectation(description: "Status code: 401")
        ApiManager.getRequest(with: APPURL.popularMovies, parameters: ["api_key":APPURL.api_key + "2","page":1], completion: {
            result in
            switch result {
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                XCTFail("Status code: \(error.code)")
                return
                
            case .success(result: _):
                promise.fulfill()
                break
            }})
    

      // 3
      wait(for: [promise], timeout: 15)
    }
    func testValidApiCallGetsHTTPStatusCode404() throws {
      // given
        let promise = expectation(description: "Status code: 404")
        ApiManager.getRequest(with: APPURL.popularMovies, parameters: ["api_key":APPURL.api_key,"page":0], completion: {
            result in
            switch result {
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                XCTFail("Status code: \(error.code)")
                return
                
            case .success(result: _):
                promise.fulfill()
                break
            }})
    

      // 3
      wait(for: [promise], timeout: 15)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
