//
//  LottieView.swift
//  TodayWod
//
//  Created by 오지연 on 11/15/24.
//

import SwiftUI
import Lottie
import SnapKit

enum LottieType: String {
    case banner
}

class LottieView: UIView {
    
    private let type: LottieType
    private let mode: LottieLoopMode
    private var animationView: LottieAnimationView
    
    init(type: LottieType, mode: LottieLoopMode = .loop) {
        self.type = type
        self.mode = mode
        self.animationView = LottieAnimationView(name: type.rawValue)
    
        // setup UI.
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(animationView)
        self.animationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.animationView.loopMode = mode
        self.animationView.contentMode = .scaleAspectFill
        self.animationView.backgroundBehavior = .pauseAndRestore
    }
    
    func start(completion: (() -> Void)? = nil) {
        self.animationView.play { (completed) in
            completion?()
        }
    }
    
    func startProgress(from: CGFloat = 0, to: CGFloat = 1, completion: (() -> Void)? = nil) {
        self.animationView.play(fromProgress: from, toProgress: to) { (completed) in
            completion?()
        }
    }
    
    func stop() {
        self.animationView.stop()
    }

}
