//
//  TodoTableViewCell.swift
//  todo list app
//
//  Created by Nojood Aljuaid  on 23/09/1445 AH.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTodo: UIImageView!
    @IBOutlet weak var titleTodo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
