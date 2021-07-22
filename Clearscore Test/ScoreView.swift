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
    
    private static var nibName = "ScoreView"
    private static var circleAnimationKey = "circleAnimationKey"
    private static var labelAnimationKey = "labelAnimationKey"
    
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
    @IBInspectable var duration: CFTimeInterval = 1
    
    // MARK: - Computed Properties
    
    private var angle: CGFloat {
        let angleStartingAt3 = CGFloat(viewModel.score) * 2.0 * CGFloat.pi / CGFloat(viewModel.maxScore)
        let angleStartingAt12 = angleStartingAt3 - (CGFloat.pi / 2)
        return angleStartingAt12
    }
    
    private var allLabels: [UIView] {
        [scoreLabel, scoreIntroLabel, maxScoreLabel, scoreStatusLabel]
    }
    
    // MARK: - Other Properties
    
    private let circleLayer = CAShapeLayer()
    
    var viewModel: ScoreViewModel = .preview {
        didSet {
            initSubviews()
        }
    }
    
    var animationCompletionHandler: (() -> Void)?
    
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
        
        initSubviews()
    }
    
    private func initSubviews() {
        circleLayer.superlayer.map { $0.removeFromSuperlayer() }
        drawCircle()
        
        scoreIntroLabel.text = viewModel.scoreIntroText
        scoreLabel.text = viewModel.scoreText
        maxScoreLabel.text = viewModel.maxScoreText
        scoreStatusLabel.text = viewModel.scoreStatusText
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
        guard !UIAccessibility.isReduceMotionEnabled else {
            animationCompletionHandler?()
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
            self?.animationCompletionHandler?()
        }
        circleLayer.add(createDialAnimation(), forKey: Self.circleAnimationKey)
        allLabels.forEach { $0.layer.add(createLabelsAnimation(), forKey: Self.labelAnimationKey) }
        CATransaction.commit()
    }
}
