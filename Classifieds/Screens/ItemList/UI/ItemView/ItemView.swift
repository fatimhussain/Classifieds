//
//  ItemView.swift
//  Classifieds
//
//  Created by Fatima on 27/11/2021.
//

import UIKit

protocol ItemDisplayable {
    var title: String? { get }
    var subTitle: String? { get }
    var description: String? { get }
    var imageUrlString: String? { get }
}

class ItemView: NibLoadedView {

    var item: ItemDisplayable? {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var imageViewThumbnail: UIImageView?
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var labelSubtitle: UILabel?
    @IBOutlet weak var labelDescription: UILabel?
}

private extension ItemView {
    
    func configureView() {
        labelTitle?.text = item?.title
        labelSubtitle?.text = item?.subTitle
        labelDescription?.text = item?.description
        imageViewThumbnail?.loadImage(from: item?.imageUrlString, placeHolderImage: UIImage(systemName: "bag"))
        imageViewThumbnail?.tintColor = .lightGray
    }
}
