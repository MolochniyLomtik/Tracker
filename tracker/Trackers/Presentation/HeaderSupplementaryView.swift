import UIKit

final class HeaderSupplementaryView: UICollectionReusableView {

  private lazy var headerLabel: UILabel = {
    let label = UILabel()
    label.textColor = .ypBlack
    label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews([headerLabel])
    setupTrackersConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureHeader(with text: String) {
    headerLabel.text = text
  }

  private func setupTrackersConstraints() {
    NSLayoutConstraint.activate([
      headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
    ])
  }
}
