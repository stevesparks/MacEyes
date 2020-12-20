//
//  AppDelegate.swift
//  MacEyes
//
//  Created by Steve Sparks on 12/17/20.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

class Application: NSApplication {
    override init() {
        print("default")
        super.init()
    }
    required init?(coder: NSCoder) {
        print("coder")
        super.init(coder: coder)
    }
}

class AppWindow: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: false)
        alphaValue = 1.0
        backgroundColor = .clear
        isOpaque = false
//        level = NSWindow.Level(rawValue: CGShieldingWindowLevel())
    }

    override func flagsChanged(with event: NSEvent) {
        super.flagsChanged(with: event)
print("flags")
        var style = styleMask
        if event.modifierFlags.contains(.shift) {
            style.insert(.titled)
        } else {
            style.remove(.titled)
        }
        styleMask = style

    }
}
