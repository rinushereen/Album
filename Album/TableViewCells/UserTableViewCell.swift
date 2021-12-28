//
//  OddUserTableViewCell.swift
//  Album
//
//  Created by Shereen on 24/11/20.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var firstLetterLabel: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var singleUser: User? 
    var indexPath: Int = 0 {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let user =  singleUser {
            self.userAvatar.roundCorners(radius: self.userAvatar.frame.size.width/2)
            self.firstLetterLabel.roundCorners(radius: self.firstLetterLabel.frame.size.width/2)
            self.firstLetterLabel.setBorder(color:UIColor.black)
            
            if indexPath % 2 == 0 {
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
            self.userName.text = user.userName()
            self.email.text = user.email
            
        }
    }
    
    
}


