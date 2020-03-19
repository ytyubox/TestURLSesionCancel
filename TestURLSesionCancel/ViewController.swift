//
//  ViewController.swift
//  TestURLSesionCancel
//
//  Created by 游宗諭 on 2020/3/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var TextView: UITextView!
	var task: URLSessionTask!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	@IBAction func didTapFetch(_ sender: UIButton) {
		task = fetch(nbr: textField.text ?? "") { (d, u, e) in
			if let d = d {
				let str = String(data: d, encoding: .utf8)!
				DispatchQueue.main.async {
					
					self.TextView.text += str + "\n"
					
				}
			}
			if let e = e {
				let nse = e as NSError
				if (nse.code == NSURLErrorCancelled) {
					print("cancelled")
					DispatchQueue.main.async {
						self.TextView.text += "asking \(self.textField.text!) is cancelled\n"
					}
					return
					
				}
				DispatchQueue.main.async {
					
					self.TextView.text += "\(e)" + "\n"
					
				}
			}
		}
		task.resume()
	}
	
	@IBAction func didTapCancel(_ sender: UIButton) {
		task.cancel()
	}
}

typealias Then = (Data?,URLResponse?,Error?)->Void
func fetch(nbr:String, then:@escaping Then) -> URLSessionTask {
	let url = URL(string: "http://numbersapi.com/\(nbr)/year")!
	return URLSession.shared.dataTask(with: url,completionHandler: then)
}
