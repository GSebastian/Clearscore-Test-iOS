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
    
    private static var nibName: String = "ScoreView"
    private static var circleAnimationKey: String = "circleAnimationKey"
    
    // MARK: - Outlets
    
    @IBOutlet private var rootView: UIView!
    
    @IBOutlet private weak var dialView: UIView!
    @IBOutlet weak var scoreIntroLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var maxScoreLabel: UILabel!
    @IBOutlet weak var scoreStatusLabel: UILabel!
    
    // MARK: - Configurable Properties
    
    @IBInspectable var circleColor: UIColor = .systemBlue
    @IBInspectable var lineWidth: Float = 4
    @IBInspectable var score: Int = 654
    @IBInspectable var maxScore: Int = 700
    @IBInspectable var duration: CFTimeInterval = 1
    
    // MARK: - Computed Properties
    
    private var angle: CGFloat {
        let angleStartingAt3 = CGFloat(score) * 2.0 * CGFloat.pi / CGFloat(maxScore)
        let angleStartingAt12 = angleStartingAt3 - (CGFloat.pi / 2)
        return angleStartingAt12
    }
    
    private var otherLabels: [UIView] {
        [scoreIntroLabel, maxScoreLabel, scoreStatusLabel]
    }
    
    // MARK: - Other Properties
    
    private let circleLayer = CAShapeLayer()
    
    // MARK: - Init
    
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
        
        animate()
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed(Self.nibName, owner: self, options: nil)
        addSubview(rootView)
        rootView.frame = bounds
        rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        drawCircle()
    }
    
    private func drawCircle() {
        circleLayer.strokeColor = circleColor.cgColor
        circleLayer.backgroundColor = backgroundColor?.cgColor
        circleLayer.fillColor = backgroundColor?.cgColor
        circleLayer.lineWidth = CGFloat(lineWidth)
        circleLayer.strokeEnd = 1
        circleLayer.lineCap = .round
        
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
    
    private func animate() {
        guard !UIAccessibility.isReduceMotionEnabled else { return }
        
        func animateDial() {
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            animation.fromValue = 0.0
            animation.toValue = 1.0
            
            animation.duration = duration
            
            circleLayer.add(animation, forKey: Self.circleAnimationKey)
            
            circleLayer.strokeEnd = 1
        }
        
        func animateLabel() {
            (otherLabels + [scoreLabel]).forEach { $0?.alpha = 0 }
            
            UIView.animate(withDuration: duration) {
                self.scoreLabel.alpha = 1
            }
            
            UIView.animate(withDuration: duration * 1.5) {
                self.otherLabels.forEach { $0.alpha = 1 }
            } completion: { _ in
                self.otherLabels.forEach { $0.alpha = 1 }
            }

        }

        animateDial()
        animateLabel()
    }
}
