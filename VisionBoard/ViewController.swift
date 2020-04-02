import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var addBtn: UIButton!
    
    var currBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // addbtn
    @IBAction func addMoreButtons(_ sender: UIButton) {
        let newBtn = UIButton(frame: CGRect(x: 135, y: 200, width: 150, height: 150))
        newBtn.setImage(UIImage(named: "placeholder"), for: .normal)
        newBtn.addTarget(self, action: #selector(changeButtonImage), for: .touchUpInside)
        self.view.addSubview(newBtn)
    }
    
    // instantiate a pickerviewcontroller
    @objc func changeButtonImage(_ sender: UIButton) {
        // set curr
        currBtn = sender
        // add UIGesture handles to curr
        setUIGestureHandles()
        
        // set a pickerController, a delegate and a sourceType
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        // present the picker view
        self.present(image, animated: true)
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
