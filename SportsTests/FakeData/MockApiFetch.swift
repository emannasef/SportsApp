//
//  MockApiFetch.swift
//  SportsTests
//
//  Created by Mac on 23/05/2023.
//

import XCTest
@testable import Sports

final class MockApiFetch: XCTestCase {
    
    let fakeApiFetch = FakApiFetch(haveAnError: false)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testFetchDataLeagues(){
        
      //  let res = Root.result
        
        fakeApiFetch.fetchData(url: "") { res , err  in
            if (err != nil ) == false {
                XCTAssertNotNil(res)
            }else{
                XCTFail()
            }
        }
        
    }
  
}
