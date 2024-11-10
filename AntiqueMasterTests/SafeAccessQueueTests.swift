import Testing

@testable import AntiqueMaster

final class SafeAccessQueueTests {

    @Test
    func testAddAndGet() {
        let queue = SafeAccessQueue<Int>(label: "test.queue")
        queue.add(1)
        queue.add(2)
        queue.add(3)

        #expect(queue.get() == 1, "應該返回 1")
        #expect(queue.get() == 2, "應該返回 2")
        #expect(queue.get() == 3, "應該返回 3")
        #expect(queue.get() == nil, "應該返回 nil")
    }

    @Test
    func testAddContentsOfAndGetAll() {
        let queue = SafeAccessQueue<Int>(label: "test.queue")
        queue.add(contentsOf: [1, 2, 3])

        #expect(queue.getAll() == [1, 2, 3], "應返回 [1, 2, 3]")
        #expect(queue.getAll() == [], "應返回空列表")
    }

    @Test
      func testConcurrentAccess() async {
          let queue = SafeAccessQueue<Int>(label: "test.queue")

          // 使用 async 讓代碼並發執行，避免使用期望和傳統的異步處理
          await withTaskGroup(of: Void.self) { group in
              for i in 0..<1000 {
                  group.addTask {
                      queue.add(i)
                  }
              }
          }

          var results: [Int] = []
          while let value = queue.get() {
              results.append(value)
          }

          #expect(results.count == 1000, "應有 1000 個元素")
      }
}
