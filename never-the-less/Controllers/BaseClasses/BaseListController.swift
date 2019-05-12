
import UIKit

class BaseListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Init
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
