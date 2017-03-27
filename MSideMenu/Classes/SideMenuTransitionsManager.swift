//
//  SideMenuTransitionsManager.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import UIKit

class SideMenuTransitionsManager: NSObject, UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuPresentationAnimator()
    }
    //
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuDismissalAnimator()
    }
}

fileprivate class SideMenuPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return SideMenuManager.presentationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)  else {
            return
        }
        
        let containerView = transitionContext.containerView

        let animationDuration = self .transitionDuration(using: transitionContext)
        
        toViewController.view.alpha = 0.0
        fromViewController.view.alpha = 1.0
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: animationDuration, animations: {
            
            toViewController.view.alpha = 1
            fromViewController.view.alpha = 0.7
            fromViewController.view.transform  = CGAffineTransform(scaleX: SideMenuManager.contentViewControllerScale, y: SideMenuManager.contentViewControllerScale).translatedBy(x: fromViewController.view.frame.size.width * SideMenuManager.xTranslation, y: fromViewController.view.frame.size.height * SideMenuManager.yTranslation)
            
        }, completion: { (finished: Bool) -> Void in
            
            transitionContext.completeTransition(finished)
            if finished {
                fromViewController.view.alpha = 0.7
                toViewController.view.addSubview(fromViewController.view)
            }
        })
        
    }
    
}

fileprivate class SideMenuDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return SideMenuManager.dismissDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)  else {
                return
        }
        let containerView = transitionContext.containerView
        let animationDuration = self .transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animationDuration, animations: {
            toViewController.view.alpha = 1.0
            toViewController.view.transform  = CGAffineTransform(scaleX: 1, y: 1.0).translatedBy(x:0, y: 0)
        }, completion: { (finished: Bool) -> Void in
            transitionContext.completeTransition(finished)
        })
        
    }
    
}
