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
        setupTimer()
    }
    
    public func pauseTimer() {
        print("App moved to background!")
        stopTimer()
    }
    
    public func restartTimer() {
        print("App moved to foreground!")
        setupTimer()
    }
}

class CountDownTimerVM {
    
    public var updatedHandler: ((String) -> Void)?
    // 目前倒數的時間
    private var currentTime: Int = 0
    // 倒數用的Timer
    private var timer: Timer?
    
    init() { }
    
    private func setupTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    @objc func timerAction() {
        updateTime()
        guard currentTime > 0 else {
            stopTimer()
            return
        }
        currentTime = currentTime - 1
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTime() {
        updatedHandler?("\(currentTime)")
    }
}
