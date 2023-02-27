//
//  HalfCircleProgress.swift
//  WeCare
//
//  Created by Yago Marques on 26/02/23.
//

import Foundation
import UIKit

final class HalfCircleProgress: UIView {
    private var progressLayer: CAShapeLayer!
    private var fullSize: CGSize!
    private var grayCircleSize: CGSize!
    private var innerGrayCircleSize: CGSize!
    private var greenCircleSize: CGSize!
    var value: CGFloat = 0.0
    var isInnerCircleExist: Bool

    func getBackgroundCircle() -> CAShapeLayer {
        let center = CGPoint(x: fullSize.width / 2, y: fullSize.height)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(
            withCenter: center,
                    radius: grayCircleSize.width / 2,
                    startAngle: .pi,
                    endAngle: 2 * .pi,
                    clockwise: true
        )
        beizerPath.close()
        let innerGrayCircle = CAShapeLayer()
        innerGrayCircle.path = beizerPath.cgPath
        innerGrayCircle.fillColor = UIColor(named: "backgroundColor")?.cgColor
        return innerGrayCircle
    }

    func getOverleyCircle() -> CAShapeLayer {
        let center = CGPoint(x: fullSize.width / 2, y: CGFloat(fullSize.height+1))
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(
            withCenter: center,
            radius: innerGrayCircleSize.width / 2.3,
                    startAngle: .pi,
                    endAngle: 2 * .pi,
                    clockwise: true
        )
        beizerPath.close()
        let innerGrayCircle = CAShapeLayer()
        innerGrayCircle.path = beizerPath.cgPath
        innerGrayCircle.fillColor = UIColor(named: "backgroundColor")?.cgColor
        return innerGrayCircle
    }

    func getProgressCircle() -> CAShapeLayer {
        let center = CGPoint(x: fullSize.width / 2, y: fullSize.height)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(
            withCenter: center,
                    radius: greenCircleSize.width / 2,
                    startAngle: .pi,
                    endAngle: .pi,
                    clockwise: true
        )
        beizerPath.close()
        let greenCircleLayer = CAShapeLayer()
        greenCircleLayer.path = beizerPath.cgPath
        greenCircleLayer.fillColor = UIColor.green.cgColor
        return greenCircleLayer
    }

    func drawShape(bounds: CGRect) {
        fullSize = bounds.size
        grayCircleSize = fullSize
        greenCircleSize = CGSize(width: bounds.width - 6.0, height: bounds.width - 6.0)
        innerGrayCircleSize = CGSize(width: greenCircleSize.width - 44.0,
                                     height: greenCircleSize.width - 44.0)
        let outerCicrcle = getBackgroundCircle()
        let greenCircle = getProgressCircle()
        progressLayer = greenCircle
        self.layer.addSublayer(outerCicrcle)
        self.layer.addSublayer(greenCircle)
        if isInnerCircleExist {
            let innerGrayCircle = getOverleyCircle()
            self.layer.addSublayer(innerGrayCircle)
        }

        self.layer.masksToBounds = true
    }

    func updateProgress(percent: CGFloat) {
        var newValue: CGFloat = 0.0
        if percent < 0.0 {
            newValue = 0.0
        } else if percent > 1.0 {
            newValue = 1.0
        } else {
            newValue = percent
        }
        value = newValue
        let width = fullSize.width
        let center = CGPoint(x: width / 2, y: width / 2)
        let startAngle: CGFloat = .pi
        let endAngle: CGFloat = .pi + newValue * .pi
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center,
                    radius: greenCircleSize.width / 2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: true)
        path.close()

        UIView.transition(
            with: self,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                self.progressLayer.path = path.cgPath
            }
        )

    }

    init(isInnerCircleExist: Bool = false) {
        self.isInnerCircleExist = isInnerCircleExist
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

