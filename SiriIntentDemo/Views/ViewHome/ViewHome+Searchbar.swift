//
//  ViewHome+Searchbar.swift
//  AppLock
//
//  Created by Tung Anh on 04/03/2024.
//

import Foundation
import UIKit

extension lockscreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    {
        if searchText.count == 0 {
            filteredArray = arr // Nếu searchText rỗng, hiển thị danh sách ban đầu
        } else {
            // Chuyển đổi LazyFilterSequence thành Results<Item>
            filteredArray = arr!.where {
                $0.name.contains(searchText, options: .caseInsensitive)
            }
        }
        tbview.reloadData()
    }
}
