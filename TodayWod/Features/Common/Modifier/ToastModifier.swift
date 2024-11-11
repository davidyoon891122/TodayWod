//
//  ToastModifier.swift
//  TodayWod
//
//  Created by Davidyoon on 11/11/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    @Binding var toast: ToastModel?
    @State private var workItem: DispatchWorkItem?
    
    var yOffset: CGFloat = -32.0
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: yOffset)
                }
                    .animation(.spring(), value: toast)
            )
            .onChange(of: toast) { _ in
                showToast()
            }
    }
    
    @ViewBuilder
    func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                ToastView(toast: toast)
            }
        }
    }
    
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
    
}
