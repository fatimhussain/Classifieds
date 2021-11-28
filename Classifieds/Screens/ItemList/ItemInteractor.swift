//
//  ItemInteractor.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import Foundation

protocol ItemInteractable {
    var presenter: ItemPresentable? { get set }
    func getItems()
}

class ItemInteractor: ItemInteractable {
   weak var presenter: ItemPresentable?
    
    func getItems() {
        APIManager.shared.loadItems { [weak self] (itemResponse, error) in
            guard error == nil else {
                self?.presenter?.didFetchItems(with: .failure(error!))
                return
            }
            
            self?.presenter?.didFetchItems(with: .success(itemResponse))
        }
    }
}
