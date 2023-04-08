//
//  ViewController.swift
//  GenericNetworkLayer
//
//  Created by Yildirim on 8.04.2023.
//

import UIKit

class ViewController: UIViewController {
    lazy var postViewModel = PostViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        configureConstraint()
    }
    
    private func configure(){
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        bindData()
    }
    
    private func configureConstraint(){
        let tableConstraint = [
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let labelConstraint = [
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(tableConstraint)
        NSLayoutConstraint.activate(labelConstraint)
    }
    
    private func bindData(){
        postViewModel.getPostItems { errorMessage in
            if let errorMessage = errorMessage{
                print("error\(errorMessage)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.postItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = postViewModel.postItems[indexPath.row].title
        cell.detailTextLabel?.text = postViewModel.postItems[indexPath.row].body
        return cell
    }

}
