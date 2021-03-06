//
//  MovieCollectionViewCell.swift
//  CineFlick
//
//  Created by Josiah Agosto on 6/14/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    // Needed For other Properties
    public var apiManager = APINetworkManager.shared
    // Date Formatter
    lazy var dateFormatter = DateFormatter()
    // Inner Cell
    lazy var innerCollectionView: UICollectionView = {
        let layout = InnerCollectionViewFlowLayout()
        let innerCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        innerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        innerCollectionView.showsHorizontalScrollIndicator = false
        innerCollectionView.allowsSelection = true
        innerCollectionView.backgroundColor = UIColor.clear
        return innerCollectionView
    }()
    // Collection View Delegates
    public var movieCollectionDelegate: MovieCollectionViewDelegate?
    public var movieCollectionDataSource: MovieCollectionViewDataSource?
    // Delegates
    public var selectedCellDelegate: InnerSelectedCellProtocol?
    public var movieIdDelegate: InnerSelectedIdProtocol?
    // Runtime Delegate Properties
    var runtimeForSelectedMovie: String = ""
    // References
    public var cellSelection: CellSelectionEnum = .popular
    public lazy var mainView = MainScreenView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // Assigning Delegates
        self.selectedCellDelegate = mainView.mainController
        self.movieIdDelegate = mainView.mainController.detailController
        self.movieCollectionDelegate = MovieCollectionViewDelegate(mainController: mainView.mainController, parentCell: self)
        self.movieCollectionDataSource = MovieCollectionViewDataSource(parentCell: self, mainController: mainView.mainController)
        innerCollectionView.delegate = movieCollectionDelegate
        innerCollectionView.dataSource = movieCollectionDataSource
        innerCollectionView.register(PopularMovieCellsView.self, forCellWithReuseIdentifier: PopularMovieCellsView.reuseIdentifier)
        innerCollectionView.register(NowPlayingCellsView.self, forCellWithReuseIdentifier: NowPlayingCellsView.reuseIdentifier)
        innerCollectionView.register(UpcomingCellsView.self, forCellWithReuseIdentifier: UpcomingCellsView.reuseIdentifier)
        innerCollectionView.register(TopRatedCellsView.self, forCellWithReuseIdentifier: TopRatedCellsView.reuseIdentifier)
        // Subviews
        contentView.addSubview(innerCollectionView)
        constraints()
    }
    
    
    private func constraints() {
        // Inner Collection View
        innerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -5).isActive = true
        innerCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        innerCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        innerCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Initial Collection View Cell
        frame.size.width = UIScreen.main.bounds.width - 5
        frame.size.height = 300
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
} // Class End


// MARK: - Collection Extension
public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
