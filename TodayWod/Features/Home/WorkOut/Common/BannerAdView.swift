//
//  BannerAdView.swift
//  TodayWod
//
//  Created by 오지연 on 11/14/24.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let adSize = GADInlineAdaptiveBannerAdSizeWithWidthAndMaxHeight(geometry.size.width, 86)
            AdmobBannerView(adSize)
        }
        .frame(height: 86)
    }
    
}

#Preview {
    VStack {
        Spacer()
        BannerAdView()
    }
}
