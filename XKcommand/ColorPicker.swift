//
//  ColorPicker.swift
//  XKcommand
//
//  Created by Tao Zong on 3/9/22.
//

import SwiftUI
import UIKit

struct ColorPicker: UIViewRepresentable {
    var color: UIColor
    var delegate: SquarePickerDelegate
    
    func makeUIView(context: Context) -> UIView {
        let colorPicker = SquareColorPicker()
        colorPicker.color = color
        colorPicker.delegate = delegate
        return colorPicker
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

protocol SquarePickerDelegate {
    func colorChanged(newColor color: UIColor)
}

class SquareColorPicker: UIView {
    var delegate: SquarePickerDelegate?
    var backgroundLayer: ColorSquareLayer! = ColorSquareLayer()
    lazy var marker: SimpleSquareMarker = {
        SimpleSquareMarker(picker: self)
    }()
    
    let dragGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    
    func initCommon() {
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(marker)
        
        dragGesture.allowableMovement = 10
        dragGesture.minimumPressDuration = 0
        dragGesture.addTarget(self, action: #selector(handleDrag(_:)))
        addGestureRecognizer(dragGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCommon()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds
        updateMarkerGeometry(marker)
    }
    
    func updateMarkerGeometry(_ marker: SimpleSquareMarker) {
        marker.markerColor = UIColor(
            hue: marker.hue,
            saturation: marker.saturation,
            brightness: 1, alpha: 1)
        marker.position = CGPoint(
            x: marker.hue * bounds.width,
            y: (1 - marker.saturation) * bounds.height)
    }
    
    var color: UIColor {
        get { return marker.color }
        set { marker.color = newValue }
    }
    
    // MARK: - Gestures
    @objc func handleDrag(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            let pos = sender.location(in: self)
            CATransaction.begin()
            CATransaction.setDisableActions(sender.state != .began)
            let hue = min(1, max(0, pos.x / bounds.width))
            let sat = min(1, max(0, 1 - pos.y / bounds.height))
            marker.hue = hue
            marker.saturation = sat
            delegate?.colorChanged(newColor: marker.color)
            CATransaction.commit()
        case .ended, .cancelled:
            break
        default:
            break
        }
    }
}

class ColorSquareLayer: CALayer {
    
    override func layoutSublayers() {
        super.layoutSublayers()
        contentsScale = UIScreen.main.scale
        setNeedsDisplay()
    }
    
    let numberOfSteps: Int = 256
    let pureOffset: CGFloat = 32
    override func draw(in ctx: CGContext) {
        let d = 1.0 / CGFloat(numberOfSteps)
        let dx = d * bounds.width
        for i in 0..<numberOfSteps {
            let hue = d * CGFloat(i)
            let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
            let grad = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                  colors: [color.cgColor, UIColor.white.cgColor] as CFArray,
                                  locations: nil)
            ctx.saveGState()
            ctx.addRect(CGRect(x: dx * CGFloat(i), y: 0, width: dx + 1, height: bounds.height))
            ctx.clip()
            ctx.drawLinearGradient(
                grad!, start: CGPoint(x: 0, y: pureOffset),
                end: CGPoint(x: 0, y: bounds.height),
                options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            ctx.restoreGState()
        }
    }
}

class SimpleSquareMarker: GroupMarkerLayer {
    weak var picker: SquareColorPicker!
    private let defaultRadius: CGFloat = 24
    
    init(picker: SquareColorPicker) {
        super.init()
        self.picker = picker
        self.frame.size = CGSize(width: defaultRadius * 2, height: defaultRadius * 2)
    }
    
    // apply shadow when necessary
    override var markerColor: UIColor {
        didSet {
            let (_, saturation, brightness, _) = getHSBAValue(markerColor)
            if (saturation < 0.2 && brightness > 0.8) {
                shadowOpacity = (0.2 - Float(saturation)) * 2
            } else {
                shadowOpacity = 0
            }
        }
    }
    
    var saturation: CGFloat = 0 {
        didSet {
            picker.updateMarkerGeometry(self)
        }
    }
    
    var hue: CGFloat = 0 {
        didSet {
            picker.updateMarkerGeometry(self)
        }
    }
    
    var color: UIColor {
        get {
            return UIColor(hue: hue, saturation: saturation, brightness: 1, alpha: 1)
        }
        
        set {
            let (h, s, _, _) = getHSBAValue(newValue)
            hue = h
            saturation = s
        }
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class GroupMarkerLayer: CALayer {
    override init() {
        super.init()
        initCommon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCommon()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    private func initCommon() {
        contentsScale = UIScreen.main.scale
        shadowOffset = CGSize.zero
        shadowRadius = 1
    }
    
    override var bounds: CGRect {
        didSet {
            updateGeometry()
        }
    }
    
    /// The background color inside the marker
    var markerColor: UIColor = UIColor.clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// Border width outside the circle
    var glowWidth: CGFloat = 0 {
        didSet {
            updateGeometry()
        }
    }
    
    /// Other of border outside the circle
    var glowColor: UIColor = UIColor.clear {
        didSet {
            updateGeometry()
        }
    }
    
    /// Called when the marker is resized
    private func updateGeometry() {
        setNeedsDisplay()
    }
    
    override func draw(in ctx: CGContext) {
        var size = min(bounds.width, bounds.height)
        let rect = CGRect(x: (bounds.width - size) / 2,
                          y: (bounds.height - size) / 2,
                          width: size, height: size)
        ctx.saveGState()
        if glowWidth > 0 {
            ctx.setFillColor(glowColor.cgColor)
            ctx.fillEllipse(in: rect)
            size -= glowWidth * 2
        }
        
        let circleLineWidth = clamp(size * 0.08, 0.5, 16)
        let inset = circleLineWidth / 2 + glowWidth
        let circleInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        ctx.setFillColor(markerColor.cgColor)
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setLineWidth(circleLineWidth)
        ctx.fillEllipse(in: rect.inset(by: circleInset))
        ctx.strokeEllipse(in: rect.inset(by: circleInset))
        
        ctx.restoreGState()
    }
}

func getHSBAValue(_ color: UIColor) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return (h, s, b, a)
}

func clamp <T: Comparable> (_ value: T, _ low: T, _ high: T) -> T {
  return min(max(value, low), high)
}
