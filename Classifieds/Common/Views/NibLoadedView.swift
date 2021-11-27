//
//  NibLoadedView.swift
//  Classifieds
//
//  Created by Fatima on 27/11/2021.
//

import UIKit

class NibLoadedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
        setup()
    }
    
    func setup() {
        //subclass should override it if needed
    }
}
