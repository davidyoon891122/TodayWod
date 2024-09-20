//
//  CustomDivider.swift
//  SwiftUICustomView
//
//  Created by Davidyoon on 2023/12/11.
//

import SwiftUI

enum DividerDirectionType {
    
    case horizontal
    case vertical
    
}

struct CustomDivider: View {
    
    let color: Color
    let size: CGFloat
    let direction: DividerDirectionType
    
    init(
        color: Color = Colors.grey100.swiftUIColor,
        size: CGFloat = 1.0,
        direction: DividerDirectionType = .horizontal
    ) {
        self.color = color
        self.size = size
        self.direction = direction
    }
    
    var body: some View {
        switch direction {
        case .horizontal:
            color
                .frame(height: size)
        case .vertical:
            color
                .frame(width: size)
        }
    }
    
}

#Preview {
    CustomDivider(color: Colors.blue10.swiftUIColor, direction: .horizontal)
}
