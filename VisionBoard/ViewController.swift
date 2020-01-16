//  Created by Cameron  Partee on 1/16/20.
//  Copyright © 2020 Cameron Partee. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onClickImageView))
        imgView.addGestureRecognizer(panGesture)
              
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(actionPinchGesture))
        imgView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func onClickImageView(recogizer: UIPanGestureRecognizer) {
           let translation = recogizer.translation(in: self.view)
           if let view = recogizer.view {
               view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
           }
           
           recogizer.setTranslation(CGPoint.zero, in: self.view)
       }
       
       
       @objc func actionPinchGesture(recognizer: UIPinchGestureRecognizer) {
           if let view = recognizer.view {
               view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
               recognizer.scale = 1
           }
       }


}

