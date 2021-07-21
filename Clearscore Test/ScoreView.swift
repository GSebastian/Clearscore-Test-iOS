//
//  ScoreView.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 21/07/2021.
//

import Foundation
import UIKit

@IBDesignable
class ScoreView: UIView {
    @IBOutlet private var rootView: UIView!
    
    @IBOutlet private weak var dialView: UIView!
    @IBOutlet weak var scoreIntroLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var maxScoreLabel: UILabel!
    @IBOutlet weak var scoreStatusLabel: UILabel!
    
    @IBInspectable var circleColor: UIColor = .systemBlue
    @IBInspectable var lineWidth: Float = 4
    @IBInspectable private(set) var score: Int = 400
    @IBInspectable private(set) var maxScore: Int = 700
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        drawCircle()
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed("ScoreView", owner: self, options: nil)
        addSubview(rootView)
        rootView.frame = bounds
        rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func drawCircle() {
        let circleLayer = CAShapeLayer()
        
        circleLayer.strokeColor = circleColor.cgColor
        circleLayer.backgroundColor = backgroundColor?.cgColor
        circleLayer.fillColor = backgroundColor?.cgColor
        circleLayer.lineWidth = CGFloat(lineWidth)
        
        let arcCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let radius = frame.width / 2
        let circlePath = UIBezierPath(
            arcCenter: arcCenter,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat(Double.pi),
            clockwise: true)
        circleLayer.path = circlePath.cgPath
        
        dialView.layer.addSublayer(circleLayer)
    }
}
