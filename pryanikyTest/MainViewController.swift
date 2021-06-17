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

    private var dataSorted = [GlobalData]()
    
    private let dataTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PryanikyTest"
        setupTableView()
        fetchDataForCells()
    }
    
    private func sortingData(data: [GlobalData], sortingArray: [String]) -> [GlobalData] {
        var dictionary = [String: GlobalData]()
        data.forEach {
            dictionary[$0.name] = $0
        }
        let newData = sortingArray.compactMap {
            dictionary[$0]
        }

        return newData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
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
    
    private func fetchDataForCells() {
        NetworkManager.fetchData(url: url) {  (data) in

            let dataToShow = data.data
            let dataOrder = data.view
            
            let newData = self.sortingData(data: dataToShow, sortingArray: dataOrder)
            self.dataSorted = newData
            
            DispatchQueue.main.async {
                self.dataTableView.reloadData()
            }
        }
    }
    
//    guard let variants = chosenData.data.variants else { return }
//                let numberOfVariants = variants.count
//
//                let alertController = UIAlertController(title: "Выберете опцию", message: nil, preferredStyle: .actionSheet)
//
//                for variantNumber in 0...numberOfVariants - 1 {
//                    let variantId = String(variantNumber + 1)
//                    alertController.addAction(UIAlertAction(title: variantId, style: .default, handler: { _ in
//                        self.navigationController?.pushViewController(DetailViewController(title: variantId, text: variants[variantNumber].text ?? "", imageURL: nil), animated: true)
//                    }))
//
//                }
//
//                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//                alertController.addAction(cancelAction)
//                present(alertController, animated: true, completion: nil)

    @objc
    private func didPullRefresh() {
        let group = DispatchGroup()
        group.enter()
        fetchDataForCells()
        group.leave()
        group.wait()
        dataTableView.refreshControl?.endRefreshing()
    }
    
    private func configureAlertController(with array: [Variant]) -> UIAlertController {
                    let numberOfVariants = array.count
                    let alertController = UIAlertController(title: "Выберете опцию", message: nil, preferredStyle: .actionSheet)
                    for variantNumber in 0...numberOfVariants - 1 {
                        let variantId = String(variantNumber + 1)
                        alertController.addAction(UIAlertAction(title: variantId, style: .default, handler: { _ in
                            self.navigationController?.pushViewController(DetailViewController(title: variantId, text: array[variantNumber].text ?? "", imageURL: nil), animated: true)
                        }))
                    }
        
                    let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    return alertController
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSorted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            return .init()
        }
        cell.configure(with: dataSorted[indexPath.row].name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenData = dataSorted[indexPath.row]
        if let url = chosenData.data.url {
            navigationController?.pushViewController(DetailViewController(title: chosenData.name, text: chosenData.data.text ?? "", imageURL: url), animated: true)
        } else if let variants = chosenData.data.variants {
            let ac = configureAlertController(with: variants)
            present(ac, animated: true, completion: nil)
        }
        else {
            navigationController?.pushViewController(DetailViewController(title: chosenData.name, text: chosenData.data.text ?? "", imageURL: nil), animated: true)
        }
    }

}


extension MainViewController: UITableViewDelegate {}

