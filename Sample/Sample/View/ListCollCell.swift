//
//  ListCollCell.swift
//  Sample
//
//  Created by Gopi Krishna on 07/04/21.
//

import UIKit
import Kingfisher

class ListCollCell: UICollectionViewCell {
    @IBOutlet weak var viewBG: UIView!
    
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    
    var collCellDataUpcomingList : TopRatedMoviesListModel? {
        didSet {
            guard let items = collCellDataUpcomingList else {
                return
            }
            lblText.text = items.strMovieName ?? ""
            let url = URL(string: collCellDataUpcomingList?.strImgUrl ?? "")
            imgPicture.kf.setImage(with: url, placeholder:UIImage(named: "placeHolder"), options: nil) { (result) in
                
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
