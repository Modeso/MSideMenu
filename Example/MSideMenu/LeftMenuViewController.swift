//
//  LeftMenuViewController.swift
//  MSideMenu
//
//  Created by Esraa on 3/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import MSideMenu

class LeftMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapFirstViewController(_ sender: Any) {
        
        let rootNavController = UIApplication.shared.delegate?.window??.rootViewController as? SideMenuNavigationController
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstVC")
        rootNavController?.setViewControllers([vc], animated: false)
        rootNavController?.closeSideMenu()

    }
    @IBAction func didTapSecondViewController(_ sender: Any) {
        
        let rootNavController = UIApplication.shared.delegate?.window??.rootViewController as? SideMenuNavigationController
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondVC")
        rootNavController?.setViewControllers([vc], animated: false)
        rootNavController?.closeSideMenu()

    }
}
