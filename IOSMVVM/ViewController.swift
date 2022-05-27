//
//  ViewController.swift
//  IOSMVVM
//
//  Created by Robert_Tseng on 2022/5/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var name: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let names = ["Swift", "iOS App", "Android App"]
        // Array to JSON
        if let jsonData = try? JSONEncoder().encode(names) {
            // 將JSON資料轉成字串方便顯示
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
//                轉換成字串
                print("Array to Json: \(jsonStr)")
            }
            // JSON to Array
            if let result = try? JSONDecoder().decode([String].self, from: jsonData) {
//                轉回陣列 result.description
                print("Json to Array: \(result)")
            }
        }
        
        self.dictionToJson()
        self.objectToJson()
    }

    @IBAction func submit(_ sender: Any) {
        let viewModel = ViewModel()
        viewModel.userInput(name: inputName.text ?? "") {
            user in
            self.name.text = user.name
        }
    }
    
    func dictionToJson() {
        var dictionary = [String: Any]()
        dictionary["action"] = "insert"
        dictionary["name"] = "iOS App"
        dictionary["num"] = 123
        // Dictionary to JSON
        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary) {
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
//                轉換成字串
                print("JSON to String: \(jsonStr)")
            }
            // JSON to Dictionary
            if let result = try? JSONSerialization.jsonObject(with: jsonData) {
//                轉回物件 result.description
                print("JSON to Dictionary: \(result)")
                if let data = result as? [String: Any] {
                    print("\(data["num"] ?? 0)")
                }
            }
        }
    }
    
    func objectToJson() {
        let instruction = Instruction(title: "Test", text: "gogo")
        let book1 = Book(name: "Swift", price: 100, author: "Ami", publishDate: Date(), instruction: instruction )
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // Object to JSON
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(format)
//        JSON含有日期時間，encode必須指定日期時間格式
        if let jsonData = try? encoder.encode(book1) {
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
//                轉換成字串
                print("JSON to String: \(jsonStr)")
            }
            // JSON to Object
            let decoder = JSONDecoder()
            // JSON含有日期時間，decode必須指定日期時間格式
            decoder.dateDecodingStrategy = .formatted(format)
            if let result = try? decoder.decode(Book.self, from: jsonData) {
//            轉換成物件
                print("JSON to Object get price: \(result.price ?? 0)")
            }
        }

    }
}

struct Instruction: Codable {
    var title: String
    var text: String
}

// JSON 自訂物件
class Book: Codable {
    var name: String?
    var price: Double?
    var author: String?
    var publishDate: Date?
    var instruction: Instruction?

    public init(name: String, price: Double, author: String, publishDate: Date, instruction: Instruction) {
        self.name = name
        self.price = price
        self.author = author
        self.publishDate = publishDate
        self.instruction = instruction
    }
}


