//
//  ItemDetailsViewControllerTest.swift
//  ClassifiedsTests
//
//  Created by Fatima on 28/11/2021.
//

import XCTest
@testable import Classifieds

class ItemDetailsViewControllerTest: XCTestCase {

    var sut: ItemDetailsViewController?
    var presenter: ItemDetailsPresenterSpy?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = ItemDetailsPresenterSpy()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "ItemDetailsViewController") as? ItemDetailsViewController
        viewController?.presenter = presenter
        
        sut = viewController
        _ = sut?.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        presenter = nil
    }

    func testShouldCallGetDetailsOnViewDidLoadAndItemIsNotSet() throws {
        sut?.viewDidLoad()
        
        XCTAssertTrue(presenter?.didCallGetItemDetails ?? false, "Should call getItemDetails() on viewDidLoad")
        
        DispatchQueue.main.async { [weak self] in
            XCTAssertTrue(self?.sut?.presentedViewController is UIAlertController)
            XCTAssertEqual((self?.sut?.presentedViewController as? UIAlertController)?.message, "Some error")
        }
    }
    
    func testDisplayDetailsOnViewDidLoadWhenItemIsSet() throws {
        presenter?.item = Item(name: "Notebook", uid: "qwerre", price: "AED 20", createdAt: "2019-02-24 04:04:17.566515", imageIds: ["23bjb"], imageUrls: ["https://google.com"], imageUrlsThumbnails: ["https://google.com"])
        sut?.viewDidLoad()
        
        XCTAssertTrue(presenter?.didCallGetItemDetails ?? false, "Should call getItemDetails() on viewDidLoad")
        
        DispatchQueue.main.async { [weak self] in
            XCTAssertEqual(self?.sut?.viewItem?.labelTitle?.text, self?.presenter?.item?.title)
            XCTAssertEqual(self?.sut?.viewItem?.labelSubtitle?.text, self?.presenter?.item?.subTitle)
            XCTAssertEqual(self?.sut?.viewItem?.labelDescription?.text, self?.presenter?.item?.description)
        }
    }
}

class ItemDetailsPresenterSpy: ItemDetailsPresentable {
    var view: ItemDetailsDisplayable?
    var item: Item?
    var didCallGetItemDetails = false
    
    func getItemDetails() {
        didCallGetItemDetails = true
        if let itemDetails = item {
            view?.displayDetails(for: itemDetails)
        } else {
            view?.displayError(messae: "Some error")
        }
    }
}
