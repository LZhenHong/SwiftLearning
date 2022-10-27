//
//  Vault.swift
//  CyclicalAssets
//
//  Created by LZhenHong on 2022/10/27.
//

import Foundation

class Vault {
    let number: Int
    
    private(set) var assets: [Asset] = []
    
    init(number: Int) {
        self.number = number
    }
    
    deinit {
        print("\(self) is being deallocated.")
    }
    
    func store(_ asset: Asset) {
        asset.container = self
        assets.append(asset)
    }
}

extension Vault: CustomStringConvertible {
    var description: String {
        return "Vault(\(number))"
    }
}
