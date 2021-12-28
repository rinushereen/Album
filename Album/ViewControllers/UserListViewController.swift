//
//  ViewController.swift
//  Album
//
//  Created by Shereen on 24/11/20.
//

import UIKit

class UserListViewController: UIViewController {
    
    // MARK: Variables
    var userList = [User]()
    
    // MARK: Outlets
    @IBOutlet weak var userListTableView: UITableView!
    
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerTableviewCell()
        self.getDetailsFromApi()
    }
    
    // MARK: Functions
    func getDetailsFromApi() {
        NetworkService.makeApicall(handler: { (details, error) in
            if error == nil {
                self.userList = details
                self.userListTableView.reloadData()
            }
        })
    }
    func registerTableviewCell() {
        userListTableView.dataSource = self
        userListTableView.delegate = self
        userListTableView?.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        
    }
    
}

// MARK: Tableview Methods
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        cell.singleUser = userList[indexPath.row]
        cell.indexPath = indexPath.row
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "userDetails") as! UserDetailsViewController
        detailsViewController.selectedUser = userList[indexPath.row]
        detailsViewController.selectedIndex = indexPath.row
        detailsViewController.delegate = self 
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

// MARK: Delegate

extension UserListViewController: updateDeatilsDelegate {
    func updateUserDatils(selectedIndex: Int) {
        let index = IndexPath(row: selectedIndex, section: 0)
        self.userListTableView.reloadRows(at: [index], with: .automatic)
    }
    
    
}
