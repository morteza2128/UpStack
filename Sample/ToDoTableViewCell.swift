//
//  ToDoTableViewCell.swift
//  Sample
//
//  Created by Morteza on 11/14/18.
//  Copyright © 2018 Morteza Hosseini Zadeh. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  @IBOutlet weak var titleLabel: UILabel!
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func fillData(todo: ToDoModel) {
    
    titleLabel.text  = todo.title
    // do the rest of the filling data
  }

}
