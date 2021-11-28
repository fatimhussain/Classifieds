//
//  ItemListViewControllerTest.swift
//  ClassifiedsTests
//
//  Created by Fatima on 28/11/2021.
//

import XCTest
@testable import Classifieds

class ItemListViewControllerTest: XCTestCase {

    var sut: ItemViewController?
    var presenter: ItemPresenterSpy?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //Given
        presenter = ItemPresenterSpy()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "ItemViewController") as? ItemViewController
        viewController?.presenter = presenter
        
        sut = viewController
        _ = sut?.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        presenter = nil
    }
    
    func testCanLoadView() throws {
        XCTAssertNotNil(sut, "view can load without crash")
    }

    func testShouldCallFetchItemsOnViewDidLoad() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //When
        sut?.viewDidLoad()
        
        //Then
        XCTAssertTrue(presenter?.didCallFetchItems ?? false, "viewDidLoad should ask the presenter to call fetch items")
    }
    
    func testShouldDisplayErrorMessaeOnFailure() throws {
        
        //when
        presenter?.didFetchItems(with: .failure(ItemError.failure))
        
        //Then
        DispatchQueue.main.async { [weak self] in
            XCTAssertTrue(self?.sut?.presentedViewController is UIAlertController)
            XCTAssertEqual((self?.sut?.presentedViewController as? UIAlertController)?.message, ItemError.failure.localizedDescription)
        }
    }
    
    func testShouldDisplayItemsOnSuccess() throws {
        
        //when
        let item = Item(name: "Notebook", uid: "qwerre", price: "AED 20", createdAt: "2019-02-24 04:04:17.566515", imageIds: ["23bjb"], imageUrls: ["https://google.com"], imageUrlsThumbnails: ["https://google.com"])
        let response = ItemResponse(results: [item])
        presenter?.didFetchItems(with: .success(response))
                
        //Then
        DispatchQueue.main.async { [weak self] in
            XCTAssertTrue(self?.sut?.labelEmpty?.isHidden ?? false)
            XCTAssertTrue(!(self?.sut?.tableView?.isHidden ?? true))
            XCTAssertTrue((self?.sut?.tableView?.numberOfRows(inSection: 0) ?? 0) > 0)
        }
    }
    
    func testShouldPresentDetailsScreen() throws {
        
        //when
        let item = Item(name: "Notebook", uid: "qwerre", price: "AED 20", createdAt: "2019-02-24 04:04:17.566515", imageIds: ["23bjb"], imageUrls: ["https://google.com"], imageUrlsThumbnails: ["https://google.com"])
           
        let tableView = sut?.tableView ?? UITableView()
        sut?.items = [item]
        sut?.tableView(tableView ?? UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))

        //Then
        XCTAssertTrue(presenter?.didCallPresentDetailsScreen ?? false)
    }
}

class ItemPresenterSpy: ItemPresentable {
    var view: ItemViewDisplayable?
    var interactor: ItemInteractable?
    var router: ItemRoutable?
    
    var didCallFetchItems = false
    var didCallPresentDetailsScreen = false
    
    func fetchItems() {
        didCallFetchItems = true
    }
    
    func didFetchItems(with result: Result<ItemResponse?, Error>) {
        switch result {
        case .success(let response):
            view?.displayItems(items: response?.results ?? [])
        case .failure(let error):
            view?.displayError(message: error.localizedDescription)
        }
    }
    
    func presentDetails(for item: Item, navigationController: UINavigationController?) {
        didCallPresentDetailsScreen = true
    }
}
