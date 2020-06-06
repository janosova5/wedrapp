//
//  ParentViewModel.swift
//  weatherAppJunior
//
//  Created by ljanosova on 10.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import Foundation

final class ParentViewModel {
    
    private var recentSearches = [String]()
    
    init() {
        recentSearches = UserDefaults.standard.array(forKey:
            C.Strings.recentSearchesKey.rawValue) as? [String] ?? [String]()
    }
    
    func addSearch(_ text: String) {
        if recentSearches.contains(text) {
            return
        }
        if recentSearches.count >= 3 {
            recentSearches.remove(at: 0)
            recentSearches.append(text)
        } else {
            recentSearches.append(text)
        }
        UserDefaults.standard.set(recentSearches, forKey: C.Strings.recentSearchesKey.rawValue)
    }
    
    func recentSearchesCount() -> Int {
        return recentSearches.count
    }
    
    func recentSearchesReversed() -> [String] {
        return recentSearches.reversed()
    }
    
}

