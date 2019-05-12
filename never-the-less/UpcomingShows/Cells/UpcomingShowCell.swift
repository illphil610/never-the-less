
import UIKit
import SnapKit

class UpcomingShowCell: UICollectionViewCell {
    
    let categoryLabel: UILabel = {
        let label = UILabel(text: "", font: .boldSystemFont(ofSize: 20))
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(text: "", font: .boldSystemFont(ofSize: 28))
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(text: "", font: .systemFont(ofSize: 16))
        label.numberOfLines = 3
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "prs")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var dataToDisplay: UpcomingShowModel? {
        didSet {
            guard let dataToDisplay = dataToDisplay else { return }
            categoryLabel.text = dataToDisplay.category
            titleLabel.text = dataToDisplay.title
            descriptionLabel.text = dataToDisplay.description
            imageView.image = dataToDisplay.image
            backgroundColor = dataToDisplay.backgroundColor
        }
    }
    
    var topConstraint: NSLayoutConstraint?
    
    override var isHighlighted: Bool {
        didSet {
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = .init(scaleX: 0.9, y: 0.9)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.transform = transform
            }, completion: nil)
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    fileprivate func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 16
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.centerInSuperview(size: CGSize(width: 300, height: 300))
        
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        
        addSubview(stackView)
        stackView.anchor(top: nil,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: .init(top: 24,
                                        left: 24,
                                        bottom: 24,
                                        right: 24))
        
        topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint?.isActive = true
    }
    
}
