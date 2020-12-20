//
//  ViewController.swift
//  MacEyes
//
//  Created by Steve Sparks on 12/17/20.
//

import Cocoa

class ViewController: NSViewController {
    var tm: Timer?

    @IBOutlet weak var rightEyeball: MouseFollowingEyeball!
    @IBOutlet weak var leftEyeball: MouseFollowingEyeball!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) {
            self.flagsChanged(with: $0)
            return $0
        }
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved) { _ in
            self.moveEyesToMouse()
        }
        NSEvent.addLocalMonitorForEvents(matching: .mouseMoved) {
            self.moveEyesToMouse()
            return $0
        }
    }

    func moveEyesToMouse() {
        leftEyeball.setNeedsDisplay(leftEyeball.bounds)
        rightEyeball.setNeedsDisplay(rightEyeball.bounds)
    }

    override func flagsChanged(with event: NSEvent) {
        super.flagsChanged(with: event)
        print("viewcontroller \(event.modifierFlags.contains(.control))")
    }
}
