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
        tableView.showsVerticalScrollIndicator = false
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.cellIdentifier)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
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
            cell.updateData(data: video)
        }
        return cell
    }

    // LoopTableView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = videoTableView.contentOffset.y
        if position > videoTableView.contentSize.height - videoTableView.frame.size.height {
            viewModel.datas = viewModel.datas + viewModel.datas
            videoTableView.reloadData()
        }
    }
    
    // 直接放numberOfSection IntMax會卡死，但是又怕viewModel.datas記憶體爆炸。
    // 所以做了一個把tableview推回中央的功能，會有一個停頓的感覺一時還沒想到怎麼改善。不過1000欄也挺多的！？
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalCount = viewModel.datas.count
        if totalCount < 1000 { return }
        let row = (indexPath.row + 1)
        if row == totalCount {
            let middle = totalCount / 2
            tableView.scrollToRow(at: IndexPath(row: middle, section: 0), at: .middle, animated: false)
        }
    }
    
}
