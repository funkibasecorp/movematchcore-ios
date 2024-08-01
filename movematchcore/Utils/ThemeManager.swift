//
//  ThemeManager.swift
//  spotmatch
//
//  Created by Chris Jones on 6/9/24.
//

import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()

    @Published var theme: Theme = Theme.getTheme(type: .dark)

    @AppStorage("themeType") var themeType: ThemeType = .dark {
        didSet {
            theme = Theme.getTheme(type: themeType)
        }
    }

    private init() {
        theme = Theme.getTheme(type: themeType)
    }

    func getColor(_ colorKeyPath: KeyPath<Theme, Color>) -> Color {
        self.theme[keyPath: colorKeyPath]
    }

    func getGradient(_ gradientKeyPath: KeyPath<Theme, Gradient>) -> Gradient {
        self.theme[keyPath: gradientKeyPath]
    }
}

enum ThemeType: String, Codable {
    case light, dark
}

struct Theme {
    let type: ThemeType
    let backgroundPrimary: Color
    let backgroundSecondary: Color
    let onboardingSheet: Color
    let border: Color
    let darkGray: Color
    let gray1: Color
    let gray2: Color
    let gray3: Color
    let gray4: Color
    let grayBackground: Color
    let grayIcon: Color
    let purple1: Color
    let purple2: Color
    let lightBlue: Color
    let lightRed: Color
    let lightOrange: Color
    let lightYellow: Color
    let chartRed: Color
    let chartTeal: Color
    let textPrimary: Color
    let increase: Color
    let decrease: Color
    let shadow: Color

    let cardGradient: Gradient
    let onboardingGradient: Gradient

    static func getTheme(type: ThemeType) -> Theme {
        var backgroundPrimary: Color {
            type == .dark
            ? Color("#222332")
            : Color("#F8FAFC")
        }
        var backgroundSecondary: Color {
            type == .dark
            ? Color("#2D3450")
            : Color("#FFFFFF")
        }
        var onboardingSheet: Color {
            type == .dark
            ? Color("#222332")
            : Color("#F8FAFC")
        }
        var border: Color {
            type == .dark
            ? Color.clear
            : Color("#CAD0D8")
        }
        var darkGray: Color {
            type == .dark
            ? Color("#FFFFFF")
            : Color("#404B52")
        }
        var gray1: Color {
            type == .dark
            ? Color("#F1F4F8")
            : Color("#404B52")
        }
        var gray2: Color {
            type == .dark
            ? Color("#CAD0D8")
            : Color("#9299A3")
        }
        var gray3: Color {
            type == .dark
            ? Color("#D8D8D8")
            : Color("#D8D8D8")
        }
        var gray4: Color {
            type == .dark
            ? Color("#2D3450")
            : Color("#F1F4F8")
        }
        var grayBackground: Color {
            type == .dark
            ? Color("#D8D8D8")
            : Color("#D8D8D8")
        }
        var grayIcon: Color {
            type == .dark
            ? Color("#CAD0D8")
            : Color("#CAD0D8")
        }
        var purple1: Color {
            type == .dark
            ? Color("#673AB7")
            : Color("#512DA8")
        }
        var purple2: Color {
            type == .dark
            ? Color("#9662F1")
            : Color("#7850BF")
        }
        var lightBlue: Color {
            type == .dark
            ? Color("#EFF7FF")
            : Color("#EFF7FF")
        }
        var lightRed: Color {
            type == .dark
            ? Color("#FFEAEA")
            : Color("#FFEAEA")
        }
        var lightOrange: Color {
            type == .dark
            ? Color("#FFEFDD")
            : Color("#FFEFDD")
        }
        var lightYellow: Color {
            type == .dark
            ? Color("#FBF8EE")
            : Color("#FBF8EE")
        }
        var chartRed: Color {
            type == .dark
            ? Color("#FF3B30")
            : Color("#F5634A")
        }
        var chartTeal: Color {
            type == .dark
            ? Color("#40DBC1")
            : Color("#40DBC1")
        }
        var textPrimary: Color {
            type == .dark
            ? Color.white
            : Color.black
        }
        var increase: Color {
            type == .dark
            ? Color("#40DBC1")
            : Color("#40DBC1")
        }
        var decrease: Color {
            type == .dark
            ? Color("#F5634A")
            : Color("#F5634A")
        }
        var shadow: Color {
            type == .dark
            ? .black.opacity(0.05)
            : .black.opacity(0.05)
        }

        var cardGradient: Gradient {
            type == .dark
            ? Gradient(colors: [.init("#2F2F53"), .init("#2A384D")])
            : Gradient(colors: [.init("#E5E6FC"), .init("#E5F2FC")])
        }
        var onboardingGradient: Gradient {
            type == .dark
            ? Gradient(colors: [.init("#3D3D75"), .init("#324D68")])
            : Gradient(colors: [.init("#BBBAFF"), .init("#BCE3FD")])
        }

        return Theme(
            type: type,
            backgroundPrimary: backgroundPrimary,
            backgroundSecondary: backgroundSecondary,
            onboardingSheet: onboardingSheet,
            border: border,
            darkGray: darkGray,
            gray1: gray1,
            gray2: gray2,
            gray3: gray3,
            gray4: gray4,
            grayBackground: grayBackground,
            grayIcon: grayIcon,
            purple1: purple1,
            purple2: purple2,
            lightBlue: lightBlue,
            lightRed: lightRed,
            lightOrange: lightOrange,
            lightYellow: lightYellow,
            chartRed: chartRed,
            chartTeal: chartTeal,
            textPrimary: textPrimary,
            increase: increase,
            decrease: decrease,
            shadow: shadow,
            cardGradient: cardGradient,
            onboardingGradient: onboardingGradient
        )
    }
}

