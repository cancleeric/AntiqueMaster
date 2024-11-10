//
//  SafeAccessQueue.swift
//  LifeSnap
//
//  Created by EricWang on 2024/1/6.
//

import Foundation

/// `SafeAccessQueue` 類別提供一個線程安全的佇列，用於安全地存取元素。
/// - 使用 `DispatchQueue` 來確保線程安全。
/// - 支援單個元素和陣列的添加操作。
/// - 提供獲取並移除第一個元素的方法。
class SafeAccessQueue<Element> {
    private var elements: [Element] = []
    private let queue: DispatchQueue

    /// 初始化方法，設置佇列的標籤。
    /// - Parameter label: 佇列的標籤，用於識別佇列。
    init(label: String) {
        queue = DispatchQueue(label: label, attributes: .concurrent)
    }

    /// 添加單個元素到佇列中。
    /// - Parameter element: 要添加的元素。
    func add(_ element: Element) {
        queue.sync(flags: .barrier) {
            elements.append(element)
        }
    }

    /// 添加一個陣列的元素到佇列中。
    /// - Parameter array: 要添加的元素陣列。
    func add(contentsOf array: [Element]) {
        queue.sync(flags: .barrier) {
            elements.append(contentsOf: array)
        }
    }

    /// 獲取並移除佇列中的第一個元素。
    /// - Returns: 佇列中的第一個元素，如果佇列為空則返回 nil。
    func get() -> Element? {
        return queue.sync {
            if !elements.isEmpty {
                return elements.removeFirst()
            }
            return nil
        }
    }
}
