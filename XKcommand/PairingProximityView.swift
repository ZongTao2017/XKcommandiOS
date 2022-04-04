//
//  PairingProximityView.swift
//  XKcommand
//
//  Created by Tao Zong on 3/11/22.
//

import SwiftUI
import UIKit

struct PairingProximity: UIViewRepresentable {
    @Binding var signal: Float
    @Binding var count: Int
    
    func makeUIView(context: Context) -> PairingProximityView {
        return PairingProximityView()
    }
    
    func updateUIView(_ uiView: PairingProximityView, context: Context) {
        print("signal " + String(signal))
        if (count == 2) {
            uiView.playProgress(1)
        } else {
            uiView.setSignalLevel(signal, animated: true)
        }
    }
}

private func getCirclePath(_ radius : CGFloat = 1) -> UIBezierPath {
    return UIBezierPath(ovalIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2))
}

private let centerOffsetY : CGFloat = 64 + 24

class RadiationBackgroundLayer : CALayer {
    override func layoutSublayers() {
        contentsScale = UIScreen.main.scale
        setNeedsDisplay()
    }
    
    var centerPoint : CGPoint {
        return CGPoint(x: bounds.midX, y: centerOffsetY)
    }
    
    var ringColor : UIColor = hexStringToUIColor(hex:"#009BFF") {
        didSet { setNeedsDisplay() }
    }
    
    var numberOfLevels : Int = 9 {
        didSet { setNeedsDisplay() }
    }
    
    var minRadius : CGFloat = 24 {
        didSet { setNeedsDisplay() }
    }
    
    var radiusScale : CGFloat = 1.65 {
        didSet { setNeedsDisplay() }
    }
    
    override func draw(in ctx: CGContext) {
        // move center to origin
        ctx.saveGState()
        ctx.translateBy(x: centerPoint.x, y: centerPoint.y)
        let circle = getCirclePath()
        ctx.scaleBy(x: minRadius / radiusScale, y: minRadius / radiusScale)
        UIGraphicsPushContext(ctx)
        for i in 0..<numberOfLevels {
            let scale = 1 + radiusScale / CGFloat(i + 1)
            let alpha = 0.9 * pow(CGFloat(i + 1), -0.762)
            let color = ringColor.withAlphaComponent(CGFloat(alpha))
            ctx.scaleBy(x: scale, y: scale)
            ctx.setFillColor(color.cgColor)
            circle.fill()
        }
        UIGraphicsPopContext()
        ctx.restoreGState()
        
        // draw the base circle
        ctx.saveGState()
        UIGraphicsPushContext(ctx)
        let base = UIBezierPath(arcCenter: centerPoint,
                                radius: 110,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2,
                                clockwise: true)
        let pattern: [CGFloat] = [5.0, 5.0]
        base.setLineDash(pattern, count: 2, phase: 0.0)
        base.lineWidth = 2
        ctx.setStrokeColor(UIColor(white: 1, alpha: 0.5).cgColor)
        base.stroke()
        UIGraphicsPopContext()
        ctx.restoreGState()
    }
}

class RadiationCoverLayer : CALayer {
    override func layoutSublayers() {
        contentsScale = UIScreen.main.scale
        setNeedsDisplay()
    }
    
    var centerPoint : CGPoint {
        return CGPoint(x: bounds.midX, y: centerOffsetY)
    }
    
    var maxVisibleRadius : CGFloat {
        return bounds.maxY * 0.7
    }
    
    var minVisibleRadius : CGFloat {
        return 120
    }
    
    var radius : CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }
    
    var maxOpacity : CGFloat = 0.6 {
        didSet { setNeedsDisplay() }
    }
    
    override func draw(in ctx: CGContext) {
        // move center to origin
        let p = 1 - max(0, min(1, (radius - minVisibleRadius) / (maxVisibleRadius - minVisibleRadius)))
        ctx.saveGState()
        UIGraphicsPushContext(ctx)
        if (p > 0) {
            let path = UIBezierPath(rect: bounds)
            let circle = UIBezierPath(arcCenter: centerPoint,
                                      radius: radius,
                                      startAngle: 0,
                                      endAngle: CGFloat.pi * 2,
                                      clockwise: true)
            path.append(circle)
            path.usesEvenOddFillRule = true
            ctx.setFillColor(UIColor(white: 0, alpha: maxOpacity * p).cgColor)
            path.fill()
            ctx.setStrokeColor(UIColor(white: 1, alpha: p).cgColor)
            circle.lineWidth = 2
            circle.stroke()
        }
        UIGraphicsPopContext()
        ctx.restoreGState()
    }
    
}

class PairingProximityView : UIView {
    var update: Bool = true
    let backgroundLayer : RadiationBackgroundLayer = RadiationBackgroundLayer()
    let phoneLayer: CALayer = CALayer()
    let arrowLayer: CALayer = CALayer()
    let coverLayer = RadiationCoverLayer()
    
    var centerPoint : CGPoint {
        return CGPoint(x: bounds.midX, y: centerOffsetY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCommon()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    func initCommon() {
        layer.addSublayer(backgroundLayer)
        
        animateLayer.opacity = 0
        animateLayer.strokeColor = UIColor.white.cgColor
        animateLayer.fillColor = UIColor.clear.cgColor
        animateLayer.lineWidth = 1
        animateLayer.anchorPoint = CGPoint(x: 0, y: 0)
        layer.addSublayer(animateLayer)
        
        let img = UIImage(named: "phone")!.cgImage!
        let scale = UIScreen.main.scale
        phoneLayer.frame = CGRect(x: 0, y: 0,
                                  width: CGFloat(img.width) / scale,
                                  height: CGFloat(img.height) / scale)
        phoneLayer.contents = img
        phoneLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        layer.addSublayer(phoneLayer)
        
        let arrow = UIImage(named: "arrow-up")!.cgImage!
        arrowLayer.frame = CGRect(x: 0, y: 0,
                                  width: CGFloat(arrow.width) / scale,
                                  height: CGFloat(arrow.height) / scale)
        arrowLayer.contents = arrow
        arrowLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        layer.addSublayer(arrowLayer)
        
        layer.addSublayer(coverLayer)
        
        progressLayer.fillColor = hexStringToUIColor(hex:"#009BFF").cgColor
        progressLayer.opacity = 0
        layer.addSublayer(progressLayer)
        
        
        let tick = UIImage(named: "big-tick")!.cgImage!
        tickLayer.frame = CGRect(x: 0, y: 0,
                                 width: CGFloat(tick.width) / scale,
                                 height: CGFloat(tick.height) / scale)
        tickLayer.contents = tick
        tickLayer.anchorPoint = CGPoint(x: 0.5, y: 0.4)
        tickLayer.opacity = 0
        layer.addSublayer(tickLayer)
    }
    
    override func layoutSubviews() {
        backgroundLayer.frame = self.bounds
        coverLayer.frame = self.bounds
        progressLayer.frame = self.bounds
        tickLayer.position = centerPoint
        updatePhoneGeometry()
        
        animateLayer.position = centerPoint
        animateEndPath = getCirclePath(bounds.height * 0.7)
        signalAnimation = true
    }
    
    var signalLevel : Float = 0 {
        didSet { updatePhoneGeometry() }
    }
    
    func setSignalLevel(_ value : Float, animated: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        signalLevel = value
        CATransaction.commit()
    }
    
    var minPhoneY : CGFloat { return centerPoint.y }
    var maxPhoneY : CGFloat { return bounds.maxY * 0.6 }
    
    func updatePhoneGeometry() {
        if update {
            let y = maxPhoneY - CGFloat(signalLevel) * (maxPhoneY - minPhoneY)
            phoneLayer.position = CGPoint(x: bounds.midX, y: y)
            phoneLayer.opacity = 0.7 + 0.3 * signalLevel
            arrowLayer.removeAnimation(forKey: "bouncing")
            arrowLayer.position = CGPoint(x: bounds.midX, y: y - 10)
            arrowLayer.opacity = 1 - signalLevel
            coverLayer.radius = (y - minPhoneY) * 1.3 + phoneLayer.frame.height + 22
        }
    }
    
    // MARK: - animation
    
    let animateLayer = CAShapeLayer()
    let signalAnimationInterval : TimeInterval = 3.0
    var animateStartPath : UIBezierPath = UIBezierPath()
    var animateEndPath : UIBezierPath = UIBezierPath()
    var animateTimer : Timer?
    
    var signalAnimation : Bool {
        get { return (animateTimer == nil) }
        set {
            if (newValue) {
                if (animateTimer != nil) {
                    return
                }
                animateStartPath = getCirclePath(1)
                animateEndPath = getCirclePath(bounds.height * 0.7)
                animateTimer = Timer.scheduledTimer(timeInterval: signalAnimationInterval,
                                                    target: self,
                                                    selector: #selector(animateCircleHandler),
                                                    userInfo: nil,
                                                    repeats: true)
                animateTimer!.fire()
            } else {
                if (animateTimer != nil) {
                    animateTimer!.invalidate()
                    animateTimer = nil
                }
            }
        }
    }
    
    @objc func animateCircleHandler() {
        let aniPath = CABasicAnimation(keyPath: "path")
        aniPath.fromValue = animateStartPath.cgPath
        aniPath.toValue = animateEndPath.cgPath
        aniPath.duration = 1.5
        aniPath.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animateLayer.add(aniPath, forKey: nil)
        
        let aniOpacity = CABasicAnimation(keyPath: "opacity")
        aniOpacity.fromValue = 1.0
        aniOpacity.toValue = 0.0
        aniOpacity.duration = 1.5
        aniOpacity.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animateLayer.add(aniOpacity, forKey: nil)
        
        animateArrowHandler()
    }
    
    func animateArrowHandler() {
        let ani = CAKeyframeAnimation(keyPath: "position")
        let (x, y) = (arrowLayer.position.x, arrowLayer.position.y)
        ani.values = [NSValue(cgPoint: CGPoint(x: x, y: y)),
                      NSValue(cgPoint: CGPoint(x: x, y: y - 5)),
                      NSValue(cgPoint: CGPoint(x: x, y: y))]
        ani.beginTime = CACurrentMediaTime() + 0.5;
        ani.duration = 0.7
        ani.repeatCount = 2
        ani.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        arrowLayer.add(ani, forKey: "bouncing")
    }
    
    // Progress animation
    let progressLayer = CAShapeLayer()
    
    fileprivate func shapeForProgress(_ progress : CGFloat) -> UIBezierPath {
        let radius : CGFloat = 110
        let h = 2 * radius * max(0, min(1, progress))
        let a = acos(1 - h / radius)
        let arc = UIBezierPath(arcCenter: centerPoint,
                               radius: radius,
                               startAngle: CGFloat.pi / 2 - a,
                               endAngle: CGFloat.pi / 2 + a,
                               clockwise: true)
        arc.close()
        return arc
    }
    
    func playProgress(_ duration : Float) {
        if !update {
            return
        }
        update = false
        progressLayer.path = shapeForProgress(1).cgPath
        progressLayer.opacity = 1
        
        let aniPath = CAKeyframeAnimation(keyPath: "path")
        var vals = [CGPath]()
        var i : CGFloat = 0.1
        while (i <= 0.7) {
            vals.append(shapeForProgress(i).cgPath)
            i += 0.02
        }
        aniPath.values = vals
        aniPath.duration = CFTimeInterval(duration)
        aniPath.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        aniPath.calculationMode = CAAnimationCalculationMode.linear
        progressLayer.add(aniPath, forKey: nil)
        
        let aniOpacity = CABasicAnimation(keyPath: "opacity")
        aniOpacity.fromValue = 0.5
        aniOpacity.toValue = 1
        aniOpacity.duration = CFTimeInterval(duration)
        aniOpacity.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.add(aniOpacity, forKey: nil)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(duration), target: self, selector: #selector(showTick), userInfo: nil, repeats: false)
    }
    
    func setProgress(_ value : CGFloat) {
        progressLayer.removeAllAnimations()
        progressLayer.path = shapeForProgress(value).cgPath
        progressLayer.opacity = Float(value * 0.8 + 0.2)
    }
    
    // Tick animation
    let tickLayer: CALayer = CALayer()
    
    @objc func showTick() {
        let aniScale = CABasicAnimation(keyPath: "transform.scale")
        aniScale.fromValue = 0.1
        aniScale.toValue = 1
        aniScale.duration = CFTimeInterval(0.3)
        aniScale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        aniScale.isRemovedOnCompletion = false
        aniScale.fillMode = CAMediaTimingFillMode.forwards
        tickLayer.add(aniScale, forKey: nil)
        
        let aniOpacity = CABasicAnimation(keyPath: "opacity")
        aniOpacity.fromValue = 0
        aniOpacity.toValue = 1
        aniOpacity.duration = CFTimeInterval(0.3)
        aniOpacity.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        aniOpacity.isRemovedOnCompletion = false
        aniOpacity.fillMode = CAMediaTimingFillMode.forwards
        tickLayer.add(aniOpacity, forKey: nil)
        
        postNotification(.xkDonePair)
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
