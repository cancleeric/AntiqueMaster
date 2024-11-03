import UIKit

class TextInputViewController: UIViewController, UITextFieldDelegate {
    var placeholder: String
    var fontSize: CGFloat
    var fontColor: UIColor
    var backgroundColor: UIColor
    var completion: ((String) -> Void)?

    private var textField: UITextField!

    init(placeholder: String, fontSize: CGFloat, fontColor: UIColor, backgroundColor: UIColor) {
        self.placeholder = placeholder
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)  // 半透明背景

        textField = UITextField(frame: CGRect(x: 20, y: 100, width: 280, height: 50))
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.textColor = fontColor
        textField.backgroundColor = backgroundColor
        textField.delegate = self

        view.addSubview(textField)
        textField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        completion?(textField.text ?? "")
        dismiss(animated: true, completion: nil)
        return true
    }
}
