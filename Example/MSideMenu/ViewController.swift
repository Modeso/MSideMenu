//
//  ViewController.swift
//  MSideMenu
//
//  Created by esraaapady on 03/23/2017.
//  Copyright (c) 2017 esraaapady. All rights reserved.
//

import UIKit
import MSideMenu

class ViewController: RootViewViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
//    @IBAction func didTapShowSideMenu(_ sender: Any) {
//        if let presented = self.presentedViewController {
//            //dismissSegue
//            self.presentedViewController?.performSegue(withIdentifier: "dismissSegueManually", sender: self)
//            //
//        }else {
//            self.performSegue(withIdentifier: "showSideMenu", sender: self)
//        }
//    }
//    @IBAction func unwindToViewController(_ sender: UIStoryboardSegue) {
//        
//    }
//    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
//        let segue = DismissSideMenuSegue(identifier: "dismissSegue", source: fromViewController, destination: toViewController)
//        return segue
//    }
//
//    //
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      
//    }
}

