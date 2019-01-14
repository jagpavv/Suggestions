import UIKit
import ActionSheetPicker_3_0

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  private func newPicker() -> ActionSheetStringPicker? {
    guard let picker = ActionSheetStringPicker(title: "Tomato", rows: ["10 g", "20 g", "30 g", "40 g", "50 g", "60 g", "70 g", "80 g", "90 g", "100 g", "200 g"], initialSelection: 0, doneBlock: { (picker, index, values) in
      print("picker: \(String(describing: picker))")
      print("index: \(index)")
      print("values: \(String(describing: values))")
    }, cancel: { ActionStringDoneBlock in return}, origin: self.view) else { return nil }

    return picker
  }

  @IBAction func showPicker(_ sender: UIButton) {
    guard let picker = newPicker() else { return }
    picker.show()
  }

  @IBAction func showSuggestionsPicker(_ sender: UIButton) {
    guard let picker = newPicker() else { return }
    picker.show()
    picker.addSuggestions(values: ["10 g", "20 g", "50 g", "200 g"])
  }
}
