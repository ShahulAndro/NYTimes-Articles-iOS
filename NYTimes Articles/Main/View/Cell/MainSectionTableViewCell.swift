//
//  MainSectionTableViewCell.swift
//  NYTimes Articles
//
//  Created by Shahul Hamed Shaik (HLB) on 11/03/2022.
//

import UIKit

class MainSectionTableViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateSection(title: String) {
        self.sectionTitleLabel.text = title
    }
    
}
