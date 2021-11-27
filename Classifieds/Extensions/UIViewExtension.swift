//
//  UIViewExtension.swift
//  Classifieds
//
//  Created by Fatima on 27/11/2021.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}

extension UIView {
    
    @discardableResult
    func loadFromNib<T: UIView>() -> T? {
        let type = type(of: self)
        guard let contentView = Bundle(for: type).loadNibNamed(String(describing: type), owner: self, options: nil)?.first as? T else {
            
            // xib not loaded or its top view is not the correct type
            return nil
        }
        
        addSubview(contentView)
        contentView.fillInSuperView(view: self)
        
        return contentView
    }
    
    func fillInSuperView(view: UIView, margin: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: margin).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: margin).isActive = true
    }
}
