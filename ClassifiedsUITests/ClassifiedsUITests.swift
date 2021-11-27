//
//  ClassifiedsUITests.swift
//  ClassifiedsUITests
//
//  Created by Fatima on 26/11/2021.
//

import XCTest

class ClassifiedsUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDisplayingItemListAndDetailsScreen() {
        app.launch()
        
        // Make sure we're displaying Item list
        XCTAssertTrue(app.isDisplayingItemListScreen)
        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "wait 5 sec")], timeout: 5.0)
        if app.tables["itemListTableView"].cells.count > 0 {
            app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
            
            // Make sure we're displaying Item details screen
            XCTAssertTrue(app.isDisplayingItemDetailsScreen)
        }
    }
}

extension XCUIApplication {
    var isDisplayingItemListScreen: Bool {
        return otherElements["homeView"].exists
    }
    
    var isDisplayingItemDetailsScreen: Bool {
        return otherElements["detailsView"].exists
    }
}
