//
//  DetailViewController.swift
//  CoreDataPractice
//
//  Created by 신동희 on 2023/04/02.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Propertys
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // MARK: - Methods
    
    @IBAction func colorButtonTapped(sender: UIButton) {
        print(sender.titleLabel?.text ?? "default")
    }
    
}
