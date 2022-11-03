//
//  SubscriptExample.swift
//  SeSacNetwork2
//
//  Created by 유연탁 on 2022/11/03.
//

import Foundation

extension String {
    
    subscript(idx: Int) -> String? {
        
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        
        return String(self[result])
    }
}
