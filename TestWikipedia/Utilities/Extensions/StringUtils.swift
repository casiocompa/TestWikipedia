//
//  StringUtils.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 30.10.2023.
//

import Foundation


protocol FullStringMakerProtocol {
    
    var fullnameStr: String? {
        get
    }
    
}

extension FullStringMakerProtocol {
    
    var fullnameStr: String? {
        return nil
    }
    
}

extension String {
    
    func stringMakerWithSeparator(texts: [String?]? = nil , separator: String = ", ") -> String? {
        guard let texts = texts else {
            return nil
        }
        
        var result = ""
        
        for (index, value) in texts.enumerated() {
            if index == 0 {
                if let value = value?.isEmptyOrValue {
                    result += "\(value) "
                }
            }else {
                if let value = value?.isEmptyOrValue {
                    result = result.trimmingCharacters(in: .whitespacesAndNewlines)
                    result += "\(separator)"
                    result += "\(value) "
                }
            }
        }
        
        result = result.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
    
}

extension String {
   
    var isEmptyOrValue: String? {
        if self == "" {
            return nil
        }else{
            return self
        }
    }
    
    var isNilOrEmpty: Bool {
        self == ""
    }
    
}

extension String {
    
    var toDouble: Double? {
        let separator = "."
        var string = self
        if "," == separator {
            string = string.replacingOccurrences(of: ".", with: separator)
        }else{
            string = string.replacingOccurrences(of: ",", with: separator)
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = separator
        return formatter.number(from: string.replacingOccurrences(of: " ", with: ""))?.doubleValue
    }
    
}
