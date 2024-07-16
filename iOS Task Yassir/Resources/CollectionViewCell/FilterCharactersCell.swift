//
//  FilterCharactersCell.swift
//  iOS Task Yassir
//
//  Created by eleyan saad on 13/07/2024.
//

import UIKit

class FilterCharactersCell: UICollectionViewCell {
    
    // MARK: - OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    static var cellID = "filterCharctersCellID"

    override func awakeFromNib() {
         super.awakeFromNib()
         setupUI()
     }
     
    
       private func setupUI() {
           // Add styling as needed
           contentView.roundCorners(cornerRadius: 20, borderWidth: 1.5, borderColor: .lightGray)
       }
       
}
