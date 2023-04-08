//
//  ViewAllTableViewCell.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 07/04/23.
//

import UIKit

class ViewAllTableViewCell: UITableViewCell {
    
    @IBOutlet weak var button: CustomUIButton!
    @IBOutlet weak var containerView: CustomUIView!
    
    weak var viewModel: PrimaryViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
