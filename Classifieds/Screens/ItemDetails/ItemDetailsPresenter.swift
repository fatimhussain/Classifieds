//
//  ItemDetailsPresenter.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import Foundation

protocol ItemDetailsPresentable {
    var view: ItemDetailsDisplayable? { get set }
    var item: Item? { get set }
    func getItemDetails()
}

class ItemDetailsPresenter: ItemDetailsPresentable {
   weak var view: ItemDetailsDisplayable?
    var item: Item?
    
    init(with view: ItemDetailsDisplayable?, item: Item?) {
        self.view = view
        self.item = item
    }
    
    func getItemDetails() {
        guard let item = item else {
            view?.displayError(messae: "No details are available")
            return
        }
        view?.displayDetails(for: item)
    }
}
