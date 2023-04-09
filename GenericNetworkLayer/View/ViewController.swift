//
//  ViewController.swift
//  GenericNetworkLayer
//
//  Created by Yildirim on 8.04.2023.
//

import UIKit
protocol IViewController{
    func bindData(values:[Post])
}
class ViewController: UIViewController {
    
    private lazy var posts:[Post] = []
    
    lazy var postViewModel:IPostViewModel = PostViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Posts"
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
        postViewModel.setDelegate(output: self)
        postViewModel.fetchItems()
        
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
    


}
extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =  posts[indexPath.row].title
        cell.detailTextLabel?.text = posts[indexPath.row].body
        return cell
    }

}

extension ViewController:IViewController{
    func bindData(values: [Post]) {
        posts = values
        tableView.reloadData()
    }
    
    
}
