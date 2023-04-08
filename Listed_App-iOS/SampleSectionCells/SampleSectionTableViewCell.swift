//
//  SampleSectionTableViewCell.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 07/04/23.
//

import UIKit

class SampleSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topLinksView: CustomUIView!
    @IBOutlet weak var recentLinksView: CustomUIView!
    @IBOutlet weak var searchView: CustomUIView!
    
    @IBOutlet weak var recentLinksLabel: UILabel!
    @IBOutlet weak var topLinksLabel: UILabel!
    
    weak var viewModel: PrimaryViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
        
        let topGesture = UITapGestureRecognizer(target: self, action: #selector(tappedTopFilter))
        let recentGesture = UITapGestureRecognizer(target: self, action: #selector(tappedRecentFilter))
        topLinksView.addGestureRecognizer(topGesture)
        recentLinksView.addGestureRecognizer(recentGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setUI()
    {
        
        if viewModel?.currentFilter == nil || viewModel?.currentFilter == .topLinks {
            topLinksView.backgroundColor = .systemBlue
            topLinksLabel.textColor = .white
            recentLinksView.backgroundColor = UIColor(hex: "F5F5F5")
            recentLinksLabel.textColor = UIColor(hex: "999CA0")
        } else {
            recentLinksView.backgroundColor = .systemBlue
            recentLinksLabel.textColor = .white
            topLinksView.backgroundColor = UIColor(hex: "F5F5F5")
            topLinksLabel.textColor = UIColor(hex: "999CA0")
        }
    }
    
    @objc private func tappedTopFilter(_ sender: Any) {
        viewModel?.currentFilter = .topLinks
        setUI()
        viewModel?.delegate?.updateUI()
    }
    
    @objc private func tappedRecentFilter(_ sender: Any) {
        viewModel?.currentFilter = .recentLinks
        setUI()
        viewModel?.delegate?.updateUI()
    }
}
