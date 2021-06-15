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
    private var dataToShow = [String]()
    
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
    
    func compare() {
        let numberOfCells = dataToShow.count
        
        
        for i in 0...numberOfCells - 1 {
        if self.data[i].name == dataToShow[i] {
            print("ok")
        }
        }
        
        // тут сравнивать датату шоу и обычную дату и менять местами если что
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
    
    private func fetchDataForCells() {
        NetworkManager.fetchData(url: "https://pryaniky.com/static/json/sample.json") {  (data) in
            self.dataToShow = data.view
            self.data = data.data
            
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
            navigationController?.pushViewController(DetailViewController(title: chosenData.name, text: chosenData.data.text ?? "", imageURL: chosenData.data.url), animated: true)
        case "picture":
            navigationController?.pushViewController(DetailViewController(title: chosenData.name, text: chosenData.data.text ?? "", imageURL: chosenData.data.url), animated: true)
        case "selector":
   

            guard let variants = chosenData.data.variants else { return }
            let numberOfVariants = variants.count

            let alertController = UIAlertController(title: "Выберете опцию", message: nil, preferredStyle: .actionSheet)

            for variantNumber in 0...numberOfVariants - 1 {
                let variantId = String(variantNumber + 1)
                alertController.addAction(UIAlertAction(title: variantId, style: .default, handler: { _ in
                    self.navigationController?.pushViewController(DetailViewController(title: variantId, text: variants[variantNumber].text ?? "", imageURL: nil), animated: true)
                }))

            }

            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        default:
            return
        }
    }
  
    }


extension MainViewController: UITableViewDelegate {
    
}

