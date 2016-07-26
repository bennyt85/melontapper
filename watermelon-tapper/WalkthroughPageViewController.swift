////
////  WalkthroughPageVC.swift
////  watermelon-tapper
////
////  Created by James Tuttle on 7/13/16.
////  Copyright © 2016 James Tuttle. All rights reserved.
////
//
//import UIKit
//import Foundation
//
//class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
//    
//    var pageHeaders = ["Home Screen", "Animation Listen", "Alert Status", "Home Screen Help Button", "Help Screen"]
//    var pageImages = ["home-screen", "animation-listen", "alert-status", "home-screen-help-button", "help-screen"]
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Set the data source to itself
//        dataSource = self
//        // Create the first walkthrough screen
//        if let startingViewController = viewControllerAtIndex(0) {
//            setViewControllers([startingViewController], direction: .Forward,
//                               animated: true, completion: nil)
//        }
//    }
//    
//    
//    
//    
//    func pageViewController(pageViewController: UIPageViewController,
//                            viewControllerAfterViewController viewController: UIViewController) ->
//        UIViewController? {
//            var index = (viewController as! WalkthroughPageViewController).index
//            index++
//            return viewControllerAtIndex(index)
//    }
//    func pageViewController(pageViewController: UIPageViewController,
//                            viewControllerBeforeViewController viewController: UIViewController) ->
//        UIViewController? {
//            var index = (viewController as! WalkthroughPageViewController).index
//            index--
//            return viewControllerAtIndex(index)
//    }
//    
//    
//    func viewControllerAtIndex(index: Int) -> WalkthroughPageViewController? {
//        if index == NSNotFound || index < 0 || index >= pageHeaders.count {
//            return nil
//        }
//        // Create a new view controller and pass suitable data.
//        if let pageContentViewController =
//            storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPageViewController")
//                as? WalkthroughPageViewController {
//            
//            pageContentViewController.imageFile = pageImages[index]
//            pageContentViewController.header = pageHeaders[index]
//            // pageContentViewController.content = pageContent[index]
//            pageContentViewController.index = index
//            return pageContentViewController
//        }
//        return nil
//    }
//}
