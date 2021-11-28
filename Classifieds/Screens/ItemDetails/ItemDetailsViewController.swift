//
//  ItemDetailsViewController.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import UIKit

protocol ItemDetailsDisplayable: AnyObject {
    func displayDetails(for item: Item)
    func displayError(messae: String)
}

class ItemDetailsViewController: UIViewController {
    var presenter: ItemDetailsPresentable?
    
    @IBOutlet weak var viewItem: ItemView?
    @IBOutlet weak var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        presenter?.getItemDetails()
    }
}

extension ItemDetailsViewController: ItemDetailsDisplayable {
    
    func displayDetails(for item: Item) {
        viewItem?.item = item
        imageView?.loadImage(from: item.imageUrls.first, placeHolderImage: UIImage(systemName: "bag"))
        imageView?.tintColor = .lightGray
    }
    
    func displayError(messae: String) {
        Alert.showErrorMessage(message: messae)
    }
}
