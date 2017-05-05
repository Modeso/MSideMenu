//
//  SideMenuNavigationController+Actions.swift
//  Pods
//
//  Created by Esraa Apady on 3/28/17.
//
//

import Foundation

/// This extension is created to handle action related to the side menu presenting and dismissing.

// MARK: - Actions

extension SideMenuNavigationController {
    
    /**
        This method is used to handle clicking on the left menu button in the navigation controller.
        It checks if the side menu is presented, then close the side menu, and if it's not presented, persent the side menu with the custom transition
     */
    func didTapLeftSideMenu() {
        
        guard let _  = self.presentedViewController else {
            
            // present the left side menu...
            self.tapGesture?.isEnabled = self.shouldDismissOnTappingContentVC
            // add gesture for the visible view controller
            guard let sideMenuVC = self.leftSideMenuViewController else {
                return
            }
            transitionDelegate.direction = .left
            self.present(sideMenuVC, animated: true, completion: nil)
            
            return
        }
        self.closeSideMenu()
    }
    
    /**
        This method is used to handle clicking on the right menu button in the navigation controller.
        It checks if the side menu is presented, then close the side menu, and if it's not presented, persent the side menu with the custom transition
     */

    func didTapRightSideMenu() {
        
        guard let _  = self.presentedViewController else {
            
            // present the left side menu...
            self.tapGesture?.isEnabled = self.shouldDismissOnTappingContentVC
            // add gesture for the visible view controller
            guard let sideMenuVC = self.rightSideMenuViewController else {
                return
            }
            transitionDelegate.direction = .right
            self.present(sideMenuVC, animated: true, completion: nil)

            return
        }
        self.closeSideMenu()
    }

    /**
        This method is used to handle dragging the view controller to present or dismiss.
     */
    @objc func handleDragGesture(sender: UIPanGestureRecognizer) {
        
        let percentThreshold:CGFloat = 0.0
        
        /// get the transition type
        var isDismissing = false
        
        if interactor.currentTransitionType == .none {
            interactor.currentTransitionType = self.presentedViewController != nil ? .dismissing : .presenting
        }
        isDismissing = interactor.currentTransitionType == .dismissing

        /// get translaion in x-direction
        let translation = sender.translation(in: view)
        
        print("isDismissing \(isDismissing) translation \(translation.x)")
        

        if !isDismissing && translation.x < 0  || isDismissing && translation.x > 0 {
            // 
            if isDismissing && self.presentedViewController == self.leftSideMenuViewController {
                return
            }
            // handle right side
            transitionDelegate.direction = .right
            var horizontalMovement = isDismissing ? Double(-1 * abs(translation.x)) : Double(abs(translation.x))
            horizontalMovement = horizontalMovement / Double(view.bounds.width)
            
            let movement = fmaxf(Float(abs(horizontalMovement)), 0.0)
            let movementPercent = fminf(movement, 1.0)
            let progress = CGFloat(movementPercent) * 0.5


            
            switch sender.state {
                
            case .began:
                
                if isDismissing {
                    interactor.hasStarted = true
                    dismiss(animated: true, completion: nil)
                }
                
            case .changed:
                
                interactor.shouldFinish = progress > percentThreshold
                if !isDismissing {
                    /// to handle moving right by finger, not left
                    if let sideMenuVC = self.rightSideMenuViewController, horizontalMovement > 0, !interactor.hasStarted {
                        interactor.hasStarted = true
                        self.present(sideMenuVC, animated: true, completion: nil)
                    }
                }
                
                interactor.update(progress)
                
            case .cancelled:
                
                interactor.hasStarted = false
                interactor.cancel()
                
            case .ended:
                
                interactor.hasStarted = false
                interactor.currentTransitionType = .none
                interactor.shouldFinish ?  interactor.finish() : interactor.cancel()
                tapGesture?.isEnabled = self.presentedViewController != nil;
                
            default:
                break
            }

        }else {
            // handle left side
            /// calculate the horizontal movement.
            transitionDelegate.direction = .left

            var horizontalMovement = isDismissing ? Double(-1 * translation.x) : Double(translation.x)
            horizontalMovement = horizontalMovement / Double(view.bounds.width)
            
            let movement = fmaxf(Float(horizontalMovement), 0.0)
            let movementPercent = fminf(movement, 1.0)
            let progress = CGFloat(movementPercent) * 0.5
            

            switch sender.state {
                
            case .began:
                
                if isDismissing {
                    interactor.hasStarted = true
                    dismiss(animated: true, completion: nil)
                }
                
            case .changed:
                
                interactor.shouldFinish = progress > percentThreshold
                if !isDismissing {
                    /// to handle moving right by finger, not left
                    if let sideMenuVC = self.leftSideMenuViewController, horizontalMovement > 0, !interactor.hasStarted {
                        interactor.hasStarted = true
                        self.present(sideMenuVC, animated: true, completion: nil)
                    }
                }
                if horizontalMovement > 0 {
                    interactor.update(progress)
                }
                
            case .cancelled:
                
                interactor.hasStarted = false
                interactor.cancel()
                
            case .ended:
                
                interactor.hasStarted = false
                interactor.currentTransitionType = .none
                interactor.shouldFinish ?  interactor.finish() : interactor.cancel()
                tapGesture?.isEnabled = self.presentedViewController != nil;
                
            default:
                break
            }

        }
    }
    
    /**
        This method is used to close the side menu.
     */
    open func closeSideMenu() {
        
        guard let presented = self.presentedViewController else {
            return
        }
        self.tapGesture?.isEnabled = false
        presented.dismiss(animated: true, completion: nil)
    }
    
}
