//
//  DashboardView.swift
//  Medi-Check
//
//  Created by Kyungsoo Lee on 11/6/23.
//

import SwiftUI
import WebKit

struct DashboardView: UIViewRepresentable {
    
    var urlToLoad: String
    
    //ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        //unwrapping
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        //웹뷰 인스턴스 생성
        let webView = WKWebView()
        
        //웹뷰를 로드한다
        webView.load(URLRequest(url: url))
        return webView
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<DashboardView>) {
        
    }
}

#Preview {
    DashboardView(urlToLoad: "https://dashboard-trainingapps-eks004.sa.wise-paas.com/d/MUrqFy4Sk/medicheck?tab=visualization&edit&from=1700049894496&to=1700222694496&orgId=2283")
}
