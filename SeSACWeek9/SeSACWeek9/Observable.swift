//
//  Observable.swift
//  SeSACWeek9
//
//  Created by 이중원 on 2022/08/31.
//

import Foundation

class Observable<T> { //양방향 바인딩
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
    
}


