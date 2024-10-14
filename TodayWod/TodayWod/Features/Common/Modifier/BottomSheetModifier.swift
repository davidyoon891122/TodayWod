//
//  BottomSheetModifier.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/21/24.
//

import SwiftUI

struct BottomSheetModifier<Item: Identifiable, SheetContent: View>: ViewModifier {

    @Binding var item: Item?
    let onDismiss: (() -> Void)?
    let sheetContent: (Item) -> SheetContent

    @GestureState private var translation: CGFloat = 0
    @State private var sheetHeight: CGFloat = 0

    func body(content: Content) -> some View {
        ZStack {
            content
            if let item = item {
                ZStack(alignment: .bottom) {
                    
                    sheetContent(item)
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .onAppear {
                                        self.sheetHeight = geometry.size.height
                                    }
                            }
                        )
                        .transition(.move(edge: .bottom))
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .shadow(color: Color.gray.opacity(0.3), radius: 10)
                        .offset(y: max(self.translation, 0))
                        .gesture(
                            DragGesture()
                                .updating(self.$translation) { value, state, _ in
                                    state = value.translation.height
                                }
                                .onEnded { value in
                                    let snapDistance = self.sheetHeight * 0.25 // Adjust as needed
                                    guard abs(value.translation.height) > snapDistance else {
                                        return
                                    }
                                    withAnimation {
                                        self.item = nil
                                        self.onDismiss?()
                                    }
                                }
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
        }
    }
}

extension View {

    func bottomSheet<Item: Identifiable, Content: View>(
            item: Binding<Item?>,
            onDismiss: (() -> Void)? = nil,
            @ViewBuilder content: @escaping (Item) -> Content
        ) -> some View {
            self.modifier(BottomSheetModifier(item: item, onDismiss: onDismiss, sheetContent: content))
        }

}
