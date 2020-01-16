//  Created by Cameron  Partee on 1/16/20.
//  Copyright © 2020 Cameron Partee. All rights reserved.

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // IBOutlet
    @IBOutlet var picBtn: UIButton!
    @IBOutlet var picBtns: [UIButton]!
    @IBOutlet var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // must declare vars in viewDidLoad
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onClickImageView))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(actionPinchGesture))
        picBtn.addGestureRecognizer(panGesture)
        picBtn.addGestureRecognizer(pinchGesture)
    }
    
    @IBAction func addMoreButtons(_ sender: UIButton) {
        let newBtn = UIButton(frame: CGRect(x: 75, y: 300, width: 200, height: 200))
        newBtn.setImage(UIImage(named: "placeholder"), for: .normal)
        picBtns.append(newBtn)
        self.view.addSubview(newBtn)
    }
    
    // MARK: UIImagePickerContoller Functions
    
    // change button image
    @IBAction func changeButtonImage(_ sender: UIButton) {
        // set a pickerController, a delegate and a sourceType
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        // present the picker view
        self.present(image, animated: true)
    }
    
    // set the image picked from the picker view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            picBtn.setImage(image, for: .normal)
        }
        // dismiss picker view
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UIGestureRecognizer Functions
    
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
}
