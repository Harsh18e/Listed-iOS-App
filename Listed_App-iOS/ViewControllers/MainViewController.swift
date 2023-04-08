//
//  ViewController.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 06/04/23.
//

import UIKit

class MainViewController: UIViewController, ViewModelDelegate {
    func updateUI() {
        tableView.reloadData()
    }
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: PrimaryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = PrimaryViewModel()
        viewModel?.delegate = self
        viewModel?.makeNetworkCall()
        
        setTabBarItem()
        tableView.register(UINib(nibName: GraphTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: "graphCell")
        tableView.register(UINib(nibName: SampleLinkTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: "sampleLinkCell")
        tableView.register(UINib(nibName: SampleSectionTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: "filterCell")
        tableView.register(UINib(nibName: ViewAllTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: "viewAllCell")
        tableView.register(UINib(nibName: ContactUsTableViewCell.getNibName(), bundle: nil), forCellReuseIdentifier: "contactUsCell")
    }
    
    private func setTabBarItem() {
        let myTabBarItem = UITabBarItem(title: "Links", image: UIImage(named: "link_image"), tag: 2)
        myTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        myTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        myTabBarItem.badgeColor = .black
        
        myTabBarItem.selectedImage = UIImage(named: "link_image")?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem = myTabBarItem
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            if let condition = viewModel?.isExpanded, !condition {
                return 4
            } else {
                return viewModel?.getLinksList()?.count ?? 0
            }
        case 3:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "graphCell", for: indexPath) as! GraphTableViewCell
            cell.viewModel = self.viewModel
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as!
            SampleSectionTableViewCell
            cell.viewModel = self.viewModel
            return cell
        case 2:
            if let expanded = viewModel?.isExpanded, !expanded, indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "viewAllCell", for: indexPath) as! ViewAllTableViewCell
                cell.viewModel = viewModel
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "sampleLinkCell", for: indexPath) as! SampleLinkTableViewCell
            cell.viewModel = self.viewModel
            cell.linkData = viewModel?.getLinkData(indexPath.row)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactUsCell", for: indexPath) as! ContactUsTableViewCell
            if indexPath.row == 1 {
                cell.setupUI(.FAQ)
            } else {
                cell.setupUI(.Whatsapp)
            }
            cell.viewModel = self.viewModel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let expanded = viewModel?.isExpanded, !expanded, indexPath.section == 2, indexPath.row == 3 else { return }
        
        viewModel?.isExpanded.toggle()
        self.updateUI()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            switch section {
            case 0:
                return 6 // Set the padding for section 0
            case 1:
                return 0 // Set the padding for section 1
            case 2:
                return 36 // Set the padding for section 2
            // Add more cases for other sections as needed
            case 3:
                return 50
            default:
                return 2 // Default padding for sections not specified above
            }
        }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20)) // Replace 20 with the default height you set in `heightForFooterInSection`
            footerView.backgroundColor = .clear // Set the background color of the footer view
            return footerView
        }
}

