//
//  SortedBySalaryCell.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 14/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit

class SortedBySalaryCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.font = UIFont.systemFont(ofSize: 12.0.scale(), weight: .regular)
        salaryLabel.font = UIFont.systemFont(ofSize: 12.0.scale(), weight: .regular)
        ageLabel.font = UIFont.systemFont(ofSize: 12.0.scale(), weight: .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Reuser identifier
     class func reuseIdentifier() -> String {
         return "SortedBySalaryCell"
     }
    
     // Nib name
     class func nibName() -> String {
         return "SortedBySalaryCell"
     }
    
}
