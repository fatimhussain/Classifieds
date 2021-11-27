//
//  ItemPresenter.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import UIKit

protocol ItemPresentable: AnyObject {
    var view: ItemViewDisplayable? { get set }
    var interactor: ItemInteractable? { get set }
    var router: ItemRoutable? { get set }
    func fetchItems()
    func didFetchItems(with result: Result<ItemResponse?, Error>)
    func presentDetails(for item: Item, navigationController: UINavigationController?)
}

class ItemPresenter: ItemPresentable {    
    weak var view: ItemViewDisplayable?
    var interactor: ItemInteractable?
    var router: ItemRoutable?
    
    func fetchItems() {
        interactor?.getItems()
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
        router?.goToItemDetailsScreen(item: item, navigationController: navigationController)
    }
}
