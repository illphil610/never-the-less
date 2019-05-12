//
//  ProfileViewController.swift
//  never-the-less
//
//  Created by Philip on 4/29/19.
//  Copyright © 2019 Philip. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let infoText = UILabel()
    fileprivate let imageView = UIImageView()
    fileprivate let textContainer = UIView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUserInterface()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    //MARK: - Scroll View Delegate
    
    private var previousStatusBarHidden = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if previousStatusBarHidden != shouldHideStatusBar {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
            previousStatusBarHidden = shouldHideStatusBar
        }
    }
    
    //MARK: - Status Bar Appearance
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    fileprivate var shouldHideStatusBar: Bool {
        let frame = textContainer.convert(textContainer.bounds, to: nil)
        return frame.minY < view.safeAreaInsets.top
    }
    
    fileprivate func configureUserInterface() {
        view.backgroundColor = .gray
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        
        imageView.image = UIImage(named: "full band")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        infoText.textColor = .black
        infoText.numberOfLines = 0
        infoText.text = "Never The Less."
        infoText.font = .systemFont(ofSize: 32)
        
        let imageContainer = UIView()
        imageContainer.backgroundColor = .darkGray
        
        textContainer.backgroundColor = .clear
        
        let textBacking = UIView()
        textBacking.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(textBacking)
        scrollView.addSubview(textContainer)
        scrollView.addSubview(imageView)
        
        textContainer.addSubview(infoText)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        imageContainer.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
        }
        
        imageView.snp.makeConstraints { make in
            make.left.right.equalTo(imageContainer)
            make.top.equalTo(view).priority(.high)
            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            make.bottom.equalTo(imageContainer.snp.bottom)
        }
        
        textContainer.snp.makeConstraints { make in
            make.top.equalTo(imageContainer.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
        
        textBacking.snp.makeConstraints { make in
            
            make.left.right.equalTo(view)
            make.top.equalTo(textContainer)
            make.bottom.equalTo(view)
        }
        
        infoText.snp.makeConstraints { make in
            make.edges.equalTo(textContainer).inset(14)
        }
    }
}
