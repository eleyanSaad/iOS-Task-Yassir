//
//  Helper.swift
//  iOS Task Yassir
//
//  Created by eleyan saad on 13/07/2024.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - UIVIEW
extension UIView {
    func roundCorners(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }

}

// MARK: - STRING
extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

// MARK: - UIVIEW_CONTROLLER
extension UIViewController {
    func errorAlert(title: String, body: String) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        
        // Define your custom font
        let customFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 16.0)
        
        // Customize the message text with the custom font
        let attributedMessage = NSAttributedString(string: body, attributes: [
            .font: customFont,
            .foregroundColor: UIColor.black, // Customize the font color
        ])
        
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        self.present(alert, animated: true, completion: nil)
    }
}


extension Color {
    init(hexString: String, alpha: Double = 1.0) {
        var hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0

        // Scan the hex string into a UInt64
        Scanner(string: hex).scanHexInt64(&int)

        // Extract RGB components from the UInt64
        let red = Double((int >> 16) & 0xFF) / 255.0
        let green = Double((int >> 8) & 0xFF) / 255.0
        let blue = Double(int & 0xFF) / 255.0

        self.init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }
}

