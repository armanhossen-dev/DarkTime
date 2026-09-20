import Cocoa
import WebKit

class DarkTimeWindow: NSWindow {
    override var canBecomeKey: Bool { return true }
    override var canBecomeMain: Bool { return true }

    override func keyDown(with event: NSEvent) {
        // Handle F11 for fullscreen toggle
        if event.keyCode == 103 { // F11
            self.toggleFullScreen(nil)
            return
        }
        // Handle Escape to exit fullscreen
        if event.keyCode == 53 && self.styleMask.contains(.fullScreen) { // Escape
            self.toggleFullScreen(nil)
            return
        }
        super.keyDown(with: event)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    var window: DarkTimeWindow!
    var webView: WKWebView!

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenu()
        setupWindow()
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "toggleFullScreen" {
            window?.toggleFullScreen(nil)
        }
    }

    func setupWindow() {
        let screenRect = NSScreen.main?.visibleFrame ?? NSRect(x: 100, y: 100, width: 1200, height: 760)
        let windowWidth: CGFloat = min(1200, screenRect.width * 0.85)
        let windowHeight: CGFloat = min(760, screenRect.height * 0.85)
        let rect = NSRect(
            x: screenRect.midX - (windowWidth / 2),
            y: screenRect.midY - (windowHeight / 2),
            width: windowWidth,
            height: windowHeight
        )

        window = DarkTimeWindow(
            contentRect: rect,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "DarkTime"
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.backgroundColor = .black
        window.isOpaque = true
        window.minSize = NSSize(width: 500, height: 350)
        window.delegate = self
        window.appearance = NSAppearance(named: .darkAqua)
        window.isMovableByWindowBackground = true

        // WebKit Configuration
        let config = WKWebViewConfiguration()
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        config.defaultWebpagePreferences = prefs
        config.preferences.setValue(true, forKey: "developerExtrasEnabled")
        if #available(macOS 12.3, *) {
            config.preferences.isElementFullscreenEnabled = true
        }

        // Script Message Handler for Native Fullscreen Toggle
        let contentController = WKUserContentController()
        contentController.add(self, name: "toggleFullScreen")

        // Injected helper: double click anywhere on document or .hero communicates directly with macOS window
        let scriptSource = """
        window.addEventListener('DOMContentLoaded', () => {
            const hero = document.querySelector('.hero') || document.body;
            hero.addEventListener('dblclick', () => {
                if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleFullScreen) {
                    window.webkit.messageHandlers.toggleFullScreen.postMessage({});
                }
            });
        });
        """
        let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)

        config.userContentController = contentController

        webView = WKWebView(frame: rect, configuration: config)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.setValue(false, forKey: "drawsBackground") // Deep black
        webView.autoresizingMask = [.width, .height]
        window.contentView = webView

        // Load local www assets
        if let resourceURL = Bundle.main.resourceURL {
            let wwwURL = resourceURL.appendingPathComponent("www")
            let indexURL = wwwURL.appendingPathComponent("index.html")
            if FileManager.default.fileExists(atPath: indexURL.path) {
                webView.loadFileURL(indexURL, allowingReadAccessTo: wwwURL)
            } else {
                // Fallback to bundle root or display error
                let rootIndex = resourceURL.appendingPathComponent("index.html")
                webView.loadFileURL(rootIndex, allowingReadAccessTo: resourceURL)
            }
        }

        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    func setupMenu() {
        let mainMenu = NSMenu()

        // App Menu
        let appMenuItem = NSMenuItem()
        let appMenu = NSMenu()
        appMenu.addItem(withTitle: "About DarkTime", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: "")
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(withTitle: "Hide DarkTime", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h")
        let hideOthers = NSMenuItem(title: "Hide Others", action: #selector(NSApplication.hideOtherApplications(_:)), keyEquivalent: "h")
        hideOthers.keyEquivalentModifierMask = [.command, .option]
        appMenu.addItem(hideOthers)
        appMenu.addItem(withTitle: "Show All", action: #selector(NSApplication.unhideAllApplications(_:)), keyEquivalent: "")
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(withTitle: "Quit DarkTime", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        appMenuItem.submenu = appMenu
        mainMenu.addItem(appMenuItem)

        // View Menu
        let viewMenuItem = NSMenuItem()
        let viewMenu = NSMenu(title: "View")
        let toggleFS = NSMenuItem(title: "Toggle Full Screen", action: #selector(toggleFullScreenAction(_:)), keyEquivalent: "f")
        toggleFS.keyEquivalentModifierMask = [.command, .control]
        viewMenu.addItem(toggleFS)
        let reload = NSMenuItem(title: "Reload", action: #selector(reloadAction(_:)), keyEquivalent: "r")
        viewMenu.addItem(reload)
        viewMenuItem.submenu = viewMenu
        mainMenu.addItem(viewMenuItem)

        // Window Menu
        let windowMenuItem = NSMenuItem()
        let windowMenu = NSMenu(title: "Window")
        windowMenu.addItem(withTitle: "Minimize", action: #selector(NSWindow.performMiniaturize(_:)), keyEquivalent: "m")
        windowMenu.addItem(withTitle: "Zoom", action: #selector(NSWindow.performZoom(_:)), keyEquivalent: "")
        windowMenu.addItem(NSMenuItem.separator())
        windowMenu.addItem(withTitle: "Close", action: #selector(NSWindow.performClose(_:)), keyEquivalent: "w")
        windowMenuItem.submenu = windowMenu
        mainMenu.addItem(windowMenuItem)

        NSApp.mainMenu = mainMenu
    }

    @objc func toggleFullScreenAction(_ sender: Any?) {
        window?.toggleFullScreen(nil)
    }

    @objc func reloadAction(_ sender: Any?) {
        webView?.reload()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
