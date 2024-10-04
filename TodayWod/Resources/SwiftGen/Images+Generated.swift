// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Images {
  internal static let icLogo = ImageAsset(name: "ic_logo")
  internal static let icInfo16 = ImageAsset(name: "ic_Info_16")
  internal static let icAccountActivate = ImageAsset(name: "ic_account_activate")
  internal static let icAccountDisable = ImageAsset(name: "ic_account_disable")
  internal static let icAdd16 = ImageAsset(name: "ic_add_16")
  internal static let icAdd24 = ImageAsset(name: "ic_add_24")
  internal static let icArrowBack16 = ImageAsset(name: "ic_arrow_back_16")
  internal static let icArrowBack24 = ImageAsset(name: "ic_arrow_back_24")
  internal static let icCheck16 = ImageAsset(name: "ic_check_16")
  internal static let icCheck24 = ImageAsset(name: "ic_check_24")
  internal static let icCheckBox = ImageAsset(name: "ic_check_box")
  internal static let icCheckEmpty = ImageAsset(name: "ic_check_empty")
  internal static let icChevronBack = ImageAsset(name: "ic_chevron_back")
  internal static let icChevronBack16 = ImageAsset(name: "ic_chevron_back_16")
  internal static let icChevronForward = ImageAsset(name: "ic_chevron_forward")
  internal static let icChevronForward16 = ImageAsset(name: "ic_chevron_forward_16")
  internal static let icCircleCheckOpacity80 = ImageAsset(name: "ic_circle_check_opacity_80")
  internal static let icClose16 = ImageAsset(name: "ic_close_16")
  internal static let icHomeActivate = ImageAsset(name: "ic_home_activate")
  internal static let icHomeDisable = ImageAsset(name: "ic_home_disable")
  internal static let icPause16 = ImageAsset(name: "ic_pause_16")
  internal static let icPause24 = ImageAsset(name: "ic_pause_24")
  internal static let icPlay24 = ImageAsset(name: "ic_play_24")
  internal static let icRefresh16 = ImageAsset(name: "ic_refresh_16")
  internal static let icRefresh24 = ImageAsset(name: "ic_refresh_24")
  internal static let icRefreshGray16 = ImageAsset(name: "ic_refresh_gray_16")
  internal static let icRemove16 = ImageAsset(name: "ic_remove_16")
  internal static let icRemove24 = ImageAsset(name: "ic_remove_24")
  internal static let bodyWeight = ImageAsset(name: "body_weight")
  internal static let genderMan = ImageAsset(name: "gender_man")
  internal static let genderWoman = ImageAsset(name: "gender_woman")
  internal static let icCheck = ImageAsset(name: "ic_check")
  internal static let icWeek1 = ImageAsset(name: "ic_week_1")
  internal static let icWeek10 = ImageAsset(name: "ic_week_10")
  internal static let icWeek2 = ImageAsset(name: "ic_week_2")
  internal static let icWeek3 = ImageAsset(name: "ic_week_3")
  internal static let icWeek4 = ImageAsset(name: "ic_week_4")
  internal static let icWeek5 = ImageAsset(name: "ic_week_5")
  internal static let icWeek6 = ImageAsset(name: "ic_week_6")
  internal static let icWeek7 = ImageAsset(name: "ic_week_7")
  internal static let icWeek8 = ImageAsset(name: "ic_week_8")
  internal static let icWeek9 = ImageAsset(name: "ic_week_9")
  internal static let machineWeight = ImageAsset(name: "machine_weight")
  internal static let trophy = ImageAsset(name: "trophy")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
