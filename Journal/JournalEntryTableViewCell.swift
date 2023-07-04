//
//  JournalEntryTableViewCell.swift
//  Journal
//
//  Created by Quadri, Owais on 2023-07-04.
//

import UIKit

class JournalEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var journalEntryLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
