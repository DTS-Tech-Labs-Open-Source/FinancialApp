//
//  Array+RemoveDuplicates.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/8/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

extension Array where Element: Hashable{
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    func difference(from other: [Element]) -> [Element] {
           let thisSet = Set(self)
           let otherSet = Set(other)
           return Array(thisSet.symmetricDifference(otherSet))
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
    
    
    func removingDuplicates<T: Hashable>(byKey key: KeyPath<Element, T>)  -> [Element] {
        var result = [Element]()
        var seen = Set<T>()
        for value in self {
            if seen.insert(value[keyPath: key]).inserted {
                result.append(value)
            }
        }
        return result
    }
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}


extension Array where Element: Equatable{
    mutating func remove (element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
}
