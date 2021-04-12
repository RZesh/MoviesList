//
//  DetailVC.swift
//  Sample
//
//  Created by Gopi Krishna on 07/04/21.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {
    @IBOutlet var imgView : UIImageView!
    @IBOutlet var lblRating : UILabel!
    @IBOutlet var lblVotingCount : UILabel!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var lblOverview : UILabel!
    @IBOutlet var lblReleaseDate : UILabel!
    
    var imgData = UIImage()
    
    var movieData = TopRatedMoviesListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint(movieData)
        self.hideTabBar()
        lblTitle.text = "Title \n" + (movieData.strMovieName ?? "")
        lblRating.text = "Rating : " + (movieData.strRating ?? "")
        lblVotingCount.text = "Voting : " + (movieData.strVotingCount ?? "")
        lblOverview.text = "Overview \n" + (movieData.strOverView ?? "")
        lblReleaseDate.text = "Release date : " + (movieData.strReleaseDate ?? "")
        let url = URL(string: movieData.strImgUrl ?? "")
        imgView.kf.setImage(with: url, placeholder:UIImage(named: "placeHolder"), options: nil) { (result) in
            
        }
        
    }
    
    @IBAction func btnTappedback(_ sender : UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
