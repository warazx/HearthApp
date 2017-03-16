//
//  CardCollectionViewController.swift
//  HearthApp
//
//  Created by Christian Karlsson on 2017-03-09.
//  Copyright © 2017 Christian Karlsson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let apiHelper = HearthApiHelper()
    var cards : [Card] = []
    var itemsPerRow : CGFloat = 2.0
    var itemsPerColumn : CGFloat = 2.0
    var searchText : String = ""
    var mode : Mode = .Search
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackground()
        switch(mode) {
        case .Search:
            searchForCard(word: searchText)
        case .Class:
            searchForClassCollection(playerClass: searchText)
        case .Set:
            searchForSetCollection(cardSet: searchText)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        /* Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)*/

        // Do any additional setup after loading the view.
    }
    
    func loadBackground() {
        
        self.collectionView?.backgroundView = UIImageView(image: UIImage(named: "background.jpg"))
        //self.collectionView?.backgroundColor = UIColor(patternImage: bgImage)
    }
    
    func searchForCard(word: String) {
        apiHelper.searchForCards(search: word) {
            self.updateCollection(cards: $0)
        }
    }
    
    func searchForClassCollection(playerClass: String) {
        apiHelper.searchForClassCollection(playerClass: playerClass) {
            self.updateCollection(cards: $0)
        }
    }
    
    func searchForSetCollection(cardSet: String) {
        apiHelper.searchForSetCollection(cardSet: cardSet) {
            self.updateCollection(cards: $0)
        }
    }
    
    func updateCollection(cards : [Card]) {
        self.cards = cards
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            NSLog("Reloading cells... cards contain \(cards.count)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        
        // Configure the cell
        let currentCard = cards[indexPath.row]
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: currentCard.imageURL) {
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                cell.ImageView.image = image
                }
            } else {
                NSLog("Unable to load image")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = view.bounds
        var cellWidth = screenRect.width
        var cellHeight = screenRect.height * 0.85
        if cards.count > 1 {
            cellWidth /= itemsPerColumn
            cellHeight /= itemsPerRow
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    enum Mode {
        case Search
        case Class
        case Set
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}
