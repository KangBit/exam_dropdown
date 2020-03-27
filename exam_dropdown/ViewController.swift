//
//  ViewController.swift
//  exam_dropdown
//
//  Created by sjh on 2020/02/26.
//  Copyright © 2020 bit. All rights reserved.
//

import UIKit

private let reuseIdentifier = "DropDownCell"

class ViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar!
    
    var tableView: UITableView!
    var showMenu = false
    
    let menus = ["A","B","C","D"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DropDown Menu"
        
        setNavbar()
        setupTableView()
        tableView.isHidden = true
    }

    func setNavbar(){
        let btn = UIBarButtonItem(title: "BTN", style: .plain, target: nil, action: #selector(handleDropDown))
        self.navigationItem.rightBarButtonItem = btn
        
        navBar.setItems([self.navigationItem], animated: false)
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 50
        
        tableView.register(DropDownCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc func handleDropDown() {
        showMenu = !showMenu

        var indexPaths = [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0), IndexPath(row: 3, section: 0)]
        
        if showMenu {
            tableView.insertRows(at: indexPaths, with: .top)
            tableView.isHidden = false
        }else {
            tableView.deleteRows(at: indexPaths, with: .top)
            tableView.isHidden = true
        }

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showMenu ? menus.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DropDownCell
        cell.titleLabel.text = menus[indexPath.row]
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleDropDown()
        print("TODO")
    }
}
