//
//  TravelOnBoardingScreen.swift
//  On Boarding Screens
//
//  Created by Harleen Singh on 08/01/21.
//

import UIKit

struct OnBoardingItem {
    let title: String
    let detail: String
    let bgImage: UIImage?
}

class TravelOnBoardingScreen: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    private let items: [OnBoardingItem] = [
        .init(title: "Travel Your Way",
              detail: "Travel the world by air, rail or sea at the most competitive prices",
              bgImage: UIImage(named: "TravelAppImage1")),
        .init(title: "Stay Your Way",
              detail: "With over millions of hotels worldwide, find the perfect accomodation in the most amazing places!",
              bgImage: UIImage(named: "TravelAppImage2")),
        .init(title: "Discover Your Way With New Features",
              detail: "Explore exotic destination with our new features that link you to like-minded travellers!",
              bgImage: UIImage(named: "TravelAppImage3")),
        .init(title: "Feast Your Way",
              detail: "We recommend you local cuisines that are safe and highly recommended by the locals!" ,
              bgImage: UIImage(named: "TravelAppImage4"))
        
    ]
    
    private var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageControl()
        setupScreen(index: currentPage)
        setupGestures()
        setupViews()
        updateBackgroundImage(index: currentPage)
    }
    
    private func setupViews() {
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
    }
    
    private func updateBackgroundImage(index: Int) {
        let image = items[index].bgImage
        
        
        UIView.transition(with: bgImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.bgImageView.image = image
        }, completion: nil)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setupScreen(index: Int) {
        titleLabel.text = items[index].title
        detailLabel.text = items[index].detail
        pageControl.currentPage = index
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapAnimation() {
        
        // First animation - title label
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        } completion: { _ in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }
            
            
            // Second animation - detail label
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.detailLabel.alpha = 0.8
                self.detailLabel.transform = CGAffineTransform(translationX: -30, y: 0)
                
            }, completion: {_ in
                
                if self.currentPage < self.items.count - 1 {
                    self.updateBackgroundImage(index: self.currentPage+1)
                }
                
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    
                    self.detailLabel.alpha = 0.8
                    self.detailLabel.transform = CGAffineTransform(translationX: 0, y: -550)
                    
                }, completion: {_ in
                    
                    self.currentPage += 1
                    self.titleLabel.alpha = 1.0
                    self.detailLabel.alpha = 1.0
                    self.titleLabel.transform = .identity
                    self.detailLabel.transform = .identity
                    
                    if self.isOverLastItem() {
                        self.showMainApp()
                    }
                    else {
                        self.setupScreen(index: self.currentPage)
                    }
                    
                    
                    
                })
                
            })
            
            
            
        }
        
        
    }
    
    private func isOverLastItem() -> Bool {
        return currentPage == self.items.count
    }
    
    private func showMainApp() {
        let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainAppViewController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            window.rootViewController = mainAppViewController
            
            // swap rootview controller with animation
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
            
        }
    }
    
    
}
