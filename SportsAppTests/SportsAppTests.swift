//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by tasneem on 4/19/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import XCTest
@testable import SportsApp

class SportsAppTests: XCTestCase {

    var realObjService : SportsApiServies!
//    var realLeaguesService : SportsApiServies!
//    var reallasteventsService : SportsApiServies!

    var mockSportsService:MockingSportsService!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        realObjService = SportsApiServies()
    //    realLeaguesService = SportsApiServies()

        mockSportsService = MockingSportsService(shouldReturnError: false)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
//    func testMockSportsService(){
//        mockSportsService.getSports(url: ""){ (sports, error) in
//        if let error = error{
//            XCTFail()
//        }else{
//            XCTAssertGreaterThan(sports!.count, 2)
//        }
//        }
//    }
    func testRealSports(){
        let expect = expectation(description: "expecting")
        realObjService.getSports(url: "https://www.thesportsdb.com/api/v1/json/1/all_sports.php") { (sports, error) in
            if let error = error{
                XCTFail()
            }else{
                expect.fulfill()
                XCTAssertEqual(sports?.sports.count, 2)
               
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

    func testRealLeagues(){
        let expect = expectation(description: "expecting")
        realObjService.getCountries(url: "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=soccer") { (leagues, error) in
            if let error = error{
                XCTFail()
            }else{
                expect.fulfill()
                XCTAssertEqual(leagues?.countrys?.count, 50)
               
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

   func testRealLastEvent(){
       let expect = expectation(description: "expecting")
       realObjService.getEvents(url: "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=4328"
       ) { (events, error) in
           if let error = error{
               XCTFail()
           }else{
               expect.fulfill()
            XCTAssertEqual(events?.events?.count, 15)
              
           }
       }
       waitForExpectations(timeout: 3, handler: nil)
   }
    
    
    func testRealTeams(){
        let expect = expectation(description: "expecting")
        realObjService.getTeams(url: "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=4328&r=10&s=2020-2021"
        ) { (teams, error) in
            if let error = error{
                XCTFail()
            }else{
                expect.fulfill()
                XCTAssertEqual(teams?.teams?.count, 20)
               
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
