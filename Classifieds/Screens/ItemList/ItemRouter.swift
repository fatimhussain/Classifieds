//
//  ItemRouter.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import UIKit

protocol ItemRoutable {
    func goToItemDetailsScreen(item: Item?, navigationController: UINavigationController?)
}

class ItemRouter: ItemRoutable {
    
    static func startItemModule() -> ItemViewController {
        
        //etension identifier
        let view = Helper.mainStoryboard.instantiateViewController(identifier: "ItemViewController") as? ItemViewController
        let router = ItemRouter()
        let interactor = ItemInteractor()
        let presenter = ItemPresenter()
        
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        view?.presenter = presenter
        
        return view ?? ItemViewController()
    }
    
    func goToItemDetailsScreen(item: Item?, navigationController: UINavigationController?) {
        guard let detailsViewController = ItemDetailsRouter.createDetailsModule(with: item) else { return }
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
