//
//  ViewController.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//

import UIKit
import PinLayout



private var url = "https://pryaniky.com/static/json/sample.json"

class MainViewController: UIViewController {


    private var data = [GlobalData]()
    
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

        fetchDataForCells()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func fetchDataForCells() {
        NetworkManager.fetchData(url: url) { (data) in
            self.data = data
            DispatchQueue.main.async {
                self.dataTableView.reloadData()
            }
        }
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
        let group = DispatchGroup()
        group.enter()
        fetchDataForCells()
        group.leave()
        group.wait()
        dataTableView.refreshControl?.endRefreshing()
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
        cell.configure(with: data[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenData = data[indexPath.row]
        switch chosenData.name {
        case "hz":
            navigationController?.pushViewController(DetailViewController(text: chosenData.data.text ?? "", imageURL: chosenData.data.url), animated: true)
        case "picture":
            navigationController?.pushViewController(DetailViewController(text: chosenData.data.text ?? "", imageURL: chosenData.data.url), animated: true)
        case "selector":
            print("selector")
        default:
            print("default")
        }
    }
  
    
}

extension MainViewController: UITableViewDelegate {
    
}

