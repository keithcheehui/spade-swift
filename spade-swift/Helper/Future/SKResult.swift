//
//  SKResult.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(String)
}
