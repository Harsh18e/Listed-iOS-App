//
//  CustomTabBarController.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 08/04/23.
//

import Foundation
import UIKit

@IBDesignable
class AppTabBar: UITabBar {

    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        self.addShape()
        self.selectedItem?.selectedImage = self.selectedItem?.selectedImage?.withRenderingMode(.alwaysOriginal)
        self.tintColor = .black
        self.items![2].image = self.items![2].image?.withRenderingMode(.alwaysOriginal)
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = #colorLiteral(red: 0.9782002568, green: 0.9782230258, blue: 0.9782107472, alpha: 1)
        shapeLayer.lineWidth = 0.5
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }

    func createPath() -> CGPath {
        
        let height: CGFloat = 86.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height + 20 ), y: 0))
        
        path.addCurve(to: CGPoint(x: centerWidth, y: height - 107),
                      controlPoint1: CGPoint(x: (centerWidth - 25), y: 0), controlPoint2: CGPoint(x: centerWidth - 25, y: height - 107))
        path.addCurve(to: CGPoint(x: (centerWidth + height - 20 ), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 25, y: height - 107), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}

//extension UITabBar {
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        var sizeThatFits = super.sizeThatFits(size)
//        sizeThatFits.height = 74
//        return sizeThatFits
//    }
//}
//
//class CustomTabBarItem: UITabBarItem {
//
//    override init() {
//        super.init()
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//
//    private func setup() {
//        let image = UIImage(named: "custom_tab_icon")?.withRenderingMode(.alwaysOriginal)
//        self.image = image
//        self.selectedImage = image
//    }
//}


//
//class CustomTabBarController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Create a UIImageView with a round image
////        let imageView = UIImageView(image: UIImage(named: "whatsapp_icon"))
////        imageView.frame = CGRect(x: 0, y: -20, width: 80, height: 80)
////        imageView.contentMode = .scaleAspectFit
////        imageView.layer.cornerRadius = imageView.frame.width / 2
////        imageView.clipsToBounds = true
//
//        // Add the UIImageView as a subview of the tabBar
//       // self.tabBar.addSubview(imageView)
//    }
//
//    override func viewWillLayoutSubviews() {
//            super.viewWillLayoutSubviews()
//
////            // Adjust the frames of the tab bar items
////            var tabBarItemIndex = 0
////            let tabBarItemWidth = tabBar.frame.width / CGFloat(viewControllers?.count ?? 1)
////
////            for subview in tabBar.subviews {
////                if let tabBarItem = subview as? UIControl {
////                    let newX = tabBarItemWidth * CGFloat(tabBarItemIndex)
////                    tabBarItem.frame = CGRect(x: newX, y: 0, width: tabBarItemWidth, height: tabBar.frame.height)
////                    tabBarItemIndex += 1
////                }
////            }
////
////            // Adjust the frame of the round image
////            let centerX = tabBar.frame.width / 2
////            let centerY = tabBar.frame.height / 2 - 20
////            let newFrame = CGRect(x: centerX - 40, y: centerY - 40, width: 80, height: 80)
////            tabBar.subviews.last?.frame = newFrame
//        }
//
//}
