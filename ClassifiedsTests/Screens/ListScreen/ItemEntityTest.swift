//
//  ItemEntityTest.swift
//  ClassifiedsTests
//
//  Created by Fatima on 28/11/2021.
//

import XCTest
@testable import Classifieds

class ItemEntityTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testItemGetSet() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let item = Item(name: "Notebook", uid: "qwerre", price: "AED 20", createdAt: "2019-02-24 04:04:17.566515", imageIds: ["23bjb"], imageUrls: ["https://google.com"], imageUrlsThumbnails: ["https://google.com"])
        
        XCTAssertEqual(item.name, "Notebook")
        XCTAssertEqual(item.price, "AED 20")
        XCTAssertEqual(item.uid, "qwerre")
        XCTAssertEqual(item.createdAt, "2019-02-24 04:04:17.566515")
        XCTAssertEqual(item.imageIds, ["23bjb"])
        XCTAssertEqual(item.imageUrls, ["https://google.com"])
        XCTAssertEqual(item.imageUrlsThumbnails, ["https://google.com"])
    }
}
