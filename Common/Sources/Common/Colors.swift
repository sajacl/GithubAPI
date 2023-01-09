//
//  Colors.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-09.
//

import class UIKit.UIColor

private enum Palette: String {
    case background = "Background"
    case title = "TitleColor"
    case text = "TextColor"
}

public extension UIColor {
    static let background = UIColor(named: Palette.background.rawValue)!
    static let title = UIColor(named: Palette.title.rawValue)!
    static let text = UIColor(named: Palette.text.rawValue)!
}
