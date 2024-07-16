//
//  CharacterCell.swift
//  iOS Task Yassir
//
//  Created by eleyan saad on 13/07/2024.
//

import UIKit
import SDWebImage

class CharacterCell: UITableViewCell {
    
    // MARK: - VARIBLES
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var continerView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    
    static var cellID = "characterCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         setupUI()
    }
    private func setupUI() {
         // Round corners
        continerView.roundCorners(cornerRadius: 20, borderWidth: 1, borderColor: UIColor.lightGray)
        characterImageView.roundCorners(cornerRadius: 8, borderWidth: 0, borderColor: UIColor.lightGray)
     }
    
    func setData(obj:
                 Result?){
        self.nameLabel.text = obj?.name ?? ""
        self.speciesLabel.text = obj?.species ?? ""
        self.characterImageView.sd_setImage(with: obj?.imageURL, placeholderImage: UIImage(named: "Placeholder_view_vector.svg"), options: .progressiveLoad) { (image, error, cacheType, imageURL) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
            } else {
                print("Image loaded successfully")
                // Optionally handle success case or perform additional tasks
            }
            
        }
    }
}
