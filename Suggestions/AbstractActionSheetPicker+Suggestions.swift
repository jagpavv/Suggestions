import Foundation
import ActionSheetPicker_3_0


typealias ActionSuggestionDoneBlock = (AbstractActionSheetPicker, Int, String) -> Void

extension AbstractActionSheetPicker {

  func addSuggestions(values: [String], doneBlock: ActionSuggestionDoneBlock) {

    guard let bgView = actionSheet?.bgView else {
      print("Call .show() first: Suggestions can be added after picker is shown.")
      return
    }

    var f = bgView.frame
    let numOfButtons = CGFloat(values.count)
    let pad: CGFloat = 10.0
    let totalWidth = f.width
    let totalHeight = CGFloat(40)
    let buttonWidth = (totalWidth - (pad * (numOfButtons + 1))) / numOfButtons
    let buttonHeight = totalHeight

    f.size.height += totalHeight
    f.origin.y -= totalHeight
    bgView.frame = f

    for idx in 0..<values.count {

      let title = values[idx]
      let x = (CGFloat(idx) * (buttonWidth + pad)) + pad
      let y = CGFloat(0)

      let button = UIButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight))
      button.setTitle(title, for: .normal)
      button.setTitleColor(.red, for: .normal)
      button.backgroundColor = .lightGray
      button.addTarget(self, action: #selector(suggestionTapped(_ :)), for: .touchUpInside)

      // test doneBlock
      doneBlock(self, idx, title)

      bgView.addSubview(button)
    }

  }

  @objc func suggestionTapped(_ sender: UIButton) {
    print("tapped")
  }
}
