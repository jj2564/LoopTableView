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
    private lazy var videoTableView = createTableView()
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Quiz One"
        view.backgroundColor = .white
        
        view.addSubview(videoTableView)
        videoTableView.edgeWithSuperView()
        setupViewModel()
    }
    
    private func setupViewModel() {
        // Binding update
        viewModel.reloadHandler = { [weak self] in
            guard let self = self else { return }
            // reload Data
            #if DEBUG
            print(self.viewModel.datas)
            #endif
            self.videoTableView.reloadData()
        }
        updateData()
    }
    
    private func updateData() {
        self.viewModel.fetchData()
    }
}

extension AppQuizListVC {
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.cellIdentifier)
        return tableView
    }
}

extension AppQuizListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.cellIdentifier) as? VideoCell else { return UITableViewCell() }
        if let video = viewModel.datas[safe: indexPath.row] {
//            cell.setNeedsLayout()
            cell.updateData(data: video)
        }
        return cell
    }
    
    
}
