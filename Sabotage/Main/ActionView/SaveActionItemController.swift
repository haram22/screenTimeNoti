//
//  SaveActionItemController.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit
// test
// please
class SaveActionItemController : UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let closeButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 15
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            saveButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
//        let deleteButton = UIButton(type: .system)
//        deleteButton.setTitle("삭제하기", for: .normal)
//        deleteButton.setTitleColor(.black, for: .normal)
//        deleteButton.backgroundColor = .systemGray6
//        deleteButton.layer.cornerRadius = 15
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(deleteButton)
        
//        NSLayoutConstraint.activate([
//            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            deleteButton.heightAnchor.constraint(equalToConstant: 70)
//        ])
//        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("이전", for: .normal)
        backButton.setTitleColor(.systemGray, for: .normal)
        backButton.backgroundColor = .systemGray4
        backButton.layer.cornerRadius = 15
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -210),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        let saveActionItemController = MainVC()
        navigationController?.pushViewController(saveActionItemController, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: nil, message: "정말로 삭제하시겠어요?", preferredStyle: .alert)
        
        // 취소 버튼
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        // 삭제 버튼
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            // 삭제 작업 수행
        }))
        
        present(alert, animated: true, completion: nil)
    }

    // "X" 버튼 액션
    @objc func closeButtonTapped() {
        let gotoMainController = MainVC()
        navigationController?.pushViewController(gotoMainController, animated: true)
    }
    
    @objc func backButtonTapped() {
        let gotoBackController = AddActionItemController()
        navigationController?.pushViewController(gotoBackController, animated: true)
    }
}
