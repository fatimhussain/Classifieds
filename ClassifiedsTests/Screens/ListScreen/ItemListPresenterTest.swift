//
//  ItemListPresenterTest.swift
//  ClassifiedsTests
//
//  Created by Fatima on 28/11/2021.
//

import XCTest
@testable import Classifieds

class ItemListPresenterTest: XCTestCase {
    
    var sut: ItemPresenter?
    var interactor: ItemInteractorSpy?
    var viewController: ItemViewControllerSpy?
    var router: ItemRouterSpy?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //Given
        viewController = ItemViewControllerSpy()
        interactor = ItemInteractorSpy()
        router = ItemRouterSpy()
        
        sut = ItemPresenter()
        sut?.interactor = interactor
        sut?.view = viewController
        sut?.router = router
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        interactor = nil
        viewController = nil
    }
    
    func testShouldCallGetItems() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //When
        sut?.fetchItems()
        
        //Then
        XCTAssertTrue(interactor?.didCallGetItems ?? false, "fetchItems() should call getItems")
    }
    
    func testShouldDisplayItemsOnSuccess() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //When
        sut?.didFetchItems(with: .success(ItemResponse()))
        
        //Then
        XCTAssertTrue(viewController?.didCallDisplayItems ?? false, "should call displayItems(items:)")
    }
    
    func testShouldDisplayItemsOnFailure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //When
        sut?.didFetchItems(with: .failure(ItemError.failure))
        
        //Then
        XCTAssertTrue(viewController?.didCallDisplayError ?? false, "should call displayError(messae:)")
    }
    
    func testShouldDisplayDetailsScreen() throws {
        
        //When
        let item = Item(name: "Notebook", uid: "qwerre", price: "AED 20", createdAt: "2019-02-24 04:04:17.566515", imageIds: ["23bjb"], imageUrls: ["https://google.com"], imageUrlsThumbnails: ["https://google.com"])
        sut?.presentDetails(for: item, navigationController: nil)
        
        //Then
        XCTAssertTrue(router?.didCallGoToDetailsScreen ?? false, "should call goToItemDetailsScreen(item:navigationController)")
    }
}

class ItemViewControllerSpy: ItemViewDisplayable {
    
    var didCallDisplayItems = false
    var didCallDisplayError = false
    
    func displayItems(items: [Item]) {
        didCallDisplayItems = true
    }
    
    func displayError(message: String) {
        didCallDisplayError = true
    }
    
    func displayDetails(for item: Item) {}
}

class ItemInteractorSpy: ItemInteractable {
    var presenter: ItemPresentable?
    var didCallGetItems = false
    
    func getItems() {
        didCallGetItems = true
    }
}

class ItemRouterSpy: ItemRoutable {
    var didCallGoToDetailsScreen = false
    
    func goToItemDetailsScreen(item: Item?, navigationController: UINavigationController?) {
        didCallGoToDetailsScreen = true
    }
}
