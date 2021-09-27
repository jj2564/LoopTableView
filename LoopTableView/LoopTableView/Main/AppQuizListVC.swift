//
//  AppQuizListVC.swift
//  LoopTableView
//
//  Created by IrvingHuang on 2021/9/27.
//

import Foundation
import UIKit

class AppQuizListVC: UIViewController {
    private var viewModel = AppQuizListViewModel()
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Quiz One"
        view.backgroundColor = .white
        
        setupViewModel()
    }
    
    private func setupViewModel() {
        // Binding update
        viewModel.reloadHandler = { [weak self] in
            guard let self = self else { return }
            // reload Data
            print("Data had been uploaded")
            print(self.viewModel.datas)
        }
        updateData()
    }
    
    private func updateData() {
        self.viewModel.fetchData()
    }
}
