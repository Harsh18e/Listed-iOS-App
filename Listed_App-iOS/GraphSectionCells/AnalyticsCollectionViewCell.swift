//
//  AnalyticsCollectionViewCell.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 07/04/23.
//

import UIKit

class AnalyticsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var viewModel: PrimaryViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupUI(_ index: Int) {
        
        switch index {
        case 0:
            headingLabel.text = String(describing: (viewModel?.decodedData?.totalClicks) ?? 0)
            iconView.image = UIImage(named: "Avatar")
            subtitleLabel.text = "Total Clicks"
        case 1:
            headingLabel.text = "Bengaluru"
            iconView.image = UIImage(named: "location_image")
            subtitleLabel.text = "Top Location"
        case 2:
            headingLabel.text = "Instagram"
            iconView.image = UIImage(named: "globe_image")
            subtitleLabel.text = "Top Source"
        case 3:
            headingLabel.text = "11:00 - 12:00"
            iconView.image = UIImage(named: "location_image")
            subtitleLabel.text = "Top Location"
        default:
            break
        }
    }
    
}
