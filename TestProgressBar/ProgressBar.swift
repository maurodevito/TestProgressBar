//
//  ProgressBar.swift
//  TestProgressBar
//
//  Created by Mauro De Vito on 03/02/2021.
//  Copyright © 2021 Mauro De Vito. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable // @IBDesignable provides functionality for live rendering of changes of our custom views directly in a Storyboard or .xib
class ProgressBar: UIView {

    @IBInspectable var color: UIColor = .gray { //  @IBInspectable allows us to create attributes in code that we can assign in a storyboard
        didSet { setNeedsDisplay() }
    }

    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        layer.addSublayer(progressLayer)
    }

    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame = progressRect
        progressLayer.backgroundColor = color.cgColor
    }
    
    func start(secondsForFilling seconds: Double, completion: @escaping (String) -> Void)  {
        self.progress = 0.0
        let singleStep = 0.01
        let timeInterval = seconds / (1 / singleStep)
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            if self.progress >= 1.0 {
                timer.invalidate()
                completion("ProgressBar filled")
            } else {
                self.fillProgressBar(withSingleStep: singleStep)
            }
        }
    }
    
    private func fillProgressBar(withSingleStep step: Double) {
        self.progress += CGFloat(step)
    }
}
