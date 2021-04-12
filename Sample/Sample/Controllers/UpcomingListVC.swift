//
//  UpcomingListVC.swift
//  Sample
//
//  Created by Gopi Krishna on 09/04/21.
//

import UIKit


class UpcomingListVC: UIViewController {
    
    @IBOutlet var collViewUpcoming : UICollectionView!
    
    var arrUpcomingList = [TopRatedMoviesListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collViewUpcoming.register(ListCollCell.nib, forCellWithReuseIdentifier: ListCollCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collViewUpcoming.setCollectionViewLayout(layout, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showTabBar()
        self.getTopRatedMoviesList()
    }
    
    func getTopRatedMoviesList() {
        RequestAPI().getUpcomingMovies(selectedtypeList: .upcoming, page: "1") { (issuccess, upcoming) in
            _=upcoming.results.map { (arrResult) in
                arrResult.map { (resObj) in
                    self.arrUpcomingList.append(TopRatedMoviesListModel.init(strMovieName: resObj.title ?? "", strImgUrl: (AppUtility.posterBasePath + (resObj.posterPath ?? "")), strOverView: resObj.overview ?? "", strRating: "\(resObj.voteAverage ?? 0.0)", strVotingCount: "\(resObj.voteCount ?? 0)", strReleaseDate: resObj.releaseDate ?? ""))
                }
            }
            self.collViewUpcoming.reloadData()
        }
    }
    
}

extension UpcomingListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK:- UICollectionView Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUpcomingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cellList = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollCell.identifier, for: indexPath) as? ListCollCell else {
            return UICollectionViewCell()
        }
        
        cellList.collCellDataUpcomingList = arrUpcomingList[indexPath.item]
        return cellList
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailVC") as? DetailVC
        vc?.movieData = arrUpcomingList[indexPath.item]
        self.navigationController?.pushViewController(vc!, animated: true)

    }
   
}

extension UpcomingListVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collViewUpcoming.frame.size.width / 2 - 10, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
