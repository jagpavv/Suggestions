import Foundation
import ActionSheetPicker_3_0


// MARK:- SuggestionButton
//https://stackoverflow.com/questions/37903243/swift-programmatically-create-function-for-button-with-a-closure
class SuggestionButton: UIButton {
  var action: (() -> Void)?

  func suggestionSelected(action: @escaping () -> Void) {
    self.action = action
    self.addTarget(self, action: #selector(clicked(_ :)), for: .touchUpInside)
  }

  @objc func clicked(_ sender: SuggestionButton) {
    action?()
  }
}

// MARK:- AbstractActionSheetPicker+Suggestions
typealias ActionSuggestionDoneBlock = (AbstractActionSheetPicker, Int, String) -> Void

extension AbstractActionSheetPicker {

  func addSuggestions(values: [String], doneBlock: @escaping ActionSuggestionDoneBlock) {

    guard let bgView = actionSheet?.bgView else {
      print("Call .show() first: Suggestions can be added after picker is shown.")
      return
    }

    var f = bgView.frame
    let numOfButtons = CGFloat(values.count)
    let pad: CGFloat = 1.0
    let totalWidth = f.width
    let totalHeight = CGFloat(40)
    let buttonWidth = (totalWidth - (pad * (numOfButtons - 1))) / numOfButtons
    let buttonHeight = totalHeight

    f.size.height += totalHeight
    f.origin.y -= totalHeight
    bgView.frame = f

    let view = UIView(frame: CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight))
    view.backgroundColor = .white

    values.enumerated().forEach { index, value in
      let x = CGFloat(index) * (buttonWidth + pad)
      let y = CGFloat(0)

      let button = SuggestionButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight))
      button.setTitle(value, for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
      button.suggestionSelected {
        doneBlock(self, index, value)
        self.hideWithCancelAction()
      }
      view.addSubview(button)
    }

    bgView.addSubview(view)
  }
}
