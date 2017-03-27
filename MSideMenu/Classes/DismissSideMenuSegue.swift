//
//  DismissSideMenuSegue.swift
//  Pods
//
//  Created by Esraa on 3/27/17.
//
//

import UIKit

open class DismissSideMenuSegue: UIStoryboardSegue {

    fileprivate let transitionManager: SideMenuTransitionsManager = SideMenuTransitionsManager()

    override open func perform() {
        
        self.source.transitioningDelegate = transitionManager
        self.destination.dismiss(animated: true, completion: nil)
        
    }

}
