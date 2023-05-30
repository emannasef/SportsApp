//
//  SportsTests.swift
//  SportsTests
//
//  Created by Mac on 19/05/2023.
//

import XCTest
@testable import Sports

final class SportsTests: XCTestCase {

    var apiFtech = APIFetch()
    var details = LeagueDetailsViewController()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testFetchDataLeagues(){
        let exp = expectation(description: "waiting Api to load  data")
        
        apiFtech.fetchData(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=8e7a8271ecb0fa21b1dcf5e30d55c51bda2eadf99f709a8d2bb89a6594bdcd7a") {  (root:Root?, err) in
            
            if err != nil {
                XCTFail()
                XCTAssertNil(root)
                XCTAssertEqual(root?.result.count,5)
            }else{
                XCTAssertNotNil(root)
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
        
    }
    
    
    
    func testFetchDataUpComming(){
        let exp = expectation(description: "waiting Api to load  data")
        
        apiFtech.fetchData(url: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=3&from=2023-05-23&to=2023-06-23&APIkey=8e7a8271ecb0fa21b1dcf5e30d55c51bda2eadf99f709a8d2bb89a6594bdcd7a") { (root:LeagueRoot?, err) in
            
            if err != nil {
                XCTFail()
                XCTAssertNil(root)
                XCTAssertEqual(root?.result?.count,5)
            }else{
                XCTAssertNotNil(root)
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
        
    }
    
    
    
    func testgetTeam(){
        details.getTeam()
        
        XCTAssertNotNil(details.teamArr)
        
      //  var re = details.upCommingArr + details.latestResultArr
      //  XCTAssertEqual(details.teamArr, re)
        
    }
    
//    func testdateForCurrentEvents(){
//        XCTAssertEqual(Utlies.futureTime!,"2023-06-30")
//    }

}

