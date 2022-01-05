//
//  UIFontExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2021/1/29.
//  Copyright © 2021 Addcn. All rights reserved.
//
import UIKit
import Foundation

extension UIFont {
  static func pingFangTC(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
    var name = "PingFangTC"
    switch weight {
    case .ultraLight:
      name += "-UltraLight"
    case .thin:
      name += "-Thin"
    case .light:
      name += "-Light"
    case .medium:
      name += "-Medium"
    case .semibold:
      name += "-Semibold"
    default:
      name += "-Regular"
    }
    return UIFont(name: name, size: size) ?? .systemFont(ofSize: size, weight: weight)
  }
}
