//
//  ScrollViewController.swift
//  MakerMate
//
//  Created by Jens Van Steen on 04/02/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit


import UIKit

protocol ScrollViewControllerDelegate {
    var viewControllers: [TestViewController?] { get }
    var initialViewController: Int { get }
}

class ScrollViewController: UIViewController {
    var currentIndex: Int = 0 {
        didSet {
            guidanceController.currentPage = Int(currentIndex)
        }
    }
    
    // MARK: - Properties
    var scrollView: UIScrollView {
        return view as! UIScrollView
    }
    
    var pageSize: CGSize {
        return scrollView.frame.size
    }
    
    var guidanceController: GuideHoldingViewController!
    
    var viewControllers: [TestViewController?]!
    
    var delegate: ScrollViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func loadView() {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        view = scrollView
        view.backgroundColor = .clear
    }
//
//    override func viewDidLoad() {
//       
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewControllers = delegate?.viewControllers as! [TestViewController?]
        
        
//        if let soemValue = viewControllers {
//            print("VALUEEEEEEEEE")
//            print(soemValue[1])
//        } else {
//            print("empty")
//        }
        
        // add view controllers as children
        for (index, controller) in viewControllers.enumerated() {
            if let controller = controller {
                addChild(controller)
                controller.view.frame = frame(for: index)
//                controller.textVIew.text = "The same viewController maar andere data \(index)"
                controller.testText.text = "Met een hoogte van \(index * 300)"
                controller.setupHeight(theindex: index)
                scrollView.addSubview(controller.view)
                controller.didMove(toParent: self)
            }
        }
        
//        guidanceController = parent as! GuideHoldingViewController
        
        guidanceController = parent as! GuideHoldingViewController
        
        scrollView.contentSize = CGSize(width: pageSize.width * CGFloat(viewControllers.count), height: pageSize.height)

        // set initial position of scroll view
        if let controller = delegate?.initialViewController {
            setController(to: viewControllers[controller]!, animated: false)
            currentIndex = controller
        }
    }
}

// MARK: - Private methods
fileprivate extension ScrollViewController {
    
    func frame(for index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * pageSize.width,
                      y: 0,
                      width: pageSize.width,
                      height: pageSize.height)
    }
    
    func indexFor(controller: UIViewController?) -> Int? {
        return viewControllers.index(where: {$0 == controller } )
    }
    
}

// MARK: - Scroll View Delegate
extension ScrollViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
    }
    
    
}

// MARK: - Public methods
extension ScrollViewController {
    
    public func setController(to controller: UIViewController, animated: Bool) {
        guard let index = indexFor(controller: controller) else { return }
        
        let contentOffset = CGPoint(x: pageSize.width * CGFloat(index), y: 0)
        scrollView.setContentOffset(contentOffset, animated: animated)
    }
}

