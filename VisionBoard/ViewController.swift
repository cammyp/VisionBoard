//  Created by Cameron  Partee on 1/16/20.
//  Copyright © 2020 Cameron Partee. All rights reserved.

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    // MARK: Outlets, Variables and Actions
    
    
    // Outlets and Variables
    @IBOutlet weak var addBtn: UIButton!
    var currBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // add btn functionality
    @IBAction func addMoreButtons(_ sender: UIButton) {
        let newBtn = UIButton(frame: CGRect(x: self.view.bounds.width / 2, y: 300, width: 150, height: 150))
        newBtn.setImage(UIImage(named: "placeholder"), for: .normal)
        newBtn.addTarget(self, action: #selector(changeButtonImage), for: .touchUpInside)
        self.view.addSubview(newBtn)
    }
    
    
    
    // MARK: UIImagePickerContoller Functions
    
    
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
    
    // set the image from the pickerviewcontroller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            currBtn.setImage(image, for: .normal)
        }
        // dismiss picker view
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: UIGestureRecognizer Functions
    
    
    // add UIGesture handles to curr
    func setUIGestureHandles() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onClickImageView))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(actionPinchGesture))
        currBtn.addGestureRecognizer(panGesture)
        currBtn.addGestureRecognizer(pinchGesture)
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
}
