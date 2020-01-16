//  Created by Cameron  Partee on 1/16/20.
//  Copyright © 2020 Cameron Partee. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // must declare vars in viewDidLoad
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onClickImageView))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(actionPinchGesture))
        btn.addGestureRecognizer(panGesture)
        btn.addGestureRecognizer(pinchGesture)
    }
    
    // MARK: PAN AND PINCH UIGESTURERECOGNIZERS
    
    // pan button
    @objc func onClickImageView(recogizer: UIPanGestureRecognizer) {
        let translation = recogizer.translation(in: self.view)
        if let view = recogizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recogizer.setTranslation(CGPoint.zero, in: self.view)
    }
       
       // zoom button image
    @objc func actionPinchGesture(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
}
