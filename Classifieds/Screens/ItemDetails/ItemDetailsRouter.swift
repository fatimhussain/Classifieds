//
//  ItemDetailsRouter.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import Foundation

class ItemDetailsRouter {
    static func createDetailsModule(with item: Item?) -> ItemDetailsViewController? {
        let viewController = Helper.mainStoryboard.instantiateViewController(identifier: "ItemDetailsViewController") as? ItemDetailsViewController
        
        let presenter = ItemDetailsPresenter(with: viewController, item: item)
        viewController?.presenter = presenter
        
        return viewController
    }
}
