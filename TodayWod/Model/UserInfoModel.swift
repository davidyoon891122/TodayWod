//
//  UserInfoModel.swift
//  TodayWod
//
//  Created by Jiwon Yoon on 9/10/24.
//

import Foundation

enum SocialLoginType: Codable {
    case apple
    case google
    case kakao
}

struct UserInfoModel: Codable {

    let userId: String
    let accessToken: String
    let email: String
    let loginType: SocialLoginType

}

extension UserInfoModel {

    static let fake: Self = .init(userId: "qqpo12", accessToken: UUID().uuidString, email: "qqpo12@naver.com", loginType: .apple)

}
