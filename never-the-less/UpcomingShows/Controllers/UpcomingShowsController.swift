
import UIKit

class UpcomingShowsController: BaseListController {
    
    // MARK: - Properties
    
    static let cellHeight: CGFloat = 500
    
    fileprivate var dataToDisplay = [UpcomingShowModel]()
    
    fileprivate var startingFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    fileprivate var todayFullscreenController: UpcomingShowFullScreenController?
    fileprivate var anchoredConstraints: AnchoredConstraints?
    fileprivate let blurVisualEffectview = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    fileprivate var appFullscreenBeginOffset: CGFloat = 0
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(blurVisualEffectview)
        blurVisualEffectview.fillSuperview()
        blurVisualEffectview.isHidden = true
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        
        collectionView.register(UpcomingShowCell.self, forCellWithReuseIdentifier: UpcomingShowModel.CellType.single.rawValue)
        
        collectionView.contentInset = UIEdgeInsets(top: 32,
                                                   left: 0,
                                                   bottom: 32,
                                                   right: 0)
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            
            self.dataToDisplay.append(UpcomingShowModel(cellType: .single,
                                                 category: "May 17, 2019",
                                                 title: "The Pick!",
                                                 image: #imageLiteral(resourceName: "johnny_phil"),
                                                 description: "Never The Less @ The Pick. Phoenixville, Pa.",
                                                 backgroundColor: .white))
            
            self.dataToDisplay.append(UpcomingShowModel(cellType: .single,
                                                 category: "July 27, 2019",
                                                 title: "Molly McGuires!",
                                                 image: #imageLiteral(resourceName: "full band"),
                                                 description: "Never The Less @ Molly McGuires. Phoenixville, Pa.",
                                                 backgroundColor: .white))
            
            self.dataToDisplay.append(UpcomingShowModel(cellType: .single,
                                                 category: "August 31, 2019",
                                                 title: "Molly McGuires!",
                                                 image: #imageLiteral(resourceName: "prs"),
                                                 description: "Never The Less @ Molly McGuires. Phoenixville, Pa.",
                                                 backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension UpcomingShowsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataToDisplay.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = dataToDisplay[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingShowModel.CellType.single.rawValue, for: indexPath) as? UpcomingShowCell else { return UICollectionViewCell() }
        
        cell.dataToDisplay = data
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension UpcomingShowsController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: UpcomingShowsController.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}

// MARK: - UIGestureRecognizerDelegate

extension UpcomingShowsController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UICollectionViewDelegate

extension UpcomingShowsController {
    
    
    @objc fileprivate func handleRemoveTodayFullscreen() {
        blurVisualEffectview.isHidden = true
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.todayFullscreenController?.tableView.contentOffset = .zero
            
            self.todayFullscreenController?.view.transform = .identity
            
            self.anchoredConstraints?.top?.constant = self.startingFrame.origin.y
            self.anchoredConstraints?.leading?.constant = self.startingFrame.origin.x
            self.anchoredConstraints?.width?.constant = self.startingFrame.width
            self.anchoredConstraints?.height?.constant = self.startingFrame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = .identity
            
            guard let cell = self.todayFullscreenController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? UpcomingShowFullScreenImageCell else { return }
            self.todayFullscreenController?.closeButton.alpha = 0
            cell.todayCell.topConstraint?.constant = 24
            self.view.layoutIfNeeded()
            
        }, completion: { _ in
            self.todayFullscreenController?.view?.removeFromSuperview()
            self.todayFullscreenController?.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UpcomingShowCell else { return }
        
        // Need to get absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
    }
    
    fileprivate func setupSingleAppFullscreenController(_ indexPath: IndexPath) {
        let todayFullscreenController = UpcomingShowFullScreenController()
        todayFullscreenController.view.layer.cornerRadius = 16
        todayFullscreenController.dataToDisplay = dataToDisplay[indexPath.item]
        todayFullscreenController.dismissHandler = {
            self.handleRemoveTodayFullscreen()
        }
        addChild(todayFullscreenController)
        self.todayFullscreenController = todayFullscreenController
        
        // Add gesture to handle swipe to dismiss
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeToDismiss))
        gesture.delegate = self
        self.todayFullscreenController?.view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func handleSwipeToDismiss(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            appFullscreenBeginOffset = todayFullscreenController?.tableView.contentOffset.y ?? 0
        }
        
        let translationY = gesture.translation(in: self.todayFullscreenController?.view).y
        
        if self.todayFullscreenController?.tableView.contentOffset.y ?? 0 > CGFloat(0) {
            return
        }
        
        if gesture.state == .changed {
            if translationY > 0 {
                let trueOffset = translationY - appFullscreenBeginOffset
                
                var scale = 1 - trueOffset / 1000
                scale = min(1, scale)
                scale = max(0.5, scale)
                let transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
                self.todayFullscreenController?.view.transform = transform
            }
            
        } else if gesture.state == .ended {
            if translationY > 0 {
                handleRemoveTodayFullscreen()
            }
        }
    }
    
    fileprivate func setupSingleAppFullscreenStartingPosition(_ indexPath: IndexPath) {
        guard let todayFullscreenControllerView = todayFullscreenController?.view else { return }
        view.addSubview(todayFullscreenControllerView)
        
        setupStartingCellFrame(indexPath)
        
        self.anchoredConstraints = todayFullscreenControllerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
    }
    
    fileprivate func beginFullscreenControllerAnimation() {
        // Add blur effect to background so it looks good when we swipe to dismiss
        blurVisualEffectview.isHidden = false
        
        self.collectionView.isUserInteractionEnabled = false
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = self.todayFullscreenController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? UpcomingShowFullScreenImageCell else { return }
            cell.todayCell.topConstraint?.constant = 44
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullscreen(_ indexPath: IndexPath){
        setupSingleAppFullscreenController(indexPath)
        
        setupSingleAppFullscreenStartingPosition(indexPath)
        
        beginFullscreenControllerAnimation()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch dataToDisplay[indexPath.item].cellType {
        case .multiple:
            showSingleAppFullscreen(indexPath)
        case.single:
            showSingleAppFullscreen(indexPath)
        }
    }
}
