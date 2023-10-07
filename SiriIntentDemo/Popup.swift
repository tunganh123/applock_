//
//  Popup.swift
//  SiriIntentDemo
//
//  Created by Tung Anh on 07/09/2023.
//

import UIKit

class Popup: UIView {
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var lb1: UILabel!
    
    @IBOutlet var lb2: UILabel!
    @IBAction func go(_ sender: UIButton) {}

    @IBAction func cancel(_ sender: UIButton) {}
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height))
    }

    func xibSetup(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }

    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Popup", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }
}
