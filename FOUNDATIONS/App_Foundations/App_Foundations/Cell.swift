//
//  Cell.swift
//  App_Foundations
//
//  Created by Rebeca Silva on 19/12/21.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

//struct Todo {
//    var title: String
//    var isMarked: Bool
//}
