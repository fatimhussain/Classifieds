//
//  ItemListTableViewCell.swift
//  Classifieds
//
//  Created by Fatima on 27/11/2021.
//

import UIKit
import AlamofireImage

class ItemListTableViewCell: UITableViewCell {

    var item: Item? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var itemView: ItemView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
}

private extension ItemListTableViewCell {
    
    func configureView() {
        itemView?.item = item
    }
}

extension Item: ItemDisplayable {
    
    var title: String? {
        return name.capitalized
    }
    
    var subTitle: String? {
        return price
    }
    
    var description: String? {
       return createdAt
    }
    
    var imageUrlString: String? {
        return imageUrlsThumbnails.first
    }
}
