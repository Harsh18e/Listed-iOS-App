//
//  PrimaryViewModel.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 07/04/23.
//

import Foundation
import UIKit

protocol ViewModelDelegate {
    func updateUI()
}

enum LinkFilter {
    case topLinks
    case recentLinks
}

class PrimaryViewModel {
    
    var topImageDictionary = [Int : UIImage]()
    var recentImageDictionary = [Int : UIImage]()
    var counts1: Int = 0
    var counts2: Int = 0
    var isExpanded: Bool = false
    var currentFilter = LinkFilter.topLinks 
    
    var decodedData: Response? {
        didSet {
            self.downloadImages()
            DispatchQueue.main.async { [weak self] in
                
                guard let strongSelf = self else { return }
                strongSelf.delegate?.updateUI()
                strongSelf.collectionDelegate?.updateUI()
            }
        }
    }
    var delegate: ViewModelDelegate?
    var collectionDelegate: ViewModelDelegate?
    
    func makeNetworkCall(_ urlString: String = Constants.URL) {
        
        if !NetworkManager.shared.isNetworkAvailable() {
            print("No INTERNET -- ")
        }
        
        NetworkManager.shared.apiCall(urlString) { [weak self] result in
            guard let strongSelf = self else { return }
           
            switch result {
            case .success(let data):
                strongSelf.decodeData(data)
                
            case .failure(let error):
                print(error, "--")
            }
        }
    }
    private func decodeData(_ data: Data) {
        
            if let responseData = try? JSONDecoder().decode(Response.self, from: data) {
                self.decodedData = responseData
            } else {
                print(NetworkError.unableToParse)
            }
        
    }
    
    func getLinksList() -> [Link]? {
        switch currentFilter {
        case .topLinks:
            return decodedData?.data.topLinks
        case .recentLinks:
            return decodedData?.data.recentLinks
        }
    }
    
    func getLinkData(_ index: Int) -> Link? {
        guard let list = self.getLinksList() else { return nil }
        return list[index]
    }
    
    func getImageAtId(_ id: Int) -> UIImage? {
        switch currentFilter {
        case .topLinks:
            return topImageDictionary[id]
        case .recentLinks:
            return recentImageDictionary[id]
        }
    }
    
    func downloadImages() {
        guard let decodedData = decodedData else {return}
        
        for link in decodedData.data.topLinks {
            counts1 += 1
            let url = link.originalImage
            NetworkManager.shared.downloadImage(from: url) { [weak self] image, error in
                if let error = error {
                        // Handle the error
                        print("Error downloading image: \(error.localizedDescription)")
                    } else if let image = image {
                        // Do something with the downloaded image
                        self?.topImageDictionary[link.urlID] = image
                    }
                self?.counts1 -= 1
                if self!.counts1 < 1 {
                    self?.delegate?.updateUI()
                }
            }
        }
        for link in decodedData.data.recentLinks {
            counts2 += 1
            let url = link.originalImage
            NetworkManager.shared.downloadImage(from: url) { [weak self] image, error in
                if let error = error {
                        // Handle the error
                        print("Error downloading image: \(error.localizedDescription)")
                    } else if let image = image {
                        // Do something with the downloaded image
                        self?.recentImageDictionary[link.urlID] = image
                    }
                self?.counts2 -= 1
                if self!.counts2 < 1 {
                    self?.delegate?.updateUI()
                }
            }
        }
    }
}
