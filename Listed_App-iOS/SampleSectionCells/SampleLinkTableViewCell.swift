//
//  SampleLinkTableViewCell.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 07/04/23.
//

import UIKit

class SampleLinkTableViewCell: UITableViewCell {

    @IBOutlet weak var linkView: CustomUIView!
    @IBOutlet weak var linkNameLabel: UILabel!
    @IBOutlet weak var linkClicksLabel: UILabel!
    @IBOutlet weak var linkDateLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var copyImage: UIImageView!
    @IBOutlet weak var clickableView: UIView!
    @IBOutlet weak var iconView: CustomUIView!
    
    weak var viewModel: PrimaryViewModel?
    var linkData: Link? {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization
        let copyGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let openWebURLGesture = UITapGestureRecognizer(target: self, action: #selector(openWebURL(tapGestureRecognizer:)))
        
        clickableView.isUserInteractionEnabled = true
        clickableView.addGestureRecognizer(openWebURLGesture)
        copyImage.isUserInteractionEnabled = true
        copyImage.addGestureRecognizer(copyGesture)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        UIPasteboard.general.string = linkData?.webLink
        print("Text copied successfully!")
        showToast(message: "Copied!", contentView)
    }
    @objc func openWebURL(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let urlString = linkData?.webLink else {return}
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func setupUI() {
        guard let linkData = linkData else {return}
        
        linkNameLabel.text = linkData.title
        linkClicksLabel.text = String(describing: linkData.totalClicks)
        linkLabel.text = linkData.webLink
        
        let image = viewModel?.getImageAtId(linkData.urlID)
        let imageView = UIImageView(image: image)

        // Set the frame or constraints for the image view...
        imageView.frame = CGRect(x: 0, y: 0, width: iconView.frame.width, height: iconView.frame.height)
        // Add the image view to your existing view...
        iconView.addSubview(imageView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
