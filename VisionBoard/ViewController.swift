import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var addimageBtn: UIButton!
    @IBOutlet weak var addTextBtn: UIButton!
    
    var currBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.borderWidth = 1.5
        self.view.layer.borderColor = UIColor.black.cgColor
    }
    
    // addtext
    @IBAction func AddTextButton(_ sender: UIButton) {
        let newBtn = UIButton(frame: CGRect(x: 90, y: 210, width: 270, height: 50))
        newBtn.setTitle("Enter text here", for: .normal)
        newBtn.setTitleColor(UIColor.black, for: .normal)
        newBtn.titleLabel?.font = .boldSystemFont(ofSize: 35)
        newBtn.addTarget(self, action: #selector(changeCurrButton), for: .touchUpInside)
        self.view.addSubview(newBtn)
    }
    
    // addbtn
    @IBAction func addImageButton(_ sender: UIButton) {
        let newBtn = UIButton(frame: CGRect(x: 110, y: 200, width: 200, height: 200))
        newBtn.layer.borderWidth = 2
        newBtn.layer.borderColor = UIColor.black.cgColor
        newBtn.setImage(UIImage(named: "placeholder"), for: .normal)
        newBtn.addTarget(self, action: #selector(changeCurrButton), for: .touchUpInside)
        if(sender.tag == 1) {
            newBtn.tag = 1
        }
        self.view.addSubview(newBtn)
    }
    
    // instantiate a pickerviewcontroller
    @objc func changeCurrButton(_ sender: UIButton) {
        // set curr
        currBtn = sender
        // add UIGesture handles to curr
        setUIGestureHandles()
        
        if(sender.tag == 1) {
            // set a pickerController, a delegate and a sourceType
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            image.allowsEditing = false
            // present the picker view
            self.present(image, animated: true)
        } else {
            print("text has been pressed")
            alertWithTF()
        }
    }
    
    func alertWithTF() {
        
        // Step: 1
        let alert = UIAlertController(title: "Rename text", message: "", preferredStyle: UIAlertController.Style.alert )
        
        // Step: 2
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if textField.text != "" {
                print(textField.text!)
                self.currBtn.setTitle(textField.text!, for: .normal)
            } else {
                print("TF 1 is Empty...")
            }
        }

        // Step: 3
        alert.addTextField { (textField) in
            textField.placeholder = "Type new text here"
            textField.textColor = .black
        }

        // Step: 4
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        self.present(alert, animated:true, completion: nil)
    }
    
    // add UIGesture handles to curr
    func setUIGestureHandles() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onClickImageView))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(actionPinchGesture))
        let longPressGesture = UILongPressGestureRecognizer(target: self,  action: #selector(longPressPinchGesture))
        currBtn.addGestureRecognizer(panGesture)
        currBtn.addGestureRecognizer(pinchGesture)
        currBtn.addGestureRecognizer(longPressGesture)
    }
    
    // pan button
    @objc func onClickImageView(recogizer: UIPanGestureRecognizer) {
        let translation = recogizer.translation(in: self.view)
        if let view = recogizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recogizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    // pinch button
    @objc func actionPinchGesture(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    // long press button
    @objc func longPressPinchGesture(recognizer: UILongPressGestureRecognizer) {
        if let view = recognizer.view {
            currBtn = view as! UIButton
            currBtn.removeFromSuperview()
        }
    }
    
    // set the image from the pickerviewcontroller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            currBtn.setImage(image, for: .normal)
        }
        // dismiss picker view
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
