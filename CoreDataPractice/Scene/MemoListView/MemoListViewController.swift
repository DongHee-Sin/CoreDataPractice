//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by 신동희 on 2023/03/30.
//

import UIKit

final class MemoListViewController: UIViewController {

    // MARK: - Propertys
    
    @IBOutlet weak var tableView: UITableView!
    
    private let coreDataManager: CoreDataManager = .shared
    
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        self.title = "MEMO"
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }

    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MemoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MemoTableViewCell.identifier)
    }
    
    
    @objc private func plusButtonTapped() {
        guard let detailVC = self.storyboard?.instantiateViewController(identifier: DetailViewController.identifier) else { return }
        present(detailVC, animated: true)
    }
}



extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.memoListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section), \(indexPath.row)")
    }
}
