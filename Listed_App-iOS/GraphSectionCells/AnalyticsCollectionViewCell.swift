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
        
        guard let data = viewModel?.decodedData else {return}
        
        switch index {
        case 0:
            headingLabel.text = String(describing: (data.todayClicks) ?? 0)
            iconView.image = UIImage(named: "Avatar")
            subtitleLabel.text = "Todays Clicks"
        case 1:
            headingLabel.text = String(describing: data.topLocation ?? "N/A")
            iconView.image = UIImage(named: "location_image")
            subtitleLabel.text = "Top Location"
        case 2:
            headingLabel.text = String(describing: data.topSource ?? "N/A")
            iconView.image = UIImage(named: "globe_image")
            subtitleLabel.text = "Top Source"
        case 3:
            headingLabel.text = String(describing: data.startTime ?? "N/A")
            iconView.image = UIImage(named: "clock_image")
            subtitleLabel.text = "Best Time"
        default:
            break
        }
    }
    
}
