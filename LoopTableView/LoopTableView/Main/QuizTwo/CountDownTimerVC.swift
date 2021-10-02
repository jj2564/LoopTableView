//
//  CountDownTimerVC.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/10/2.
//

import Foundation
import UIKit

class CountDownTimerVC: UIViewController {
    
    private let viewModel = CountDownTimerVM()
    
    private lazy var inputTextField = createTextField()
    private lazy var secondLabel = createLabel()
    private lazy var setButton = createButton()
    
    private var backObserver: NotificationToken?
    private var foreObserver: NotificationToken?
    
    override func loadView() {
        super.loadView()
        setupViews()
        setupLayouts()
        bindViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
    }
    
    private func bindViewModel() {
        viewModel.updatedHandler = { [unowned self] result in
            self.secondLabel.text = result
        }
    }
    
    deinit {
        print("CountDownTimerVC deinit")
    }
    
}

// MARK:- Views
private extension CountDownTimerVC {
    
    func setupViews() {
        view.addSubview(inputTextField)
        view.addSubview(secondLabel)
        view.addSubview(setButton)
        // 如果有其他對View操作的需求會放在這裡
    }
    
    func setupLayouts() {
        let views: ViewsDictionary = [
            "input": inputTextField,
            "second": secondLabel,
            "button": setButton
        ]
        
        let vfls: VFLDictionary = [
            "H:|-(8)-[input]-(8)-|": [],
            "H:|-(8)-[second]-(8)-|": [],
            "V:|-(150)-[input]-(10)-[button]-(50)-[second]-(>=20)-|": .alignAllCenterX
        ]
        
        var constraints = [NSLayoutConstraint]()
        constraints += constraintsArrayVFL(vfls, views: views)
        NSLayoutConstraint.activate(constraints)
    }
    
    func createTextField() -> UITextField {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.keyboardType = .numberPad
        v.textAlignment = .center
        v.placeholder = "Input Countdown Second Here"
        return v
    }
    
    func createLabel() -> UILabel {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 72, weight: .heavy)
        v.textAlignment = .center
        v.text = "123"
        return v
    }
    
    func createButton() -> UIButton {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle( "設定", for: .normal)
        v.setTitleColor( .systemBlue, for: .normal)
        v.addTarget( self, action: #selector(setCountdownTime), for: .touchUpInside)
        return v
    }
    
    @objc func setCountdownTime() {
        viewModel.setTimeAndStart(timeText: inputTextField.text ?? "0")
    }
}

// MARK:- Maintain Notification
private extension CountDownTimerVC {
    func setupNotification() {
        backObserver = NotificationCenter.default.observe(name: UIApplication.willResignActiveNotification, object: nil, queue: nil) { [weak self] _ in
            self?.appMovedToBackground()
        }
        foreObserver = NotificationCenter.default.observe(name: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            self?.appMovedToForeground()
        }
    }
    
    func appMovedToBackground() {
        viewModel.pauseTimer()
    }
    
    func appMovedToForeground() {
        viewModel.restartTimer()
    }
}
