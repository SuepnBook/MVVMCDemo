//
//  DashboardViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class DashboardViewController: BaseViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cellType: TrasactionTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

// MARK: - Private Function
extension DashboardViewController {
    private func initView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension DashboardViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: TrasactionTableViewCell.self)
        return cell
    }

}
