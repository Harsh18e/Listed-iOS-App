//
//  Extensions.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 07/04/23.
//

import Foundation
import UIKit
import Charts

extension Double {
    func roundedStringWithTwoDecimals() -> String {
        return String(format: "%.2f", self)
    }
    func convertNumberToShortString() -> String {
        let absNumber = abs(self)
        let sign = self < 0 ? "-" : ""
        let suffixes = ["", "K", "M", "B"]
        let digits = Int(log10(Double(absNumber)))
        let suffixIndex = (digits / 3)
        let roundedNumber = Double(absNumber) / pow(10, Double(suffixIndex * 3))
        let formattedNumber = String(format: "%.1f", roundedNumber)
        return "\(sign)\(formattedNumber) \(suffixes[suffixIndex])"
    }

}

extension UITableView {
    func dequeueReusableHeaderFooterView<T: UIView>(_ viewClass: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: viewClass.getCellIdentifier()) as! T
    }
}

extension UIView {
    
    // MARK: - Class Methods
    class func getNibName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    class func getCellIdentifier() -> String {
        return getNibName()
    }
}

extension UIImageView {
    func downloadImage(from url: URL, _ isSame: Bool)
    {
        if !isSame {
            return
        }
        contentMode = .scaleToFill
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print("error occured !!")
                return
            }
            guard let imageData = data, let image = UIImage(data: imageData) else {
                    print("Error converting image data to UIImage")
                    return
                }
            DispatchQueue.main.async {
                    self.image = image
                }
        
        }.resume()
    }
}

extension UITableView {
    func registerNib(_ viewClass: UIView.Type) {
        let nib = UINib(nibName: viewClass.getNibName(), bundle: nil)
        register(nib, forCellReuseIdentifier: viewClass.getCellIdentifier())
    }
}

extension UIViewController {
    static func getIdentifier() -> String {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        return className
    }
}

@IBDesignable
public class CustomUIView: UIView {

    // MARK: - Variable
    private var gShadowOffsetWidth = 0
    private var gShadowOffsetHeight = 0
    
    // MARK: - Initialization
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
       
       // MARK: - UI Setup
       public override func prepareForInterfaceBuilder() {
           setupView()
       }
       
       func setupView() {
           self.layer.cornerRadius = cornerRadius
           self.layer.shadowColor = shadowColor.cgColor
           self.layer.shadowRadius = shadowRadius
           self.layer.shadowOpacity = shadowOpacity
           self.layer.borderWidth = borderWidth
           self.layer.borderColor = borderColor.cgColor
       }
    
    // MARK: - IBInspectables
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?
    
    public override func layoutSubviews() {
            super.layoutSubviews()
            dashBorder?.removeFromSuperlayer()
            let dashBorder = CAShapeLayer()
            dashBorder.lineWidth = dashWidth
            dashBorder.strokeColor = dashColor.cgColor
            dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
            dashBorder.frame = bounds
            dashBorder.fillColor = nil
            if cornerRadius > 0 {
                dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            } else {
                dashBorder.path = UIBezierPath(rect: bounds).cgPath
            }
            layer.addSublayer(dashBorder)
            self.dashBorder = dashBorder
        }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = shadowOpacity

            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
    }

    @IBInspectable var shadowColor: UIColor = .white {
           didSet {
               layer.shadowColor = shadowColor.cgColor
           }
       }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
           didSet {
               layer.shadowRadius = shadowRadius
           }
       }
    
    @IBInspectable var shadowOWidth: Int = 0 {
        didSet {
            gShadowOffsetWidth = shadowOWidth
            layer.shadowOffset = CGSize(width: gShadowOffsetWidth, height: gShadowOffsetHeight)
        }
    }
    
    @IBInspectable var shadowOHeight: Int = 0 {
        didSet {
            gShadowOffsetHeight = shadowOHeight
            layer.shadowOffset = CGSize(width: gShadowOffsetWidth, height: gShadowOffsetHeight)
        }
    }
}

@IBDesignable
class CustomUIButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - IBInspectables
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var selectedBorderColor: UIColor = UIColor.clear
    @IBInspectable var disabledBorderColor: UIColor = UIColor.clear

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1

        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = selectedBorderColor.cgColor
                imageView?.tintColor = selectedBorderColor
            } else {
                layer.borderColor = borderColor.cgColor
                imageView?.tintColor = currentTitleColor
            }
        }
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                layer.borderColor = borderColor.cgColor
            } else {
                layer.borderColor = disabledBorderColor.cgColor
            }
        }
    }

    @objc func set(image: UIImage?, title: String, titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State) {
        imageView?.contentMode = .center
        setImage(image, for: state)

        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)

        titleLabel?.contentMode = .center
        setTitle(title, for: state)
    }

    @objc func set(image: UIImage?, attributedTitle title: NSAttributedString, at position: UIView.ContentMode, width spacing: CGFloat, state: UIControl.State) {
        imageView?.contentMode = .center
        setImage(image, for: state)

        adjust(title: title, at: position, with: spacing)

        titleLabel?.contentMode = .center
        setAttributedTitle(title, for: state)
    }

    // MARK: - Private Methods
    private func adjust(title: NSAttributedString, at position: UIView.ContentMode, with spacing: CGFloat) {
        let imageRect: CGRect = self.imageRect(forContentRect: frame)
        let titleSize = title.size()

        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
    }

    private func adjust(title: NSString, at position: UIView.ContentMode, with spacing: CGFloat) {
        let imageRect: CGRect = self.imageRect(forContentRect: frame)

        // Use predefined font, otherwise use the default
        let titleFont: UIFont = titleLabel?.font ?? UIFont()
        let titleSize: CGSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont])

        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
    }

    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode, spacing: CGFloat) {
        let imageRect: CGRect = self.imageRect(forContentRect: frame)

        // Use predefined font, otherwise use the default
        let titleFont: UIFont = titleLabel?.font ?? UIFont()
        let titleSize: CGSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont])

        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
    }

    private func arrange(titleSize: CGSize, imageRect: CGRect, atPosition position: UIView.ContentMode, withSpacing spacing: CGFloat) {
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets

        switch (position) {
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0 + spacing + -6, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageRect.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        titleEdgeInsets = titleInsets
        imageEdgeInsets = imageInsets
    }
}
extension String {
    func convertToCustomDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date)
    }
    
    func convertToDateInWords() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
            
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd MMM"
            return dateFormatter.string(from: date)
        } else {
            return self
        }
    }
}


extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index]: nil
    }

    mutating func insertSafe(_ element: Element, at index: Int) {
        if self.count >= index {
            self.insert(element, at: index)
        } else {
            self.insert(element, at: self.count)
        }
    }
}
