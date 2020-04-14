//
//  TempViewCell.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 14/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit

@objc protocol TempViewCellDelegate {
    @objc optional func editButtonClicked(atIndex: Int)
}

class TempViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    public weak var tvDelegate: TempViewCellDelegate?
    public var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.font = UIFont.systemFont(ofSize: 17.0.scale(), weight: .regular)
        salaryLabel.font = UIFont.systemFont(ofSize: 17.0.scale(), weight: .regular)
        ageLabel.font = UIFont.systemFont(ofSize: 17.0.scale(), weight: .regular)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0.scale(), weight: .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "TempViewCell"
    }
   
    // Nib name
    class func nibName() -> String {
        return "TempViewCell"
    }

    @IBAction func editButtonClicked(_ sender: Any) {
        tvDelegate?.editButtonClicked?(atIndex: index)
    }
    
}
