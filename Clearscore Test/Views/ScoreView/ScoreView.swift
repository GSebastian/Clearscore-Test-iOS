//
//  ScoreView.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 21/07/2021.
//

import Foundation
import UIKit

// Note for interviewer: For some reason, @IBDesignable doesn't want to play nicely. I couldn't debug it, as I ran out of
// time, however @IBDesignable has always been flakey to say the least!

// Note for interviewer: I really wish I had the time to make accessibility better on this. In production, I would look
// at supporting dynamic type, however in this case I just support the reduced motion accessibility setting. If enable,
// the dial does not animate, but rather just appear in the correct position.

@IBDesignable
class ScoreView: UIView {
    
    private static var nibName = "ScoreView"
    private static var circleAnimationKey = "circleAnimationKey"
    private static var labelAnimationKey = "labelAnimationKey"
    
    // MARK: - Outlets
    
    @IBOutlet private var rootView: UIView!
    
    @IBOutlet private weak var dialView: UIView!
    @IBOutlet private weak var scoreIntroLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var maxScoreLabel: UILabel!
    @IBOutlet private weak var scoreStatusLabel: UILabel!
    
    // MARK: - Configurable Properties
    
    @IBInspectable var circleColor: UIColor = .systemBlue
    @IBInspectable var lineWidth: Float = 4
    @IBInspectable var duration: CFTimeInterval = 1
    
    // MARK: - Computed Properties
    
    private var angle: CGFloat {
        guard let viewModel = viewModel else {
            preconditionFailure(MVVMError.missingViewModel.errorDescription ?? "")
        }
        
        let angleStartingAt3 = CGFloat(viewModel.score) * 2.0 * CGFloat.pi / CGFloat(viewModel.maxScore)
        let angleStartingAt12 = angleStartingAt3 - (CGFloat.pi / 2)
        return angleStartingAt12
    }
    
    private var allLabels: [UIView] {
        [scoreLabel, scoreIntroLabel, maxScoreLabel, scoreStatusLabel]
    }
    
    // MARK: - Other Properties
    
    private let circleLayer = CAShapeLayer()
    
    var viewModel: ScoreViewModel? = nil {
        didSet {
            initLabels()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleLayer.superlayer.map { _ in self.circleLayer.removeFromSuperlayer() }
        drawCircle()
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed(Self.nibName, owner: self, options: nil)
        addSubview(rootView)
        rootView.frame = bounds
        rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func initLabels() {
        guard let viewModel = viewModel else {
            preconditionFailure(MVVMError.missingViewModel.errorDescription ?? "")
        }
        
        scoreIntroLabel.text = viewModel.scoreIntroText
        scoreLabel.text = viewModel.scoreText
        maxScoreLabel.text = viewModel.maxScoreText
        scoreStatusLabel.text = viewModel.scoreStatusText
    }
    
    private func drawCircle() {
        circleLayer.strokeColor = circleColor.cgColor
        circleLayer.backgroundColor = UIColor.clear.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
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
        guard !UIAccessibility.isReduceMotionEnabled else {
            viewModel?.animationCompleted()
            return
        }
        
        func createDialAnimation() -> CAAnimation {
            let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = duration
        
            return animation
        }
        
        func createLabelsAnimation() -> CAAnimation {
            let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = duration
            
            return animation
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.viewModel?.animationCompleted()
        }
        circleLayer.add(createDialAnimation(), forKey: Self.circleAnimationKey)
        allLabels.forEach { $0.layer.add(createLabelsAnimation(), forKey: Self.labelAnimationKey) }
        CATransaction.commit()
    }
}
