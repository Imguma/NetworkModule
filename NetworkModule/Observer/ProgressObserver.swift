//
//  ProgressObserver.swift
//  NetworkModule
//
//  Created by 애니모비 on 2023/07/13.
//

import Foundation
import Combine

public class ProgressObserver: ObservableObject {
    static let shared = ProgressObserver()

    @Published var isActive: Bool = false
    @Published var progress: Double = 0
    
    private init() { }
    
    deinit {
        print("Progress Observer deinit")
    }
}
