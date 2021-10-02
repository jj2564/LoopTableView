//
//  NotificationCenter+AutoRemoveObserver.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/10/2.
//

import Foundation

extension NotificationCenter {
    /// Convenience wrapper
    func observe(name: NSNotification.Name?, object obj: Any?,
    queue: OperationQueue?, using block: @escaping (Notification) -> ())
    -> NotificationToken
    {
        let token = addObserver(forName: name, object: obj, queue: queue, using: block)
        return NotificationToken(notificationCenter: self, token: token)
    }
}
