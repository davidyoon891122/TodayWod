//
//  ToastModifier.swift
//  TodayWod
//
//  Created by Davidyoon on 11/11/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    @Binding var toast: ToastModel?
    var yOffset: CGFloat = 0
    
    @State private var workItem: DispatchWorkItem? = nil
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    if let toast = toast {
                        VStack {
                            Spacer()
                            ToastView(toast: toast)
                        }
                        .offset(y: yOffset)
                    }
                }
                    .animation(.spring(), value: toast)
            )
            .onChange(of: toast) { _ in
                configureToast()
            }
    }
    
    private func configureToast() {
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
    
    func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
    
}
