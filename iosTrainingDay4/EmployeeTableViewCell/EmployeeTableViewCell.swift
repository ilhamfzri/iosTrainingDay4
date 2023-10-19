//
//  EmployeeTableViewCell.swift
//  iosTrainingDay4
//
//  Created by ITBCA on 19/10/23.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(data:EmployeeModel){
        idLabel.text = String(data.id)
        nameLabel.text = data.name
        ageLabel.text = String(data.age)
        salaryLabel.text = String(data.salary)
    }
}
