//
//  ViewController.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {

    private var data = ["Hello", "Hello1", "Hello2", "Hello3", "Hello4"]
    
   private let dataTableView: UITableView = {
       let tableView = UITableView()
        
        tableView.tableFooterView = UIView()
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "PryanikyTest"
        
      

        
        setupTableView()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        dataTableView.pin.all()
    
    }

    private func setupTableView() {
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        dataTableView.separatorStyle = .none
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        dataTableView.refreshControl = refreshControl
        
        view.addSubview(dataTableView)
        
    }
    
   @objc
    private func didPullRefresh() {
        print("wow")
    }
    
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            return .init()
        }
        
        cell.configure(with: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
  
    
}

extension MainViewController: UITableViewDelegate {
    
}

