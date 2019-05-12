
import UIKit

class UpcomingShowFullScreenImageCell: UITableViewCell {
    
    let todayCell = UpcomingShowCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(todayCell)
        todayCell.fillSuperview()
    }
}
