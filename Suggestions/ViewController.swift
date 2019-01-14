import UIKit
import ActionSheetPicker_3_0

class ViewController: UIViewController {

  var picker: ActionSheetStringPicker?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  private func showPicker() {
    guard let picker = ActionSheetStringPicker(title: "Tomato", rows: ["10 g", "20 g", "30 g", "40 g", "50 g", "60 g", "70 g", "80 g", "90 g", "100 g", "200 g"], initialSelection: 0, doneBlock: { (picker, index, values) in
      print("picker: \(String(describing: picker))")
      print("index: \(index)")
      print("values: \(String(describing: values))")
    }, cancel: { ActionStringDoneBlock in return}, origin: self.view) else { return }

    picker.show()
    self.picker = picker
  }

  private func addSuggestions(values: [String]) {
    guard let bgView = self.picker?.actionSheet.bgView else {
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

      bgView.addSubview(button)
    }
  }

  @IBAction func showPicker(_ sender: UIButton) {
    showPicker()
  }

  @IBAction func showSuggestionsPicker(_ sender: UIButton) {
    showPicker()
    addSuggestions(values: ["10 g", "20 g", "50 g", "200 g"])
  }

  @objc func suggestionTapped(_ sender: UIButton) {
    print("tapped")
  }
}

