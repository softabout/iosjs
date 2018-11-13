//
//  ViewController.swift
//  EQJavaScriptMesssageTester
//
//  Created by Helmut Pfister on 10.11.18.
//  Copyright © 2018 softabout.de. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else { return completionHandler(.useCredential, nil) }
        let exceptions = SecTrustCopyExceptions(serverTrust)
        SecTrustSetExceptions(serverTrust, exceptions)
        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
    
    override func viewDidLoad() {
        
    
    super.viewDidLoad()
     
        let config = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        config.userContentController = contentController
        let scriptSource = "var messageData = {token: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJjYTEyOThhMC02N2NjLTQ2OTctYjY4Zi02N2M2YTllYzE3NWYiLCJpc3MiOiJodHRwczovL2Rldi5vbmV3ZWIubWVyY2VkZXMtYmVuei5jb20iLCJzdWIiOiJHUmVLblVkRVdzNS13RFc4MHBFUVMwcGlwMjN6R0E1aE5RSXZ3S05zN29nIiwiZXhwIjozMDg0MjExNTY4LCJpYXQiOjE1NDIxMDIxODQsIm9yaWdpbmFsX2lzc3VlciI6Imh0dHBzOi8vYXBpLWNlcnQtdGVzdC5pLmRhaW1sZXIuY29tLyIsImF1dGhfdGltZSI6MTU0MjEwMjE4NCwiZ2VuZGVyIjoiIiwibmFtZSI6IkhvbGdlciBNZXllciIsImZpcnN0X25hbWUiOiJIb2xnZXIiLCJsYXN0X25hbWUiOiJNZXllciIsImVtYWlsIjoiaG9sZ2VyLnNlZW11ZWxsZXJAZGFpbWxlci5jb20iLCJwaG9uZSI6IiIsInJvbGVzIjpbInVzZXIiXX0.gQ14LLx53z35r6AnC4b6yraNCmfYI_P_R7cY0qA75fhZDmO1AUVWTqOi3QM5P0PQHGBLjsFWEL7xSxB1MvG2UYuZKAn8osHOcXTikMguX6EGnmHDRfNs2i41LEO4O86FLoJFSB1e6cBOUiPSYeaREFkMjU1VwyrOJUhdFV_k1cr-tIDtJ4QKraaWum76QFiQi4ptBh014NxC9qzOTWcKDuOKCdTWBrFbUIEYwU20bYsbtutKzOHmjRQ4iAE6WS1DCaJH2upzuYhIx5ZVOGG7eLbJLpzX3D_LCrCPr1E3FoHn0bHRHxhRFUlYXPY7ar6rpwfTV8tt5_Y06u-2ZwvuBmgws0UanWxXX3Yuomnc5pK620PxUsuLDlPVskb1tHg69sDAZjipSl7dNk8X1I9FfaAlFSYqJNIEEV0YwSPwW5_O8Llfd95VHi4ROTnXvYtg20CyYp2OHDIM3Nx28otVuc3iXXQXnGSEwcUEmJjVXqTZ8D2UTjYqeOTnIqbdgw3O64dOqRL7tEvRmQLC0I0KtwemcVBaRM3DXAsfDIA013IeavnOpzR2I5m2x9SbrtdRjVPip0Qp8NWUA1c8Wwr_pswaDL_8QurJ2pEgADkMRPBF2ckxKqAJtancl4nEY4tDsq77Hn7yN_4Qws1IdsMrqiM4R1MfPVnpEZp3wK_ntXk',firstname: 'Holger',lastname: 'Seemüller'}; window.postMessage(messageData, '*');"
        
        let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        let webView = WKWebView(frame: .zero, configuration: config)
        
        view.addSubview(webView)
        let layoutGuide = view.safeAreaLayoutGuide
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        if let url = URL(string: "https://eq-preorder-dev.mercedes-benz.com/public/eqreadyv2.html") {
            webView.load(URLRequest(url: url))
        }
}

}
