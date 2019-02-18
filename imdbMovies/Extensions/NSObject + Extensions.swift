
//
//  NSObject + Extension.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/18/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
