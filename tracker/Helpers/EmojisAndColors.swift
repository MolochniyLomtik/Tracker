import UIKit

struct EmojisAndColors {

  static let shared = EmojisAndColors()

  private let colors: [UIColor] = [.ypColorSelection1, .ypColorSelection2, .ypColorSelection3, .ypColorSelection4,
                                   .ypColorSelection5, .ypColorSelection6, .ypColorSelection7, .ypColorSelection8,
                                   .ypColorSelection9, .ypColorSelection10, .ypColorSelection11, .ypColorSelection12,
                                   .ypColorSelection13, .ypColorSelection14, .ypColorSelection15, .ypColorSelection16,
                                   .ypColorSelection17, .ypColorSelection18]
  private let emojis: [String] = ["🙂","😻","🌺","🐶","❤️","😱","😇","😡","🥶","🤔","🍺","🍔","🥦","🏓","🥇","🎸","🏝","😪"]

  private init() { }

  func getColors() -> [UIColor] {
    colors
  }

  func getEmojis() -> [String] {
    emojis
  }

  func randomColor() -> UIColor {
    let color = colors.randomElement()
    guard let color else { return .white }
    return color

  }

  func randomEmoji() -> String {
    let emoji = emojis.randomElement()
    guard let emoji else { return "" }
    return emoji
  }
}
