//
//  MouseFollowingEyeballView.swift
//  MacEyes
//
//  Created by Steve Sparks on 12/20/20.
//

import Cocoa

class MouseFollowingEyeball: NSView {
    var eyeStrokeColor: NSColor = .black
    var eyeFillColor: NSColor = .white

    override func draw(_ dirtyRect: NSRect) {
        guard let ctx = NSGraphicsContext.current?.cgContext else {
            return
        }

        ctx.clear(bounds)
        drawOuterEye(into: ctx)
        drawPupil(into: ctx)
    }

    func drawOuterEye(into context: CGContext) {
        let frm = bounds
        let shortside = min(frm.size.width, frm.size.height)
        let linewidth = shortside / 20.0

        let drawFrame = bounds.insetBy(dx: linewidth/2, dy: linewidth/2)

        context.addPath(CGPath(ellipseIn: drawFrame, transform: nil))
        context.setStrokeColor(eyeStrokeColor.cgColor)
        context.setLineWidth(linewidth)
        context.setFillColor(eyeFillColor.cgColor)
        context.drawPath(using: .fillStroke)
    }

    func drawPupil(into context: CGContext) {
        context.setFillColor(eyeStrokeColor.cgColor)

        let angle = angleInRadiansToMouseCursor
        let mySin = (sin(angle) * 0.35) + 0.5
        let myCos = (cos(angle) * 0.35) + 0.5

        let rect = CGRect(x: mySin - 0.1, y: myCos - 0.1, width: 0.2, height: 0.2)
        var xform = CGAffineTransform(scaleX: frame.size.width, y: frame.size.height)

        withUnsafeMutablePointer(to: &xform) { ptr in
            let path = CGPath(ellipseIn: rect, transform: ptr)
            context.addPath(path)
            context.drawPath(using: .fill)
        }
    }
}

extension NSView {
    var angleInRadiansToMouseCursor: CGFloat {
        let me = convert(frame, to: window?.contentView)
        if let screenBounds = window?.convertToScreen(me) {
            let loc = convert(NSEvent.mouseLocation, to: nil)
            let ctr = screenBounds.center
            let dx = ctr - loc
            let angle = atan2(dx.x, dx.y)
            return angle
        } else {
            return 0.0
        }
    }
}


extension CGRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + (size.width / 2.0), y: origin.y + (size.height / 2.0))
    }
}

extension CGPoint {
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: rhs.x - lhs.x, y: rhs.y - lhs.y)
    }
}
