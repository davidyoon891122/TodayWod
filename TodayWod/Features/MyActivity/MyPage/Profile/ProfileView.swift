//
//  ProfileView.swift
//  TodayWod
//
//  Created by Davidyoon on 9/25/24.
//

import SwiftUI

struct ProfileView: View {
    
    let nickName: String
    
    let action: (() -> Void)
    
    var body: some View {
        VStack {
            Images.genderMan.swiftUIImage
                .resizable()
                .frame(width: 120.0, height: 120.0)
            
            Text(nickName)
                .font(Fonts.Pretendard.bold.swiftUIFont(size: 20.0))
                .padding(.top, 20.0)
            Button(action: {
                action()
            }, label: {
                Text("프로필 수정")
                    .font(Fonts.Pretendard.regular.swiftUIFont(size: 13.0))
                    .padding(.vertical, 10.0)
                    .padding(.horizontal, 16.0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 4.0)
                            .stroke(.grey40)
                    }
            })
            .tint(.grey100)
            .padding(.top, 10.0)
            .padding(.bottom, 40.0)
        }
    }
}

#Preview {
    ProfileView(nickName: "Nick") {
        print("did tap modify profile button")
    }
}
