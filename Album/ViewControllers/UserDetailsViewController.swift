//
//  UserDetailsViewController.swift
//  Album
//
//  Created by Shereen on 24/11/20.
//

import UIKit

protocol updateDeatilsDelegate {
    func updateUserDatils(selectedIndex:Int)
}
class UserDetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.addShadowToView()
        }
    }
    
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var firstLetterLabel: UILabel!
    
    @IBOutlet weak var firstName: UITextField!{
        didSet{
            firstName.roundCorners(radius: 11)
            firstName.setBorder(color:UIColor.gray)
        }
    }
    @IBOutlet weak var lastName: UITextField!{
        didSet{
            lastName.roundCorners(radius: 11)
            lastName.setBorder(color:UIColor.gray)
        }
    }
    @IBOutlet weak var email: UITextField!
    {
        didSet{
            email.roundCorners(radius: 11)
            email.setBorder(color:UIColor.gray)
        }
    }
    
    @IBOutlet weak var submitButton: UIButton!{
        didSet{
            submitButton.roundCorners(radius: 11)
            submitButton.setBorder(color:UIColor.black)
        }
    }
    
    // MARK: Variables
    var delegate: updateDeatilsDelegate?
    var selectedUser :User?
    var selectedIndex: Int = 0
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupInitial()
    }
    
    // MARK: Functions
    func setupInitial() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.textFieldDidChangeAction),
            name: UITextField.textDidChangeNotification,
            object: nil)
        
    }
    
    @objc func textFieldDidChangeAction(_ notification: NSNotification) {
        
        if !verifyFields() {
            submitButton.isEnabled = false
        }else {
            submitButton.isEnabled = true
        }
        
    }
    func updateUI() {
        if let user =  selectedUser {
            self.userAvatar.roundCorners(radius: self.userAvatar.frame.size.width/2)
            self.firstLetterLabel.roundCorners(radius: self.firstLetterLabel.frame.size.width/2)
            self.firstLetterLabel.setBorder(color:UIColor.black)
            
            if selectedIndex % 2 == 0 {
                self.firstLetterLabel.isHidden = true
                self.userAvatar.isHidden = false
                self.userAvatar.sd_setImage(with: URL(string: user.avatar), placeholderImage: UIImage(named: "profile"))
                
            } else {
                self.firstLetterLabel.isHidden = false
                self.userAvatar.isHidden = true
                let first = user.first_name[0].uppercased()
                let last = user.last_name[0].uppercased()
                self.firstLetterLabel.text = first + last
                
            }
            self.firstName.text = user.first_name
            self.lastName.text = user.last_name
            self.email.text = user.email
            
        }
    }
    func verifyFields() -> Bool {
        
        if firstName.text!.isEmpty {
            
            return false
        }
        else if lastName.text!.isEmpty {
            
            return false
        } else if email.text!.isEmpty {
            
            return false
        }
        else if !(isValidEmail(email: email.text!)) {
            return false
        }
        else {
            return true
        }
    }
    
    // MARK: Button Actions
    @IBAction func submitAction(_ sender: Any) {
        navigationController?.popViewController { [self] in
            print("clicked")
            if self.firstName.text != self.selectedUser?.first_name {
                self.selectedUser?.first_name = self.firstName.text!
                
            }
            if self.lastName.text != self.selectedUser?.last_name {
                self.selectedUser?.last_name = self.lastName.text!
                
            }
            if self.email.text != self.selectedUser?.email {
                self.selectedUser?.email = self.email.text!
                
            }
            delegate?.updateUserDatils(selectedIndex: selectedIndex)
            
        }
        
    }
    
}

extension UINavigationController {
    
    func popViewController(animated:Bool = true, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    
}
