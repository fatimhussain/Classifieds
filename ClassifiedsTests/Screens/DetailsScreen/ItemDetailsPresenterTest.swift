//
//  ItemDetailsPresenterTest.swift
//  ClassifiedsTests
//
//  Created by Fatima on 28/11/2021.
//

import XCTest
@testable import Classifieds

class ItemDetailsPresenterTest: XCTestCase {

    var sut: ItemDetailsPresenter?
    var view: ItemDetailsViewControllerSpy?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = ItemDetailsViewControllerSpy()
        let item =  Item(name: "Notebook", uid: "qwerre", price: "AED 20", createdAt: "2019-02-24 04:04:17.566515", imageIds: ["23bjb"], imageUrls: ["https://google.com"], imageUrlsThumbnails: ["https://google.com"])
        sut = ItemDetailsPresenter(with: view, item: item)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        view = nil
    }

    func testShouldCallDisplayDetails() throws {
        sut?.getItemDetails()
        XCTAssertTrue(view?.didCallDisplayDetails ?? false)
    }
    
    func testShouldCallDisplayError() throws {
        sut?.item = nil
        sut?.getItemDetails()
        XCTAssertTrue(view?.didCallDisplayError ?? false)
    }
}

class ItemDetailsViewControllerSpy: ItemDetailsDisplayable {
    var didCallDisplayDetails = false
    var didCallDisplayError = false
    
    func displayDetails(for item: Item) {
        didCallDisplayDetails = true
    }
    
    func displayError(messae: String) {
        didCallDisplayError = true
    }
}
