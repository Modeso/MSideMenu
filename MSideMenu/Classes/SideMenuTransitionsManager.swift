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
        containerView.addSubview(toViewController.view)
        
        let bounds = UIScreen.main.bounds
        // get snapshot to do the animation..
        let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = fromViewController.view.frame
        if let snapshot = snapshot {
            containerView.addSubview(snapshot)
        }

        UIView.animate(withDuration: animationDuration, animations: {
    
            toViewController.view.alpha = 1
            fromViewController.view.alpha = SideMenuManager.contentViewControllerOpacity
            snapshot?.alpha = fromViewController.view.alpha
            
            fromViewController.view.transform  = CGAffineTransform(scaleX: SideMenuManager.contentViewControllerScale,
                                                     y: SideMenuManager.contentViewControllerScale).translatedBy(x: bounds.size.width * SideMenuManager.xTranslation,
                                                                                                                 y: bounds.size.height * SideMenuManager.yTranslation)
            
            snapshot?.transform  = fromViewController.view.transform

        }, completion: { (finished: Bool) -> Void in
            
            transitionContext.completeTransition(finished)
            if finished {
                // add the view controller but remove the snapshot
                toViewController.view.addSubview(fromViewController.view)
                snapshot?.removeFromSuperview()
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
