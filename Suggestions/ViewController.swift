import UIKit
import ActionSheetPicker_3_0

class ViewController: UIViewController {

  @IBAction func showPicker(_ sender: UIButton) {

    guard let picker = ActionSheetStringPicker(title: "Tomato", rows: ["10 g", "20 g", "30 g", "40 g"], initialSelection: 0, doneBlock: { (picker, index, values) in
      print("picker: \(String(describing: picker))")
      print("index: \(index)")
      print("values: \(String(describing: values))")
    }, cancel: { ActionStringDoneBlock in return}, origin: sender) else { return }

    picker.show()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
}

