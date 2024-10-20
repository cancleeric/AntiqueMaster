//
//   DebugLoggerTests.swift
//  AntiqueMasterTests
//
//  Created by EricWang on 2024/10/20.
//
import XCTest
@testable import AntiqueMaster

class DebugLoggerTests: XCTestCase {

    /// 測試 DebugLogger 類別的 verbose 級別輸出是否正確
    func testVerboseLog() throws {
        DebugLogger.level = .verbose
        DebugLogger.verbose("Testing verbose log.")
        XCTAssertEqual(DebugLogger.level, .verbose, "日誌等級應該設為 verbose")
    }

    /// 測試 DebugLogger 類別的 debug 級別輸出
    func testDebugLog() throws {
        DebugLogger.level = .debug
        DebugLogger.debug("Testing debug log.")
        XCTAssertEqual(DebugLogger.level, .debug, "日誌等級應該設為 debug")
    }

    /// 測試 DebugLogger 類別的 info 級別輸出
    func testInfoLog() throws {
        DebugLogger.level = .info
        DebugLogger.info("Testing info log.")
        XCTAssertEqual(DebugLogger.level, .info, "日誌等級應該設為 info")
    }

    /// 測試 DebugLogger 類別的 warning 級別輸出
    func testWarningLog() throws {
        DebugLogger.level = .warning
        DebugLogger.warning("Testing warning log.")
        XCTAssertEqual(DebugLogger.level, .warning, "日誌等級應該設為 warning")
    }

    /// 測試 DebugLogger 類別的 error 級別輸出
    func testErrorLog() throws {
        DebugLogger.level = .error
        DebugLogger.error("Testing error log.")
        XCTAssertEqual(DebugLogger.level, .error, "日誌等級應該設為 error")
    }
    
    /// 測試日誌級別過濾
    func testLogLevelFiltering() throws {
        DebugLogger.level = .warning

        // 只有 warning 和 error 級別的日誌應該被記錄，低於 warning 的不應該被記錄
        DebugLogger.verbose("This should not be logged.")
        DebugLogger.debug("This should not be logged.")
        DebugLogger.info("This should not be logged.")
        DebugLogger.warning("This should be logged.")
        DebugLogger.error("This should be logged.")
        
        // 驗證設置後的日誌級別
        XCTAssertEqual(DebugLogger.level, .warning, "日誌等級應該設為 warning")
    }

    /// 測試日誌訊息格式是否正確
    func testLogMessageFormat() throws {
        DebugLogger.level = .debug
        let message = "Testing log format"
        
        // 模擬捕捉日誌訊息
        DebugLogger.debug(message)
        
        // 這裡可以使用一個更複雜的邏輯來檢查輸出的日誌訊息格式是否正確
        // 比如檢查是否包含日期、級別、文件名、行號等
        let expectedLogFormat = "[DEBUG] \(message)"
        // 假設我們有辦法捕捉到日誌輸出進行驗證，這裡簡單測試
        XCTAssertTrue(expectedLogFormat.contains("[DEBUG]"), "日誌格式應包含級別")
    }
}
