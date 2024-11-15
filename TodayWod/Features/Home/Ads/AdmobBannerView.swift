//
//  AdmobBannerView.swift
//  TodayWod
//
//  Created by 오지연 on 11/14/24.
//

import SwiftUI
import GoogleMobileAds

struct AdmobBannerView: UIViewRepresentable {
    let adSize: GADAdSize
    
    init(_ adSize: GADAdSize) {
        self.adSize = adSize
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        [
            context.coordinator.bannerView,
            context.coordinator.lottieView
        ].forEach {
            view.addSubview($0)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.bannerView.adSize = adSize
        
        context.coordinator.lottieView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func makeCoordinator() -> AdmobBannerCoordinator {
        return AdmobBannerCoordinator(self)
    }
    
}

class AdmobBannerCoordinator: NSObject, GADBannerViewDelegate {
    
    private(set) lazy var bannerView: GADBannerView = {
        let banner = GADBannerView(adSize: parent.adSize)
        banner.adUnitID = PlistReader().getData(type: .admobInfo, key: AdmobConstants.adUnitTestID) ?? ""
        banner.delegate = self
        banner.load(GADRequest())
        return banner
    }()
    
    let lottieView = LottieView(type: .banner)
    
    let parent: AdmobBannerView
    
    init(_ parent: AdmobBannerView) {
        self.parent = parent
        
        self.lottieView.start()
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.lottieView.alpha = 1
        self.bannerView.alpha = 0
        UIView.animate(withDuration: 1.0, animations: {
            self.lottieView.alpha = 0
            self.bannerView.alpha = 1
            
            self.lottieView.stop()
        })
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        DLog.e("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        self.lottieView.alpha = 0
        self.bannerView.alpha = 0
        UIView.animate(withDuration: 1.0, animations: {
            self.lottieView.alpha = 1
        })
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        DLog.d("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        DLog.d("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        DLog.d("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        DLog.d("bannerViewDidDismissScreen")
    }
    
}
