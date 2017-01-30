//
//  ViewController.swift
//  MemoryGame
//
//  Created by Marie Park on 1/30/17.
//  Copyright © 2017 Marie Park. All rights reserved.
//

import UIKit

class PagesViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    // Create an array of VC
    lazy var VCArr: [UIViewController] = {
        return [self.VCInstance(name: "firstVC"),
                self.VCInstance(name: "secondVC"),
                self.VCInstance(name: "thirdVC")]
    }()
    
    // InstantiateVC by using storyboard ID
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        // specify the visible VCs, the direction of transition, and with optional animation
        if let firstVC = VCArr.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        // change the color of the dots
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.white
    }
    
    // we need this function to change the color of page indicators because bydefault the color is black
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
                
                
            }
        }
    }
    
    
    
    //return the VC before the current page
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // if index was < 0 go to the last VC to create a loop in pages
        guard previousIndex >= 0 else {
            // if we want to stop pages on the last one just replace this value with nil
            return VCArr.last
        }
        
        // if array.count < index return nil to avoid the crashing if the size of array changes
        guard VCArr.count > previousIndex else {
            return nil
        }
        
        return VCArr[previousIndex]
    }
    
    //return the VC after the current page
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex != VCArr.count else {
            // to avoid loop, we can replace this by nil
            return VCArr.first
        }
        
        guard VCArr.count > nextIndex else {
            return nil
        }
        
        return VCArr[nextIndex]
    }
    
    
    // numbers of pages in the indicator
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArr.count
    }
    
    // The selected item reflected in the page indicator.
    // check the index of the current page
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = VCArr.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
}
