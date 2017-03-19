import UIKit

private let reuseIdentifier = "Cell"

class CardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let apiHelper = HearthApiHelper()
    var cards: [Card] = []
    var itemsPerRow: CGFloat = 2.0
    var itemsPerColumn: CGFloat = 2.0
    var searchText: String = ""
    var mode: Mode = .Search
    var manaCost: Int?
    
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
    }
    
    func loadBackground() {
        self.collectionView?.backgroundView = UIImageView(image: UIImage(named: "background.jpg"))
    }
    
    func searchForCard(word: String) {
        apiHelper.searchForCards(search: word) {
            self.updateCollection(cards: $0)
        }
    }
    
    func searchForClassCollection(playerClass: String) {
        apiHelper.searchForClassCollection(playerClass: playerClass, manaCost: manaCost) {
            self.updateCollection(cards: $0)
        }
    }
    
    func searchForSetCollection(cardSet: String) {
        apiHelper.searchForSetCollection(cardSet: cardSet, manaCost: manaCost) {
            self.updateCollection(cards: $0)
        }
    }
    
    func updateCollection(cards : [Card]) {
        self.cards = cards
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        
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
}
