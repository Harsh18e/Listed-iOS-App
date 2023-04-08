//
//  ContactUsTableViewCell.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 07/04/23.
//

import UIKit

class ContactUsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var containerView: CustomUIView!
    
    weak var viewModel: PrimaryViewModel?
    
    enum ContactUs {
        case Whatsapp
        case FAQ
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(_ type: ContactUs) {
        switch type {
        case .FAQ:
            contactLabel.text = "Frequently Asked Questions"
            containerView.backgroundColor = UIColor(hex: "EAF1FE")
            iconImageView.image = UIImage(named: "question_mark")
            containerView.borderColor = .systemBlue
        case .Whatsapp:
            contactLabel.text = "Talk with Us"
            containerView.backgroundColor = UIColor(hex: "E3F1E4")
            iconImageView.image = UIImage(named: "whatsapp_icon")
            containerView.borderColor = .systemGreen
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
