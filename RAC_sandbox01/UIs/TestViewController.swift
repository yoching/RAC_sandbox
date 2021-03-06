//
//  TestViewController.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/17.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import APIKit

class TestViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        sendRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // private
    
    private func initView() {
        let printIt: (String) -> () = {
            next in print("next: \(next)")
        }
        
        testSignal().observeValues(printIt)
    }
    
    private func testSignal() -> Signal<String, NoError> {
        return Signal { observer in
            DispatchQueue.main.async {
                var i = 0
                while i < 10 {
                    observer.send(value: String(i))
                    i += 1
                }
            }
            // observer.sendCompleted() // イベントストリーム終了
            return nil
        }
    }
    
    // Sending request
    
    private func sendRequest() {
        let request = GetBooksRequest(keyword: "java")
        Session.send(request) { result in
            switch result {
            case .success(let books):
                print("booksData: \(books.list[1].title)")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
}
