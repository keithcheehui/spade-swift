//
//  KKAlertControllerTransition.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import Foundation

import UIKit

class KKViewControllerAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let backgroundColor: UIColor
    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init()
    }

    var duration: TimeInterval {
        return 0.3
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return transitionContext.completeTransition(false)
        }

        guard let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return transitionContext.completeTransition(false)
        }

        animateTransition(fromController, to: toController, container: transitionContext.containerView) {
            transitionContext.completeTransition($0)
        }
    }

    func animateTransition(_ from: UIViewController, to: UIViewController, container: UIView, completion: @escaping (Bool) -> Void) {
        container.addSubview(to.view)

        UIView.animate(withDuration: duration, animations: container.layoutIfNeeded, completion: completion)
    }
}

class KKAlertControllerPresentTransition: KKViewControllerAnimatedTransition {
    
    override func animateTransition(_ from: UIViewController, to: UIViewController, container: UIView, completion: @escaping (Bool) -> Void) {
        to.view.frame = container.bounds
        to.view.backgroundColor = backgroundColor.withAlphaComponent(0.4)
        to.view.transform = from.view.transform.concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
        to.view.alpha = 0
        container.addSubview(to.view)

        UIView.animate(withDuration: duration, animations: {
            to.view.transform = from.view.transform
            to.view.alpha = 1
        }, completion: completion)
    }
}

class TKKAlertControllerDismissTransition: KKViewControllerAnimatedTransition {
    override func animateTransition(_ from: UIViewController, to: UIViewController, container: UIView, completion: @escaping (Bool) -> Void) {
        container.addSubview(from.view)

        UIView.animate(withDuration: duration, animations: {
            from.view.alpha = 0
        }, completion: completion)
    }
}
