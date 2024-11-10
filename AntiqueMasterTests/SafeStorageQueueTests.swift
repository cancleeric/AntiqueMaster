import Testing

@testable import AntiqueMaster

final class SafeStorageQueueTests {

    @Test
    func testAddAndGetAll() {
        let queue = SafeStorageQueue<Int>(label: "test.queue")
        queue.add(contentsOf: [1, 2, 3])

        #expect(queue.getAll() == [1, 2, 3], "應返回 [1, 2, 3]")
        #expect(queue.getAll() == [1, 2, 3], "再次讀取時應返回相同的 [1, 2, 3]，不移除元素")
    }

    @Test
    func testClear() {
        let queue = SafeStorageQueue<Int>(label: "test.queue")
        queue.add(contentsOf: [1, 2, 3])
        queue.clear()

        #expect(queue.getAll().isEmpty, "清除後應返回空列表")
    }

    @Test
    func testConcurrentAccess() async {
        let queue = SafeStorageQueue<Int>(label: "test.queue")

        // 使用 Swift Testing 框架的內建機制處理異步操作
        await withTaskGroup(of: Void.self) { group in
            for i in 0..<1000 {
                group.addTask {
                    queue.add(contentsOf: [i])
                }
            }
        }

        let results = queue.getAll()
        #expect(results.count == 1000, "應有 1000 個元素")
    }
}
