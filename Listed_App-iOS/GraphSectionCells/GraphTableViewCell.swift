//
//  GraphTableViewCell.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 06/04/23.
//

import UIKit

class GraphTableViewCell: UITableViewCell, ViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var dateRangeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    weak var viewModel: PrimaryViewModel? {
        didSet {
            setupGraphUI()
            viewModel?.collectionDelegate = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: AnalyticsCollectionViewCell.getNibName(), bundle: nil), forCellWithReuseIdentifier: "analyticsCollectionCell")
        setupGraphUI()
        greetingsLabel.text = getGreetingForCurrentTime()
    }
    
    func getGreetingForCurrentTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour >= 6 && hour < 12 {
            return "Good Morning! ☀️"
        } else if hour >= 12 && hour < 17 {
            return "Good Afternoon! 🌤️"
        } else if hour >= 17 && hour < 21 {
            return "Good Evening! 🌇"
        } else {
            return "Good Night! 🌙"
        }
    }

    func setupGraphUI() {
        guard let data: [String: Int] = viewModel?.decodedData?.data.overallURLChart else {
            return
        }
        let sortedData = data.sorted { $0.key < $1.key }

        let lineGraphView = LineGraphView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        var cgFloatValues = [CGFloat]()
        
        for i in sortedData {
            cgFloatValues.append(CGFloat(i.value))
        }
        lineGraphView.data = cgFloatValues
        let newDates = sortedData.map { $0.key }
        lineGraphView.dates = newDates
        
        dateRangeLabel.text = (newDates.first?.convertToDateInWords() ?? "") + " - " + (newDates.last?.convertToDateInWords() ?? "")

        lineGraphView.lineColor = .systemBlue
        graphView.addSubview(lineGraphView)
        lineGraphView.translatesAutoresizingMaskIntoConstraints = false

        // Add Auto Layout constraints to center the line graph view within the container view
        NSLayoutConstraint.activate([
            lineGraphView.centerXAnchor.constraint(equalTo: graphView.centerXAnchor),
            lineGraphView.centerYAnchor.constraint(equalTo: graphView.centerYAnchor),
            lineGraphView.widthAnchor.constraint(equalTo: graphView.widthAnchor),
            lineGraphView.heightAnchor.constraint(equalTo: graphView.heightAnchor)
        ])
        
        layoutSubviews()
    }
}


extension GraphTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "analyticsCollectionCell", for: indexPath) as! AnalyticsCollectionViewCell
        cell.cellIndex = indexPath.row
        cell.viewModel = viewModel
        return cell
    }
}

