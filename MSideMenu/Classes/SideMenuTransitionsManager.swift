//
//  SideMenuTransitionsManager.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import UIKit

/**
    SideMenuTransitionsManager:
        - Custom TransitioningDelegate object to handle present/dismiss for the side menu navigation.
 */

class SideMenuTransitionsManager: NSObject, UIViewControllerTransitioningDelegate {

    /// should return the presentation animator object
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuPresentationAnimator()
    }
    
    /// should return the dismissal animator object
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuDismissalAnimator()
    }
}

/**
    SideMenuPresentationAnimator:
        - Custom object to handle the dismiss custom animation of the side menu.
 */
fileprivate class SideMenuPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    /// set the presentation animation duration
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return SideMenuManager.presentationDuration
    }
    
    /// handle the presentation animation behaviour, by transforming the content view to the required scale, and then translate it to the required point..
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
        /// get snapshot to perform the animation, because the fromViewController get's removed from the screen and it causes a flicker, so we use a screenshot to perform the animation then add the fromViewController and remove the screenshot.
        
        let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = fromViewController.view.frame
        if let snapshot = snapshot {
            containerView.addSubview(snapshot)
        }
        
        /// check if the view should have shadow...
        if SideMenuManager.contentViewHasShadow {
            
            fromViewController.view.applyShadow(SideMenuManager.contentViewShadowColor, offset: SideMenuManager.contentViewShadowOffset, opacity: SideMenuManager.contentViewShadowOpacity, radius: CGFloat(SideMenuManager.contentViewShadowRadius))

            snapshot?.applyShadow(SideMenuManager.contentViewShadowColor, offset: SideMenuManager.contentViewShadowOffset, opacity: SideMenuManager.contentViewShadowOpacity, radius: CGFloat(SideMenuManager.contentViewShadowRadius))
        }

        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: CGFloat(SideMenuManager.presentationAnimationSpringWithDamping),
                       initialSpringVelocity: CGFloat(SideMenuManager.presentationAnimationInitialSpringVelocity),
                       options: .curveEaseInOut,
                       animations: {
                        
                        toViewController.view.alpha = 1
                        fromViewController.view.alpha = SideMenuManager.contentViewControllerOpacity
                        snapshot?.alpha = fromViewController.view.alpha
                        /// scale to the required scale then translate the view...
                        fromViewController.view.transform  = CGAffineTransform(scaleX: SideMenuManager.contentViewControllerScale,
                                                                               y: SideMenuManager.contentViewControllerScale)
                            .translatedBy(x: bounds.size.width * SideMenuManager.xTranslation,
                                          y: bounds.size.height * SideMenuManager.yTranslation)
                        
                        snapshot?.transform  = fromViewController.view.transform

        }) { (finished) in
            
            transitionContext.completeTransition(finished)
            if finished {
                /// add the view controller but remove the snapshot
                toViewController.view.addSubview(fromViewController.view)
                snapshot?.removeFromSuperview()
            }

        }

    }

}

/**
    SideMenuDismissalAnimator:
        - Custom object to handle the dismiss custom animation of the side menu.
 */
fileprivate class SideMenuDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    /// set the dismiss animation duration
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return SideMenuManager.dismissDuration
    }

    /// handle the dismiss animation behaviour, by transforming the content view to it's original scale, and then translate it to the origin point.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)  else {
                return
        }
        let containerView = transitionContext.containerView
        let animationDuration = self .transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: CGFloat(SideMenuManager.dismissAnimationSpringWithDamping),
                       initialSpringVelocity: CGFloat(SideMenuManager.dismissAnimationInitialSpringVelocity),
                       options: .curveEaseInOut,
                       animations: {
            toViewController.view.alpha = 1.0
            toViewController.view.transform  = CGAffineTransform.identity.translatedBy(x:0, y: 0)
        }, completion: { (finished: Bool) -> Void in
            transitionContext.completeTransition(finished)
        })

    }

}
