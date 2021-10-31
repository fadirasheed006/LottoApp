//
//  WebViewController.swift
//  LOTTO
//
//  Created by Fahad on 31/10/2021.

import UIKit
import WebKit
public class WebViewController:UIViewController{
 let WEBURL = RemoteConfigManager.shared.getUrlType()
    @IBOutlet  var webView:WKWebView!
    @IBOutlet var busyVIew:UIActivityIndicatorView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        bindViewModel()
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
            "head.appendChild(meta);"

        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        webView.configuration.userContentController.addUserScript(script)
        let leftButton = UIButton()
        leftButton.sizeToFit()
        leftButton.setImage(UIImage(named:"backArrow"), for: . normal)
        leftButton.addTarget(self, action:#selector(onBackButton_Clicked), for: UIControl.Event.touchUpInside)
           let barButton = UIBarButtonItem(customView: leftButton)
           self.navigationItem.leftBarButtonItem = barButton

    }
    
    @objc func onBackButton_Clicked(sender: UIButton)
    {
        if(webView.canGoBack) {
            webView.goBack()
        }
        else{
            exit(0)
        }
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureAppearance()
        self.navigationController?.isNavigationBarHidden = false
        self.loadWebRequest()
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
    
    func loadWebRequest() {
        let config = WKWebViewConfiguration()
        config.dataDetectorTypes = [.all]

        let userAgentValue = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"

        webView.customUserAgent = userAgentValue

        
        loadWebRequestForDeepLink()

    }
//
//    override func shouldShowInternetErrorScreen() -> Bool {
//        return true
//    }
//
//    override func internetAvailablePerformRequiredTask() {
//        super.internetAvailablePerformRequiredTask()
//        if shouldShowInternetErrorScreen() {
//            self.loadWebRequest()
//        }
//    }

//    override func internetIsUnavaiableShowErrorMessage() {
//        Commons.hideActivityIndicator()
//            super.internetIsUnavaiableShowErrorMessage()
//    }
    
    fileprivate func bindViewModel() {


    }
}

extension WebViewController {
    
    func configureAppearance() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.configuration.preferences.javaScriptEnabled = true

    }
    
    func loadWebRequestForDeepLink()  {
        
        if let url = URL(string:WEBURL) {
            print(url)
        let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

extension WebViewController: WKNavigationDelegate,WKUIDelegate {
    
  public  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
   // if reachability.connection != .unavailable {
            //Commons.showActivityIndicator()
        busyVIew.startAnimating()
     //   }
    }
    
    
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(navigationAction.request.url?.absoluteString)
//        if let host = navigationAction.request.url?.absoluteString {
//           
//           }
        //self.navigationController?.isNavigationBarHidden = false

        decisionHandler(.allow)
    }
    


  public  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        Commons.hideActivityIndicator()
    busyVIew.stopAnimating()
    
    webView.evaluateJavaScript("document.getElementById('pageTitle').innerHTML") { (result, error) -> Void in
            if error != nil {
                print(error)
            }
            print(result)
        }
    
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))

        present(alertController, animated: true, completion: nil)
    }


    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler(true)
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))

        present(alertController, animated: true, completion: nil)
    }


    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (String?) -> Void) {

        let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .actionSheet)

        alertController.addTextField { (textField) in
            textField.text = defaultText
        }

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(nil)
        }))

        present(alertController, animated: true, completion: nil)
    }
}


   
