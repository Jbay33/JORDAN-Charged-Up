//
//  MatchCompressed.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/24/23.
//

import Foundation

class MatchCompressed: Hashable, Identifiable {
    static func == (lhs: MatchCompressed, rhs: MatchCompressed) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(a)
        hasher.combine(b)
    }
    
    let id = UUID()
    
    var a: Int
    var b: Int
    
    init(val: (Int, Int) ) {
        a = val.0
        b = val.1
    }
}
