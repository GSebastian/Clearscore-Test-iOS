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
    @IBInspectable var score: Int = 700
    @IBInspectable var maxScore: Int = 700
    @IBInspectable var animationProgress: Float = 1
    
    private var angle: CGFloat {
        let angleStartingAt3 = CGFloat(score) * 2.0 * CGFloat.pi / CGFloat(maxScore)
        let angleStartingAt12 = angleStartingAt3 - (CGFloat.pi / 2)
        return angleStartingAt12
    }
    
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
        circleLayer.strokeEnd = CGFloat(animationProgress)
        
        let arcCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let radius = frame.width / 2
        let circlePath = UIBezierPath(
            arcCenter: arcCenter,
            radius: radius,
            startAngle: (CGFloat.pi / 2) * -1,
            endAngle: angle,
            clockwise: true)
        circleLayer.path = circlePath.cgPath
        
        dialView.layer.addSublayer(circleLayer)
    }
}
