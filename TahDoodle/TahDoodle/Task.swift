//
//  Task.swift
//  TahDoodle
//
//  Created by Eden on 2022/10/29.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    let title: String
    
    init(title: String) {
        id = UUID()
        self.title = title
    }
}

extension Task: Equatable, Codable { }
