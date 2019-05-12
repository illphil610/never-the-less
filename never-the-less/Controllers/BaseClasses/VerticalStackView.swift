
import UIKit

class VerticalStackView: UIStackView {
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        axis = .vertical
        self.spacing = spacing
        translatesAutoresizingMaskIntoConstraints = false
        arrangedSubviews.forEach({ addArrangedSubview($0) })
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
