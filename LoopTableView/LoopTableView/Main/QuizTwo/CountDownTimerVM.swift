//
//  CountDownTimerVM.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/10/2.
//

import Foundation

// MARK:- Publice function
extension CountDownTimerVM {
    public func setTimeAndStart( timeText: String?) {
        guard
            let text = timeText,
            let time = Int(text)
        else {
            updatedHandler?("輸入錯誤")
            return
        }
        currentTime = time
        updateTime()
    }
    
    public func pauseTimer() {
        print("App moved to background!")
    }
    
    public func restartTimer() {
        print("App moved to foreground!")
    }
}

class CountDownTimerVM {
    
    public var updatedHandler: ((String) -> Void)?
    
    // 目前倒數的時間
    private var currentTime: Int = 0
    // 倒數用的Timer
    private var timer = Timer()
    
    init() {
        setupTimer()
    }
    
    private func setupTimer() {
        
    }
    
    private func updateTime() {
        updatedHandler?("\(currentTime)")
    }
}
