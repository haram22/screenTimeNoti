import UIKit

class ActionItemController: UIViewController {
    
    let titleLabel = UILabel()
    let backButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    let aButton = UIButton(type: .system)
    let bButton = UIButton(type: .system)
    let cButton = UIButton(type: .system)
    let dButton = UIButton(type: .system)
    let eButton = UIButton(type: .system)
    
    var selectedRadioButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setConstraint()
        setButtonUI()
        setButtonConstraint()
        setRadioButtonUI()
    }
    
    func setUI() {
        titleLabel.text = "액션 아이템 생성"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        backButton.setTitle("이전", for: .normal)
        backButton.setTitleColor(.systemGray, for: .normal)
        backButton.backgroundColor = .systemGray4
        backButton.layer.cornerRadius = 15
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.systemGray, for: .normal)
        nextButton.backgroundColor = .systemGray4
        nextButton.layer.cornerRadius = 15
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        // MARK: 메인으로 가는 버튼
        let closeButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            
            // MARK: "액션 아이템 생성"
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // MARK: "이전" 버튼
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -210),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.heightAnchor.constraint(equalToConstant: 70),
 
            // MARK: "다음" 버튼
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 210),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func setButtonUI() {
        let buttons = [aButton, bButton, cButton, dButton, eButton]
        let buttonTitles = ["A", "B", "C", "D", "E"]
        
        for (index, button) in buttons.enumerated() {
            button.setTitle(buttonTitles[index], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            button.layer.cornerRadius = 15
            button.backgroundColor = .systemGray3
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    
    func setButtonConstraint() {
       
        let allButtons = [aButton, bButton, cButton, dButton, eButton]
                
        for (index, button) in allButtons.enumerated() {
            var topAnchor: NSLayoutYAxisAnchor
            if index == 0 {
                topAnchor = view.safeAreaLayoutGuide.topAnchor
            } else {
                topAnchor = allButtons[index - 1].bottomAnchor
            }
            
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.topAnchor.constraint(equalTo: topAnchor, constant: index == 0 ? 20 : 40),
                button.widthAnchor.constraint(equalToConstant: 350),
                button.heightAnchor.constraint(equalToConstant: 80)
            ])
        }
    }
    
    func setRadioButtonUI() {
        let buttons = [aButton, bButton, cButton, dButton, eButton]
        for button in buttons {
            let radioButton = UIButton(type: .system)
            radioButton.setImage(UIImage(systemName: "circle"), for: .normal)
            radioButton.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
            radioButton.tintColor = .systemBlue
            radioButton.isUserInteractionEnabled = false
            radioButton.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(radioButton)
            
            NSLayoutConstraint.activate([
                radioButton.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
                radioButton.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                radioButton.widthAnchor.constraint(equalToConstant: 20),
                radioButton.heightAnchor.constraint(equalToConstant: 20)
            ])
            
            button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func radioButtonTapped(_ sender: UIButton) {
        if selectedRadioButton != sender {
            selectedRadioButton?.isSelected = false
            selectedRadioButton = sender
            selectedRadioButton?.isSelected = true
            
            // Update Next button color to systemBlue
            nextButton.backgroundColor = .systemBlue
        }
    }
    
    @objc func nextButtonTapped() {
        if selectedRadioButton != nil {
            let addActionItemController = AddActionItemController()
            navigationController?.pushViewController(addActionItemController, animated: true)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func closeButtonTapped() {
        let gotoMainController = MainVC()
        navigationController?.pushViewController(gotoMainController, animated: true)
    }


    
}
