//
//  NewConvoViewController.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 08/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import UIKit
import JGProgressHUD

class NewConvoViewController: UIViewController {
    let spinner = JGProgressHUD(style: .dark)
    private let searchBar : UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.placeholder = "Search Users"
        return searchbar
    }()
    private let tableview : UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableview.isHidden = true
        return tableview
    }()
    
    private let noChatLabel : UILabel = {
        let label = UILabel()
        label.text = "No Chats"
        label.textAlignment = .center
        label.textColor = .green
        label.isHidden = true
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelTapped))
        searchBar.becomeFirstResponder()
        }
    @objc private func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension NewConvoViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
