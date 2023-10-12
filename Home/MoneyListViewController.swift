//
//  MoneyListViewController.swift
//  Save money hard
//
//  Created by 김찬교 on 2023/10/12.
//

import UIKit

class MoneyListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AnyHashable
    enum Section: Int {
        case summary
        case list
    }
    let viewModel: HomeListViewModel = HomeListViewModel()
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


}
