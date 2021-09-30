//
//  UITableViewCell+tableView.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/9/30.
//
import UIKit
extension UITableViewCell {
    var tableView: UITableView? {
        var view = superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        return view as? UITableView
    }
}
