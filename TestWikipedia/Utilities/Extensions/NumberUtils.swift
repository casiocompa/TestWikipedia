//
//  NumberUtils.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 30.10.2023.
//

import Foundation


extension Double {
    
    func toString() -> String? {
        if self == 0 {
            return nil
        }else{
            return NSString(format: "%f" as NSString, self) as String
        }
        
    }
}

extension Optional where Wrapped == Double {
    
    var isNilOrEmpty: Bool {
        self == nil || self == 0
    }
    
    var isNilOrEmptyValue: Double? {
        if self == nil || self == 0 {
            return nil
        }else{
            return self
        }
    }
}
