//
//  CustomNavigationView.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/15/24.
//

import SwiftUI

enum NavigationType {
    
    case push
    case present
    
}

struct CustomNavigationView: View {

    let type: NavigationType
    let action: (() -> Void)
    
    init(type: NavigationType = .push, action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }

    var body: some View {
        Group {
            if type == .push {
                pushNavigationView
            } else {
                presentNavigationView
            }
        }
        .padding(.horizontal, 12.0)
        .frame(height: 48.0)
    }
    
    var pushNavigationView: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                Images.icArrowBack24.swiftUIImage
            })
            .padding(.horizontal, 8.0)
            Spacer()
        }
    }
    
    var presentNavigationView: some View {
        HStack {
            Spacer()
            Button(action: {
                action()
            }, label: {
                Images.icClose16.swiftUIImage
            })
            .padding(.horizontal, 8.0)
        }
    }
}

#Preview {
    CustomNavigationView(type: .present) {
        print("Did tap back button")
    }
    .border(.gray)
}

#Preview {
    CustomNavigationView(type: .push) {
        print("Did tap back button")
    }
    .border(.gray)
}
