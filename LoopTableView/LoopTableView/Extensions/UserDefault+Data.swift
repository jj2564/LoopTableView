//
//  UserDefault+Data.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/9/30.
//

import Foundation

extension UserDefaults {
    func getDataFromRequest<T: ApiRequest>(_ req: T) -> T.Response? {
        guard let data = data(forKey: req.key) else { return nil }
        do {
            return try JSONDecoder().decode(T.Response.self, from: data)
        } catch { print(error); return nil }
    }
}
