//
//  SaveActionItemController.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit
import SnapKit


protocol ActionItemDelegate: AnyObject {
    func didAddActionItemText(_ text: String)
    // Add any other methods needed to pass data back to MainVC
}


class AddActionItemController: UIViewController, UITextFieldDelegate {
    var textField: UITextField = UITextField()
    var selectedButtonName: String? // 선택된 버튼의 이름을 저장하는 변수

    weak var delegate: ActionItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // MARK: -  ActionItemController에서 잘 넘어왔느닞 확인하는 코드
        if let selectedButton = selectedButtonName {
            print("😎 ActionItemController로부터 받은 선택된 버튼 이름: \(selectedButton)")
        }
        
        // "X" 버튼 추가
        let closeButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        // "명상" 텍스트를 보여줄 레이블 생성
        let meditationLabel = UILabel()
        meditationLabel.text = "명상"
        meditationLabel.textAlignment = .center
        meditationLabel.font = UIFont.boldSystemFont(ofSize: 24)
        meditationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(meditationLabel)
        
        // Auto Layout을 사용하여 레이블을 페이지 중앙에 위치시킴
        NSLayoutConstraint.activate([
            meditationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            meditationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        // "알겠습니다" 텍스트를 보여줄 레이블 생성
        let understandLabel = UILabel()
        understandLabel.text = "해당 카테고리를 실행하기 위해"
        understandLabel.textAlignment = .center
        understandLabel.font = UIFont.systemFont(ofSize: 18)
        understandLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이블을 뷰에 추가
        view.addSubview(understandLabel)
        
        // Auto Layout을 사용하여 레이블을 "명상" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            understandLabel.topAnchor.constraint(equalTo: meditationLabel.bottomAnchor, constant: 20),
            understandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
        
        // 사용자가 입력할 수 있는 텍스트 필드 생성
        let textField = UITextField()
        textField.placeholder = "여기에 입력하세요"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        textField.delegate = self
        
        // 텍스트 필드를 뷰에 추가
        view.addSubview(textField)
        
        // 여기가 중요
        textField.delegate = self
        
        // Auto Layout을 사용하여 텍스트 필드를 "알겠습니다" 텍스트 아래에 위치시킴
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: understandLabel.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 250)
        ])
        
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
        
        let completeButton = UIButton(type: .system)
        completeButton.setTitle("완료", for: .normal)
        completeButton.setTitleColor(.black, for: .normal)
        completeButton.backgroundColor = .systemBlue
        completeButton.layer.cornerRadius = 15
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(completeButton)
        
        NSLayoutConstraint.activate([
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 210),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            completeButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        // 다른 화면을 탭할 때
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(sender:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // UITextFieldDelegate 메서드 구현, textfield에 작성한 내용 콘솔로 가져오기.
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            self.textField.text = text
            print("사용자가 입력한 텍스트: \(text)")
        }
    }
    
    // Delegate를 통해 MainVC로 텍스트 이동되었는지 콘솔에서 확인
    @objc func completeButtonTapped() {

//        actionPostRequest(category: <#T##String#>, content: <#T##String#>)
//         let saveActionItemController = SaveActionItemController()
//         navigationController?.pushViewController(saveActionItemController, animated: true)

        guard let text = self.textField.text else {
            print("입력된 텍스트가 비어 있습니다.")
            return
        }
        
        print("⚽️ MainVC로 전달된 텍스트: \(text)") // 사용자가 작성한 목표 출력
        
        if let selectedButton = selectedButtonName {
            delegate?.didAddActionItemText(text) // Pass the text to MainVC
            print("🎾 사용자가 선택한 버튼 이름: \(selectedButton)") // 사용자가 선택한 버튼의 이름 출력
        }

        if let navController = navigationController {
            navController.popToRootViewController(animated: true) // 모든 뷰 컨트롤러를 제거하고 MainVC로 이동
        }
    }




    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // "X" 버튼 액션
    @objc func closeButtonTapped() {
        let gotoMainController = MainVC()
        navigationController?.pushViewController(gotoMainController, animated: true)
    }
//     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//             textField.resignFirstResponder() // 키보드 숨기기
//             return true
//         }
//}
    
    // 다른 곳을 탭했을 때 키보드 숨기기
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
