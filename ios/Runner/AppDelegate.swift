import Flutter
import UIKit
import CarPlay

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Configure CarPlay
    let carPlayManager = CarPlayManager.shared
    carPlayManager.delegate = self
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// MARK: - CarPlayManager
class CarPlayManager: NSObject {
  static let shared = CarPlayManager()
  weak var delegate: CarPlayManagerDelegate?
  
  private override init() {
    super.init()
  }
}

protocol CarPlayManagerDelegate: AnyObject {
  func carPlayManager(_ manager: CarPlayManager, didConnect interfaceController: CPInterfaceController)
  func carPlayManager(_ manager: CarPlayManager, didDisconnect interfaceController: CPInterfaceController)
}

extension AppDelegate: CarPlayManagerDelegate {
  func carPlayManager(_ manager: CarPlayManager, didConnect interfaceController: CPInterfaceController) {
    print("CarPlay connected")
    setupCarPlayInterface(interfaceController)
  }
  
  func carPlayManager(_ manager: CarPlayManager, didDisconnect interfaceController: CPInterfaceController) {
    print("CarPlay disconnected")
  }
  
  private func setupCarPlayInterface(_ interfaceController: CPInterfaceController) {
    // Create YouTube template
    let template = createYouTubeTemplate()
    interfaceController.setRootTemplate(template, animated: true)
  }
  
  private func createYouTubeTemplate() -> CPTemplate {
    let title = "YouTube Test"
    
    // Create list items for YouTube videos
    let items = [
      CPListItem(text: "Test Video 1", detailText: "YouTube Test Video"),
      CPListItem(text: "Test Video 2", detailText: "Another Test Video"),
      CPListItem(text: "Test Video 3", detailText: "Third Test Video")
    ]
    
    let listTemplate = CPListTemplate(title: title, sections: [
      CPListSection(items: items)
    ])
    
    return listTemplate
  }
}
