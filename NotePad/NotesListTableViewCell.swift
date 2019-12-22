//
//  NotesListTableViewCell.swift
//  NotePad
//
//  Created by sourav sachdeva on 21/12/19.
//  Copyright © 2019 sourav sachdeva. All rights reserved.
//

import UIKit

class NotesListTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var lastModified: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
