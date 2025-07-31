import UIKit
import CarPlay
import WebKit

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    
    var interfaceController: CPInterfaceController?
    var window: CPWindow?
    private var webView: WKWebView?
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, 
                                didConnect interfaceController: CPInterfaceController) {
        
        self.interfaceController = interfaceController
        
        // Sette opp hoved template
        setupMainTemplate()
    }
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, 
                                didConnect interfaceController: CPInterfaceController, 
                                to window: CPWindow) {
        
        self.window = window
        self.interfaceController = interfaceController
        
        // Opprette WebView for YouTube
        setupWebView()
        
        // Sette opp hoved template
        setupMainTemplate()
    }
    
    private func setupWebView() {
        guard let window = window else { return }
        
        // Konfigurere WebView
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        webView = WKWebView(frame: window.bounds, configuration: webConfiguration)
        webView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Legge til WebView i vinduet
        window.rootViewController = UIViewController()
        window.rootViewController?.view.addSubview(webView!)
        
        // Laste YouTube
        if let url = URL(string: "https://m.youtube.com") {
            let request = URLRequest(url: url)
            webView?.load(request)
        }
    }
    
    private func setupMainTemplate() {
        // Opprette YouTube-knapper
        let watchButton = CPTextButton(title: "YouTube Hjem", textStyle: .normal) { [weak self] _ in
            self?.loadYouTubeURL("https://m.youtube.com")
        }
        
        let searchButton = CPTextButton(title: "Søk", textStyle: .normal) { [weak self] _ in
            self?.showSearchTemplate()
        }
        
        let trendingButton = CPTextButton(title: "Trending", textStyle: .normal) { [weak self] _ in
            self?.loadYouTubeURL("https://m.youtube.com/feed/trending")
        }
        
        let subscriptionsButton = CPTextButton(title: "Abonnementer", textStyle: .normal) { [weak self] _ in
            self?.loadYouTubeURL("https://m.youtube.com/feed/subscriptions")
        }
        
        // Opprette grid template
        let gridTemplate = CPGridTemplate(
            title: "YouTube for CarPlay",
            gridButtons: [
                CPGridButton(titleVariants: ["Hjem"], image: UIImage(systemName: "house.fill") ?? UIImage()) { _ in
                    self.loadYouTubeURL("https://m.youtube.com")
                },
                CPGridButton(titleVariants: ["Søk"], image: UIImage(systemName: "magnifyingglass") ?? UIImage()) { _ in
                    self.showSearchTemplate()
                },
                CPGridButton(titleVariants: ["Trending"], image: UIImage(systemName: "flame.fill") ?? UIImage()) { _ in
                    self.loadYouTubeURL("https://m.youtube.com/feed/trending")
                },
                CPGridButton(titleVariants: ["Abonnementer"], image: UIImage(systemName: "bell.fill") ?? UIImage()) { _ in
                    self.loadYouTubeURL("https://m.youtube.com/feed/subscriptions")
                }
            ]
        )
        
        interfaceController?.setRootTemplate(gridTemplate, animated: false)
    }
    
    private func showSearchTemplate() {
        let searchTemplate = CPSearchTemplate()
        searchTemplate.delegate = self
        interfaceController?.pushTemplate(searchTemplate, animated: true)
    }
    
    private func loadYouTubeURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView?.load(request)
    }
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, 
                                didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
        self.window = nil
    }
}

// MARK: - CPSearchTemplateDelegate
extension CarPlaySceneDelegate: CPSearchTemplateDelegate {
    
    func searchTemplateSearchButtonPressed(_ searchTemplate: CPSearchTemplate) {
        // Søke etter innhold
    }
    
    func searchTemplate(_ searchTemplate: CPSearchTemplate, updatedSearchText searchText: String, completionHandler: @escaping ([CPListItem]) -> Void) {
        // Bygge søke-URL
        let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // Opprette liste-element for søk
        let searchItem = CPListItem(text: "Søk: \(searchText)", detailText: "Trykk for å søke på YouTube")
        
        searchItem.handler = { [weak self] _ in
            self?.loadYouTubeURL("https://m.youtube.com/results?search_query=\(query)")
            self?.interfaceController?.popTemplate(animated: true)
        }
        
        completionHandler([searchItem])
    }
    
    func searchTemplate(_ searchTemplate: CPSearchTemplate, selectedResult item: CPListItem, completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}