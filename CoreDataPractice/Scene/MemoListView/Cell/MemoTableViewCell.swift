//
//  MemoTableViewCell.swift
//  CoreDataPractice
//
//  Created by 신동희 on 2023/04/01.
//

import UIKit

final class MemoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    static var identifier: String { return String(describing: self) }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
