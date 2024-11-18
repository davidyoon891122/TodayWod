//
//  ColorBackgroundSheetModifier.swift
//  TodayWod
//
//  Created by 오지연 on 11/15/24.
//

import UIKit
import SwiftUI

struct ColorBackgroundSheetView: UIViewRepresentable {
    
    let color: UIColor
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.superview?.backgroundColor = color
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
}

struct ColorBackgroundSheetModifier: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content
                .presentationBackground(color)
        } else {
            content
                .background(ColorBackgroundSheetView(color: UIColor(color)))
        }
    }
    
}

extension View {
    
    func sheetBackground(_ color: Color) -> some View {
        self.modifier(ColorBackgroundSheetModifier(color: color))
    }
    
}
