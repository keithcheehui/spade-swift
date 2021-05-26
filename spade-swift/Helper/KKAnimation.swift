//
//  KKAnimation.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/05/2021.
//

import UIKit

class KKAnimation: NSObject {
    class func animationSpring(_ viewToAnimate: UIView) {
        viewToAnimate.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(
            withDuration: 1,
            delay: 0.0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.2,
            options: .curveEaseIn,
            animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            },
            completion: nil)
    }
}
