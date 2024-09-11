//
//  csvReader.swift
//  AlarmClock
//
//  Created by 羽田野真央 on 2024/07/05.
//

import Foundation

struct CSVReader {
    static func readCSV(fileName: String) -> [String] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            return []
        }
        
        do {
            let csvData = try String(contentsOfFile: path, encoding: .utf8)
            let csvRows = csvData.components(separatedBy: .newlines)
            return csvRows.filter { !$0.isEmpty }
        } catch {
            print("Error reading CSV file: \(error)")
            return []
        }
    }
}
