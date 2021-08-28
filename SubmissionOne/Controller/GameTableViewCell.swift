//
//  GameTableViewCell.swift
//  SubmissionOne
//
//  Created by Ade Hendra on 24/08/21.
//  Copyright © 2021 Organisasi Berbudaya. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var photoGame: UIImageView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var ratingGame: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
