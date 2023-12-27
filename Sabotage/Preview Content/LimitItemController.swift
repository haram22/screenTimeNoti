// LimitItemController.swift

import UIKit

class LimitItemController: UIViewController {
    
    let dailyBudgetButton = UIButton()
    let countDownLabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "시간 제한 그룹 생성"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        let inputName = UITextField()
        inputName.placeholder = "Name"
        inputName.textColor = .black
        inputName.font = UIFont.systemFont(ofSize: 24)
        inputName.layer.cornerRadius = 15
        inputName.backgroundColor = .systemGray3
        view.addSubview(inputName)
        inputName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputName.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            inputName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            inputName.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let appButton = UITextField() // Change UIButton to UITextField
        appButton.placeholder = "App" // Set placeholder text
        appButton.textColor = .black
        appButton.font = UIFont.systemFont(ofSize: 24)
        appButton.layer.cornerRadius = 15
        appButton.backgroundColor = .systemGray3
        view.addSubview(appButton)
        appButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appButton.topAnchor.constraint(equalTo: inputName.bottomAnchor, constant: 50),
            appButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            appButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            appButton.heightAnchor.constraint(equalToConstant: 60)
        ])
                
        dailyBudgetButton.setTitle("Daily Budget", for: .normal)
        dailyBudgetButton.setTitleColor(.black, for: .normal)
        dailyBudgetButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        dailyBudgetButton.layer.cornerRadius = 15
        dailyBudgetButton.backgroundColor = .systemGray3
        view.addSubview(dailyBudgetButton)
        dailyBudgetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dailyBudgetButton.topAnchor.constraint(equalTo: appButton.bottomAnchor, constant: 50),
            dailyBudgetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dailyBudgetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dailyBudgetButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        dailyBudgetButton.addTarget(self, action: #selector(startCountdownTimer), for: .touchUpInside)
    }
    
    @objc func startCountdownTimer() {
       let countDownLabel = UILabel()
       countDownLabel.text = "Timer"
       countDownLabel.textAlignment = .center
       countDownLabel.font = UIFont.systemFont(ofSize: 24)
       countDownLabel.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(countDownLabel)

       NSLayoutConstraint.activate([
           countDownLabel.topAnchor.constraint(equalTo: dailyBudgetButton.bottomAnchor, constant: 50),
           countDownLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
           countDownLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
           countDownLabel.heightAnchor.constraint(equalToConstant: 60)
       ])

        var countdownValue = 60
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            countdownValue -= 1
            if countdownValue >= 0 {
                self.countDownLabel.text = "\(countdownValue)"
            } else {
                timer.invalidate()
                self.countDownLabel.text = "시간 초과!"
            }
        }
       }
}
