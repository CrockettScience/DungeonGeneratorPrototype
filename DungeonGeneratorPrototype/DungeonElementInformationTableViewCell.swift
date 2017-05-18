//
//  DungeonElementInformationTableViewCell.swift
//  DungeonGeneratorPrototype
//
//  Created by Guest User on 5/11/17.
//  Copyright © 2017 Cuesta College. All rights reserved.
//

import UIKit

class DungeonElementInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setKeyValue(key k: String, value v: String){
        key.text = k
        value.text = v
    }
}
