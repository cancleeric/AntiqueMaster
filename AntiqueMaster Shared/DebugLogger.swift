//
//  DebugLogger.swift
//  AntiqueMaster
//
//  Created by EricWang on 2023/6/6.
//  更新日期: 2024/10/20
//  修改說明:
//  1. 移除了不必要的註解，保持程式碼整潔。
//  2. 添加了繁體中文的文件說明註解，方便 Xcode Swift 開發文件的生成。
//  3. 保持程式碼邏輯不變，確保日誌功能正常運行，並根據不同日誌級別輸出相應的訊息。
//  4. 整理了日誌輸出格式，確保日誌包含時間戳、檔案名稱、行號及函數名稱。

import Foundation

/// `PrintDate` 類別負責生成當前日期和時間的字串，格式為 yyyy-MM-dd HH:mm:ss。
class PrintDate {
    let dateString: String

    /// 初始化方法，使用 DateFormatter 格式化當前日期與時間為字串。
    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateString = formatter.string(from: Date())
    }
}

/// `DebugLogger` 類別用於記錄各種日誌級別的訊息。根據指定的日誌等級，決定是否打印訊息。
/// 支援的日誌級別包括：verbose、debug、info、warning、error。
class DebugLogger {

    /// 定義日誌的不同級別，數值越大級別越高。
    enum Level: Int {
        case verbose = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
    }

    /// 預設的日誌等級，設為 verbose。
    static var level: Level = .verbose

    /// 打印 verbose 級別的日誌。
    /// - Parameters:
    ///   - message: 需要記錄的訊息。
    ///   - file: 自動捕捉的檔案名稱。
    ///   - line: 自動捕捉的行號。
    ///   - function: 自動捕捉的函數名稱。
    static func verbose(
        _ message: String, file: String = #file, line: Int = #line, function: String = #function
    ) {
        log(message, level: .verbose, file: file, line: line, function: function)
    }

    /// 打印 debug 級別的日誌。
    /// - Parameters:
    ///   - message: 需要記錄的訊息。
    ///   - file: 自動捕捉的檔案名稱。
    ///   - line: 自動捕捉的行號。
    ///   - function: 自動捕捉的函數名稱。
    static func debug(
        _ message: String, file: String = #file, line: Int = #line, function: String = #function
    ) {
        log(message, level: .debug, file: file, line: line, function: function)
    }

    /// 打印 info 級別的日誌。
    /// - Parameters:
    ///   - message: 需要記錄的訊息。
    ///   - file: 自動捕捉的檔案名稱。
    ///   - line: 自動捕捉的行號。
    ///   - function: 自動捕捉的函數名稱。
    static func info(
        _ message: String, file: String = #file, line: Int = #line, function: String = #function
    ) {
        log(message, level: .info, file: file, line: line, function: function)
    }

    /// 打印 warning 級別的日誌。
    /// - Parameters:
    ///   - message: 需要記錄的訊息。
    ///   - file: 自動捕捉的檔案名稱。
    ///   - line: 自動捕捉的行號。
    ///   - function: 自動捕捉的函數名稱。
    static func warning(
        _ message: String, file: String = #file, line: Int = #line, function: String = #function
    ) {
        log(message, level: .warning, file: file, line: line, function: function)
    }

    /// 打印 error 級別的日誌。
    /// - Parameters:
    ///   - message: 需要記錄的訊息。
    ///   - file: 自動捕捉的檔案名稱。
    ///   - line: 自動捕捉的行號。
    ///   - function: 自動捕捉的函數名稱。
    static func error(
        _ message: String, file: String = #file, line: Int = #line, function: String = #function
    ) {
        log(message, level: .error, file: file, line: line, function: function)
    }

    /// 實際的日誌打印方法。根據日誌的等級決定是否輸出日誌。
    /// - Parameters:
    ///   - message: 需要記錄的訊息。
    ///   - level: 日誌的等級。
    ///   - file: 產生日誌的檔案名稱。
    ///   - line: 產生日誌的行號。
    ///   - function: 產生日誌的函數名稱。
    private static func log(
        _ message: String, level: Level, file: String, line: Int, function: String
    ) {
        if level.rawValue >= self.level.rawValue {
            print(
                "\(PrintDate().dateString) [\(level)] [\((file as NSString).lastPathComponent):\(line)] \(function) - \(message)"
            )
        }
    }
}
