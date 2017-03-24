//
//  LevelSelectionView.swift
//  Tread
//
//  Created by Benjamin Su on 3/23/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit



class LevelSelectionView: UIView {

    var levelView: UICollectionView!
    var backButton = UIButton()
    
    fileprivate let cellIdentifier = "levelCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.blue
        
        loadSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Subview Setup
extension LevelSelectionView {
    
    fileprivate func loadSubviews() {
        loadLevelView()
        loadBackButton()
    }
    
    private func loadLevelView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        layout.itemSize = CGSize(width: 100.0, height: 50.0)
        
        levelView = UICollectionView(frame: CGRect.init(x: 0.0, y: frame.size.height * 0.1, width: frame.size.width, height: frame.size.height * 0.65), collectionViewLayout: layout)
        levelView.dataSource = self
        levelView.delegate = self
        levelView.backgroundColor = UIColor.white
        levelView.register(LevelSelectionCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.addSubview(levelView)
    }
    
    private func loadBackButton() {
        
        backButton.frame = CGRect(x: frame.size.width * 0.25, y: frame.size.height * 0.8, width: frame.size.width * 0.5, height: frame.size.height * 0.1)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        backButton.backgroundColor = UIColor.cyan
        backButton.setTitle("Back", for: .normal)
        self.addSubview(backButton)
    }
    
    @objc private func backButtonAction() {
        NotificationCenter.default.post(name: Notification.Name.landingVC, object: nil)
    }
    
}

//MARK: -Delegate methods for collectionview
extension LevelSelectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LevelSelectionInfo.levels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LevelSelectionCollectionViewCell
        cell.textLabel.text = "Level\(indexPath.item + 1)"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        StageLayout.levelToLoad = indexPath.item + 1
        NotificationCenter.default.post(name: Notification.Name.gameVC, object: nil)
    }
    
}
