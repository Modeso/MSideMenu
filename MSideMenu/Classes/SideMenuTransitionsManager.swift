//
//  SideMenuTransitionsManager.swift
//  Pods
//
//  Created by Esraa Apady on 3/27/17.
//
//

import UIKit

/**
    SideMenuTransitionsManager:
        - Custom TransitioningDelegate object to handle present/dismiss for the side menu navigation.
 */
class SideMenuTransitionsManager: NSObject, UIViewControllerTransitioningDelegate {

    var interactor: Interactor?
    var direction: AnimationDirection = .left

    /// should return the presentation animator object
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuPresentationAnimator(self.direction)
    }
    
    /// should return the dismissal animator object
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuDismissalAnimator()
    }
    
    /// should return the intercative presentation animator object
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactor = self.interactor else {
            return nil
        }
        return interactor.hasStarted ? interactor : nil

    }
    
    /// should return the intercative dismissal animator object
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactor = self.interactor else {
            return nil
        }
        return interactor.hasStarted ? interactor : nil
    }
}


/**
    AnimationDirection
    - Enumerator to present the animation of left side or right side.
 */
enum AnimationDirection: Int {
    case left = 1
    case right = -1
}

/**
    Transition Enum
    - Enumerator to present the interaction types like dismissing and presenting.
 */
enum Transition: Int {
    case presenting
    case dismissing
    case none
}

/**
    Interactor
    - To handle user interactor with side menu while presenting or dismissing using the dragging.
 */

class Interactor: UIPercentDrivenInteractiveTransition {
    /// hold if the user dragging is started or not
    var hasStarted = false
    
    /// hold if the interactor should finish transition or cancel
    var shouldFinish = false
    
    /// hold the current transition type
    var currentTransitionType: Transition = .none
}

/**
    SideMenuPresentationAnimator:
        - Custom object to handle the dismiss custom animation of the side menu.
 */

fileprivate class SideMenuPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let direction: AnimationDirection
    
    /// custom init
    init(_ direction: AnimationDirection) {
        self.direction = direction
    }

    /// set the presentation animation duration
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let fromViewController = transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from) as? SideMenuNavigationController else {
            return 0.0
        }
        return fromViewController.presentationDuration
    }
    
    /// handle the presentation animation behaviour, by transforming the content view to the required scale, and then translate it to the required point..
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? SideMenuNavigationController  else {
            return
        }
        
        let containerView = transitionContext.containerView
        let animationDuration = self .transitionDuration(using: transitionContext)
        
        toViewController.view.alpha = 0.0
        toViewController.view.frame.origin = .zero
        containerView.addSubview(toViewController.view)
        
        let bounds = UIScreen.main.bounds
        /// get snapshot to perform the animation, because the fromViewController get's removed from the screen and it causes a flicker, so we use a screenshot to perform the animation then add the fromViewController and remove the screenshot.
        
        let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = fromViewController.view.frame
        if let snapshot = snapshot {
            containerView.addSubview(snapshot)
        }
        
        /// check if the view should have shadow...
        if fromViewController.contentViewHasShadow {
            
            fromViewController.view.applyShadow(fromViewController.contentViewShadowColor, offset: fromViewController.contentViewShadowOffset, opacity: fromViewController.contentViewShadowOpacity, radius: CGFloat(fromViewController.contentViewShadowRadius))

            snapshot?.applyShadow(fromViewController.contentViewShadowColor, offset: fromViewController.contentViewShadowOffset, opacity: fromViewController.contentViewShadowOpacity, radius: CGFloat(fromViewController.contentViewShadowRadius))
        }

        toViewController.view.transform  = CGAffineTransform(scaleX: CGFloat(fromViewController.leftSideMenuViewControllerScale),
                                                               y: CGFloat(fromViewController.leftSideMenuViewControllerScale))

        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: CGFloat(fromViewController.presentationAnimationSpringWithDamping),
                       initialSpringVelocity: CGFloat(fromViewController.presentationAnimationInitialSpringVelocity),
                       options: .allowUserInteraction,
                       animations: {
                        toViewController.view.transform  = CGAffineTransform.identity
                        toViewController.view.alpha = 1
                        fromViewController.view.alpha = fromViewController.contentViewControllerOpacity
                        snapshot?.alpha = fromViewController.view.alpha
                        /// scale to the required scale then translate the view...
                        fromViewController.view.transform  = CGAffineTransform(scaleX: fromViewController.contentViewControllerScale,
                                                                               y: fromViewController.contentViewControllerScale)
                            .translatedBy(x: bounds.size.width * fromViewController.xTranslation * CGFloat(self.direction.rawValue),
                                          y: bounds.size.height * fromViewController.yTranslation)
                        
                        snapshot?.transform  = fromViewController.view.transform
                        toViewController.view.frame = bounds

        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

            if !transitionContext.transitionWasCancelled {
                /// did presented
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
        guard let toViewController = transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to) as? SideMenuNavigationController else {
            return 0.0
        }
        return toViewController.dismissDuration
    }

    /// handle the dismiss animation behaviour, by transforming the content view to it's original scale, and then translate it to the origin point.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? SideMenuNavigationController,
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)  else {
                return
        }
        let containerView = transitionContext.containerView
        let animationDuration = self .transitionDuration(using: transitionContext)
        
        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: CGFloat(toViewController.dismissAnimationSpringWithDamping),
                       initialSpringVelocity: CGFloat(toViewController.dismissAnimationInitialSpringVelocity),
                       options: .curveEaseInOut,
                       animations: {
                        
            /// container animation
            toViewController.view.alpha = 1.0
            toViewController.view.transform  = CGAffineTransform.identity.translatedBy(x:0, y: 0)
            /// left side menu animation
            fromViewController.view.transform  = CGAffineTransform(scaleX: CGFloat(toViewController.leftSideMenuViewControllerScale),
                                                                               y: CGFloat(toViewController.leftSideMenuViewControllerScale))

        }, completion: { (finished: Bool) -> Void in
        
            /// did dismisses
            fromViewController.view.transform  = CGAffineTransform.identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

        })

    }

}
