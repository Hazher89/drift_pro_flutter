import UIKit
import WebKit

class ViewController: UIViewController {
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        loadYouTube()
    }
    
    private func setupWebView() {
        // Konfigurere WebView
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        // Opprette WebView
        webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        
        // Legge til i view
        view.addSubview(webView)
        
        // Legge til navigasjonsknapper
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        // Sette opp navigasjonstittel
        title = "YouTube CarPlay Test"
        
        // Legge til knapper i navigasjonsbar
        let homeButton = UIBarButtonItem(
            image: UIImage(systemName: "house.fill"),
            style: .plain,
            target: self,
            action: #selector(goHome)
        )
        
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(showSearch)
        )
        
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refresh)
        )
        
        navigationItem.leftBarButtonItems = [homeButton, searchButton]
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    private func loadYouTube() {
        if let url = URL(string: "https://m.youtube.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc private func goHome() {
        loadYouTube()
    }
    
    @objc private func showSearch() {
        // Vise søkedialog
        let alertController = UIAlertController(title: "YouTube Søk", message: "Skriv inn søkeord", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Søkeord..."
        }
        
        let searchAction = UIAlertAction(title: "Søk", style: .default) { [weak self] _ in
            if let searchText = alertController.textFields?.first?.text,
               !searchText.isEmpty,
               let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: "https://m.youtube.com/results?search_query=\(query)") {
                let request = URLRequest(url: url)
                self?.webView.load(request)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Avbryt", style: .cancel)
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc private func refresh() {
        webView.reload()
    }
}

// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Vise lasting-indikator
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Skjule lasting-indikator
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // Skjule lasting-indikator
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // Vise feilmelding
        let alert = UIAlertController(title: "Feil", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}