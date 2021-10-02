//
//  NotificationToken.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/10/2.
//

import Foundation


final class NotificationToken: NSObject {
    let notificationCenter: NotificationCenter
    let token: Any

    init(notificationCenter: NotificationCenter = .default, token: Any) {
        self.notificationCenter = notificationCenter
        self.token = token
    }

    deinit { notificationCenter.removeObserver(token) }
}
