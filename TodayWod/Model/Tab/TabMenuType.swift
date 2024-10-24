//
//  TabMenuType.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/18/24.
//

import SwiftUI

enum TabMenuType: CaseIterable {
    case home
    case settings

    var selectedImage: Image {
        switch self {
        case .home:
            Images.icHomeActivate.swiftUIImage
        case .settings:
            Images.icAccountActivate.swiftUIImage
        }
    }

    var deactivatedImage: Image {
        switch self {
        case .home:
            Images.icHomeDisable.swiftUIImage
        case .settings:
            Images.icAccountDisable.swiftUIImage
        }
    }

}
