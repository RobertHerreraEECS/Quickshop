//
//  SwitchingViewController.swift
//  Fonts
//
//  Created by Gabrielle Sanchez on 10/10/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController{

    private var blueViewController: BlueViewController!
    private var navViewController: NavViewController!
    private var navViewController2: NavViewController2!
    
    @IBOutlet weak var ButtonLabel1: UIButton!
    @IBOutlet weak var ButtonLabel2: UIButton!
    @IBOutlet weak var ButtonLabel3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonLabel2.hidden = true 
        // Do any additional setup after loading the view.
        blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue")
            as! BlueViewController
        blueViewController.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        if blueViewController != nil && blueViewController!.view.superview == nil {
            blueViewController = nil
        }
        else if navViewController != nil && navViewController!.view.superview == nil {
            navViewController = nil
        }
        else if navViewController2 != nil && navViewController2!.view.superview == nil {
            navViewController2 = nil
        }
    }
    
    
    
    
    
    
    @IBAction func switchViews(sender: UIButton) {
        // Create the new view controller, if required
        
        if navViewController?.view.superview == nil {
            if navViewController == nil {
                navViewController = storyboard?.instantiateViewControllerWithIdentifier("Navigator")
                    as! NavViewController
            }
        } else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue")
                    as! BlueViewController
            }
        }
        
        if navViewController2?.view.superview == nil {
            if navViewController2 == nil {
                navViewController2 = storyboard?.instantiateViewControllerWithIdentifier("Navigator2")
                    as! NavViewController2
            }
        }  else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue")
                    as! BlueViewController
            }
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        
        // Switch view controllers
        if blueViewController != nil && blueViewController!.view.superview != nil {
            UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
            
            if sender.titleLabel!.text == "Build My Shopping List"{
            navViewController.view.frame = view.frame
                ButtonLabel1.hidden = true
                ButtonLabel3.hidden = true
                ButtonLabel2.hidden = false
             switchViewController2(from: blueViewController, to: navViewController)
            }
            else if sender.titleLabel!.text == "Find My Store"{
  
                navViewController2.view.frame = view.frame
                ButtonLabel1.hidden = true
                ButtonLabel3.hidden = true
                ButtonLabel2.hidden = false
                switchViewController2(from: blueViewController, to: navViewController2)
            }
            
            

            
        } else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            var tempStatus = view.frame
            blueViewController.view.frame = view.frame
            if sender.titleLabel!.text == "Home"  &&  navViewController.view.frame == tempStatus{
                ButtonLabel1.hidden = false
                ButtonLabel3.hidden = false
                ButtonLabel2.hidden = true
                //switchViewController(from: navViewController2, to: blueViewController)
                switchViewController(from: navViewController, to: blueViewController)
            }
            if sender.titleLabel!.text == "Home"  &&  navViewController2.view.frame == tempStatus{
                ButtonLabel1.hidden = false
                ButtonLabel3.hidden = false
                ButtonLabel2.hidden = true
                //switchViewController(from: navViewController2, to: blueViewController)
                switchViewController(from: navViewController2, to: blueViewController)
            }
        }
        UIView.commitAnimations()
    }
    
    
    
    
    private func switchViewController(from fromVC:UINavigationController?, to toVC:UIViewController?) {
        if fromVC != nil {
            fromVC!.willMoveToParentViewController(nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParentViewController()
        }
        
        if toVC != nil {
            self.addChildViewController(toVC!)
            self.view.insertSubview(toVC!.view, atIndex: 0)
            toVC!.didMoveToParentViewController(self)
        }
    }
    
    private func switchViewController2(from fromVC:UIViewController?, to toVC:UINavigationController?) {
        if fromVC != nil {
            fromVC!.willMoveToParentViewController(nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParentViewController()
        }
        
        if toVC != nil {
            self.addChildViewController(toVC!)
            self.view.insertSubview(toVC!.view, atIndex: 0)
            toVC!.didMoveToParentViewController(self)
        }
    }
    

}
