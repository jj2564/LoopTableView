//
//  CountDownTimerVC.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/10/2.
//

import Foundation
import UIKit

class CountDownTimerVC: UIViewController {
    
    var backObserver: NotificationToken?
    var foreObserver: NotificationToken?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
    }
    
}

// MARK:- Maintain Notification
extension CountDownTimerVC {
    private func setupNotification() {
        backObserver = NotificationCenter.default.observe(name: UIApplication.willResignActiveNotification, object: nil, queue: nil) { [weak self] _ in
            self?.appMovedToBackground()
        }
        foreObserver = NotificationCenter.default.observe(name: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            self?.appMovedToForeground()
        }
    }
    
    func appMovedToBackground() {
        print("App moved to background!")
    }
    
    func appMovedToForeground() {
        print("App moved to foreground!")
    }
}
