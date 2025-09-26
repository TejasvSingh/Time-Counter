//
//  ListTests.swift
//  ListTests
//
//  Created by Tejasv Singh on 9/25/25.
//

import XCTest
@testable import List

final class TimerCellTests: XCTestCase {
    
    var timerViewController = ViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        timerViewController = ViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
   // timerViewController = nil
    }

    func testNumberOfCells() {
        XCTAssertEqual(timerViewController.timers.count, 40)
    }
    

    func testGetTimerAtIndex() {
        let timer = timerViewController.timers[5]
        XCTAssertEqual(timer.count, 0)
        XCTAssertFalse(timer.isPaused)
    }
    
    func testComparable() {
        let timer1 = TimerModel(count: 4, isPaused: true)
        let timer2 = TimerModel(count: 8, isPaused: false)
            
        XCTAssertLessThan(timer1.count, timer2.count)
        XCTAssertGreaterThan(timer2.count, timer1.count)
    }
    
    
    
    func testCellBackground_whenPaused_isDarkGray() {
        timerViewController.loadViewIfNeeded()
        timerViewController.timers[1].isPaused = true
        let cell = timerViewController.tableView(timerViewController.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell.backgroundColor, .darkGray)
    }

    func testCellBackground_whenUnpaused_isDefault() {
        timerViewController.loadViewIfNeeded()

        let cell = timerViewController.tableView(timerViewController.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        XCTAssertTrue(cell.backgroundColor == nil)
    }

}
