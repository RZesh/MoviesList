//
//  TopRatedListVC.swift
//  Sample
//
//  Created by Gopi Krishna on 09/04/21.
//

import UIKit

class TopRatedListVC: UIViewController {
    @IBOutlet var collViewTopRated : UICollectionView!

    var arrTopList = [TopRatedMoviesListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collViewTopRated.register(ListCollCell.nib, forCellWithReuseIdentifier: ListCollCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collViewTopRated.setCollectionViewLayout(layout, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.showTabBar()
        self.getTopRatedMoviesList()
    }
    func getTopRatedMoviesList() {
        RequestAPI().getTopRatedMovies(selectedtypeList: .top_rated, page: "1") { (issuccess, topRatedList) in
            debugPrint(topRatedList)
            _=topRatedList.results.map { (arrResult) in
                arrResult.map { (resObj) in
                    self.arrTopList.append(TopRatedMoviesListModel.init(strMovieName: resObj.title ?? "", strImgUrl: (AppUtility.posterBasePath + (resObj.posterPath ?? "")), strOverView: resObj.overview ?? "", strRating: "\(resObj.voteAverage ?? 0.0)", strVotingCount: "\(resObj.voteCount ?? 0)", strReleaseDate: resObj.releaseDate ?? ""))
                }
            }
            self.collViewTopRated.reloadData()
        }
    }
    
}

extension TopRatedListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK:- UICollectionView Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTopList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cellList = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollCell.identifier, for: indexPath) as? ListCollCell else {
            return UICollectionViewCell()
        }
        
        cellList.collCellDataUpcomingList = arrTopList[indexPath.item]
        return cellList
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailVC") as? DetailVC
        vc?.movieData = arrTopList[indexPath.item]
        self.navigationController?.pushViewController(vc!, animated: true)

    }
   
}

extension TopRatedListVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collViewTopRated.frame.size.width / 2 - 10, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
