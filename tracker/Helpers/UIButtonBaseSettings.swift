import UIKit

extension UIButton {
  func baseConfiguration(with titleForNormal: String) {
    let button = self
    button.setTitle(titleForNormal, for: .normal)
    button.layer.cornerRadius = 16
    button.backgroundColor = .ypBlack
    button.titleLabel?.textColor = .ypWhite
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
  }
}
