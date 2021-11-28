//
//  ItemRouterTest.swift
//  ClassifiedsTests
//
//  Created by Fatima on 28/11/2021.
//

import XCTest
@testable import Classifieds

class ItemRouterTest: XCTestCase {

    var sut: ItemRouter?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ItemRouter()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testTopVCIsItemDetailsVCWhenPresented() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let item = Item(name: "Notebook", uid: "qwerre", price: "AED 20", createdAt: "2019-02-24 04:04:17.566515", imageIds: ["23bjb"], imageUrls: ["https://google.com"], imageUrlsThumbnails: ["https://google.com"])
        let topNavigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        sut?.goToItemDetailsScreen(item: item, navigationController: topNavigationController)
        
        XCTAssertTrue(topNavigationController?.viewControllers.last is ItemDetailsViewController)
    }
    
    func testTopVCIsNotItemDetailsVCIfNoNavigationController() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let item = Item(name: "Notebook", uid: "qwerre", price: "AED 20", createdAt: "2019-02-24 04:04:17.566515", imageIds: ["23bjb"], imageUrls: ["https://google.com"], imageUrlsThumbnails: ["https://google.com"])
        let topNavigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        sut?.goToItemDetailsScreen(item: item, navigationController: nil)
        
        XCTAssertFalse(topNavigationController?.viewControllers.last is ItemListViewControllerTest)
    }
}
