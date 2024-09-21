//
//  BottomSheetModifier.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/21/24.
//

import SwiftUI

struct BottomSheetModifier<PresentingView: View>: ViewModifier {

    @Binding var isPresented: Bool

    @ViewBuilder var presentingView: PresentingView

    @GestureState private var translation: CGFloat = 0

    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack(alignment: .bottom) {
                if isPresented {
                    VStack {
                        presentingView
                            .transition(.move(edge: .bottom))
                            .cornerRadius(16, corners: [.topLeft, .topRight])
                            .shadow(color: Colors.grey90.swiftUIColor.opacity(0.3), radius: 10)
                            .offset(y: max(self.translation, 0))
                            .gesture(
                                DragGesture().updating(self.$translation) { value, state, _ in
                                    state = value.translation.height
                                }.onEnded { value in
                                    let snapDistance = 200 * 0.25 // TODO: - 200 고정값 주입 필요
                                    guard abs(value.translation.height) > snapDistance else {
                                        return
                                    }
                                    self.isPresented = value.translation.height < 0
                                }
                            )
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut, value: isPresented)
        }
    }

}

extension View {

    func bottomSheet<PresentingView: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder presentingView: @escaping () -> PresentingView
    ) -> some View {
        modifier(BottomSheetModifier(isPresented: isPresented, presentingView: presentingView))
    }

}

struct BottomSheetModifier_Preview: PreviewProvider {

    static var previews: some View {
        VStack {
            Button(action: {
                print("did tap button on the original view")
            }, label: {
                Text("Original View")
            })
            Spacer()
        }
        .bottomSheet(isPresented: .constant(true)) {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        print("did tap button on the original view")
                    }, label: {
                        Text("Presented View")
                    })
                    Spacer()
                }
                .padding()
            }
            .background(.red)
        }
    }

}
