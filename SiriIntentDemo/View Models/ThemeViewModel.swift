//
//  ThemeViewModel.swift
//  AppLock
//
//  Created by Tung Anh on 06/10/2023.  
//

import Foundation

class ThemeViewModel {
    func numberOfThemes() -> Int {
        return 9
    }

    func themeName(at index: Int) -> String {
        return "lock_screen\(index)"
    }

    func isThemeSelected(at index: Int) -> Bool {
        let selectedTheme = RealmManager.shared.getThemeItem().first?.themename ?? ""
        return themeName(at: index) == selectedTheme
    }

    func getselectedTheme() -> String {
        return RealmManager.shared.getThemeItem().first?.themename ?? ""
    }

    func selectTheme(at index: Int) {
        let themesave = RealmManager.shared.getThemeItem()
        if themesave.count == 0 {
            let themeItem = ThemeItem()
            themeItem.themename = "lock_screen\(index)"
            RealmManager.shared.addThemeItem(themeItem)

        } else {
            let theme = themesave.first
            if index == 0 {
                RealmManager.shared.deleteThemeItem(theme!)
            } else {
                RealmManager.shared.updateThemeItem(theme!, value: "lock_screen\(index)")
            }
        }
    }
}
