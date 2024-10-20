//
//  AntiqueMasterTests.swift
//  AntiqueMasterTests
//
//  Created by EricWang on 2024/10/20.
//

import XCTest
@testable import AntiqueMaster  // 確保引入你專案的模組

class AntiqueMasterTests : XCTestCase {

    override func setUpWithError() throws {
        // 在每次測試之前會執行，通常用來做初始化。
    }

    override func tearDownWithError() throws {
        // 在每次測試完成之後會執行，用來清理測試環境。
    }
    
    /// 測試 DebugLogger 類別的 verbose 級別輸出是否正確
    func testVerboseLog() throws {
        // 設定 DebugLogger 的等級為 verbose
        DebugLogger.level = .verbose
        
        // 我們可以在這裡捕捉輸出的訊息（但通常不會這樣做）
        // 這裡我們僅測試日誌等級是否被正確設置
        DebugLogger.verbose("Testing verbose log.")
        
        // 使用 XCTAssert 來驗證
        XCTAssertEqual(DebugLogger.level, .verbose, "日誌等級應該設為 verbose")
    }

    /// 測試 DebugLogger 類別的 error 級別輸出
    func testErrorLog() throws {
        // 設定 DebugLogger 的等級為 error
        DebugLogger.level = .error
        DebugLogger.error("Testing error log.")
        
        // 驗證日誌等級
        XCTAssertEqual(DebugLogger.level, .error, "日誌等級應該設為 error")
    }

}
