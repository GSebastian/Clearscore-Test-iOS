//
//  UIStackView+Utils.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import UIKit

extension UIStackView {
    
    func setChild(_ view: UIView) {
        guard !(arrangedSubviews.contains(view) && arrangedSubviews.count == 1) else { return }
        arrangedSubviews.forEach({ $0.removeFromSuperview() })
        addArrangedSubview(view)
    }
}
