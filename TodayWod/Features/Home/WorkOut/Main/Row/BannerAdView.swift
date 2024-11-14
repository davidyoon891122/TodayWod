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
            let adSize = GADInlineAdaptiveBannerAdSizeWithWidthAndMaxHeight(geometry.size.width, geometry.size.height)
            AdmobBannerView(adSize)
                .background(Colors.grey40.swiftUIColor)
        }
        .frame(height: 86)
        .cornerRadius(12, corners: .allCorners)
        .padding(20)
    }
    
}

#Preview {
    VStack {
        Spacer()
        BannerAdView()
    }
}
