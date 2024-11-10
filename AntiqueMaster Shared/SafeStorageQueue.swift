//
//  SafeStorageQueue.swift
//  LifeSnap
//
//  Created by EricWang on 2024/1/6.
//

import Foundation

/// `SafeStorageQueue` 類別提供一個線程安全的佇列，用於安全地存取元素。
/// - 使用 `DispatchQueue` 來確保線程安全。
/// - 支援單個���素和陣列的添加操作。
/// - 提供讀取所有元素的方法，讀取時不會移除元素。
class SafeStorageQueue<Element> {
    private var elements: [Element] = []
    private let queue: DispatchQueue

    /// 初始化方法，設置佇列的標籤。
    /// - Parameter label: 佇列的標籤，用於識別佇列。
    init(label: String) {
        queue = DispatchQueue(label: label, attributes: .concurrent)
    }

    /// 添加一個陣列的元素到佇列中。
    /// - Parameter array: 要添加的元素陣列。
    func add(contentsOf array: [Element]) {
        queue.sync(flags: .barrier) {
            elements.append(contentsOf: array)
        }
    }

    /// 讀取佇列中的所有元素。
    /// - Returns: 佇列中的所有元素。
    func getAll() -> [Element] {
        return queue.sync {
            return elements
        }
    }

    /// 清空佇列中的所有元素。
    func clear() {
        queue.sync(flags: .barrier) {
            elements.removeAll()
        }
    }
}
