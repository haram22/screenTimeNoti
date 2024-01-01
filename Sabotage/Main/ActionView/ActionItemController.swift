import UIKit
import SnapKit
import Then



class ActionItemController: UIViewController, ActionItemDelegate {
    
    weak var delegate: ActionItemDelegate?
    
    let titleLabel = UILabel()
    let backButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    let aButton = UIButton(type: .system)
    let bButton = UIButton(type: .system)
    let cButton = UIButton(type: .system)
    let dButton = UIButton(type: .system)
    let eButton = UIButton(type: .system)
    let fButton = UIButton(type: .system)
    
    var actionItemData: ActionItemData?
    
    var selectedRadioButton: UIButton?
    var selectedButtonName: String? // 선택된 버튼의 이름을 저장하는 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setConstraints()
        setButtonUI()
        setButtonConstraints()
        setRadioButtonUI()
    }
    
    func setupUI() {
        view.addSubview(titleLabel.then {
            $0.text = "액션 아이템 생성"
            $0.textAlignment = .center
        }.then {
            $0.font = UIFont.LargeTitle() // LargeTitle 폰트를 titleLabel에 적용
        })
        
        view.addSubview(backButton.then {
            $0.setTitle("이전", for: .normal)
            $0.setTitleColor(.systemGray, for: .normal)
            $0.backgroundColor = .systemGray4
            $0.layer.cornerRadius = 15
            $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        })
        
        view.addSubview(nextButton.then {
            $0.setTitle("다음", for: .normal)
            $0.setTitleColor(.systemGray, for: .normal)
            $0.backgroundColor = .systemGray4
            $0.layer.cornerRadius = 15
            $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        })
        
        let closeButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-210)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(70)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(210)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(70)
        }
    }
    
    func setButtonUI() {
        let buttons = [aButton, bButton, cButton, dButton, eButton, fButton]
        let buttonTitles = ["운동", "셀프케어", "생활", "생산성", "성장", "숙면"]
        
        for (index, button) in buttons.enumerated() {
            view.addSubview(button.then {
                $0.setTitle(buttonTitles[index], for: .normal)
                $0.setTitleColor(.black, for: .normal)
                $0.titleLabel?.font = UIFont.LargeTitle()
                $0.layer.cornerRadius = 15
                $0.backgroundColor = .systemGray3
            })
        }
    }
    
    func setButtonConstraints() {
        let allButtons = [aButton, bButton, cButton, dButton, eButton, fButton]
        
        for (index, button) in allButtons.enumerated() {
            var topAnchor: ConstraintItem
            if index == 0 {
                topAnchor = view.safeAreaLayoutGuide.snp.top
            } else {
                topAnchor = allButtons[index - 1].snp.bottom
            }
            
            button.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(topAnchor).offset(index == 0 ? 20 : 40)
                $0.width.equalTo(350)
                $0.height.equalTo(80)
            }
        }
    }
    
    func setRadioButtonUI() {
        let buttons = [aButton, bButton, cButton, dButton, eButton, fButton]
        for button in buttons {
            let radioButton = UIButton(type: .system).then {
                $0.setImage(UIImage(named: "radioButtonUnchecked"), for: .normal) // 변경된 이미지 이름으로 수정
                $0.setImage(UIImage(named: "radioButtonChecked"), for: .selected) // 선택됐을 때 이미지 이름으로 수정
//                $0.tintColor = .systemBlue
                $0.isUserInteractionEnabled = false
            }
            button.addSubview(radioButton)
            
            radioButton.snp.makeConstraints {
                $0.trailing.equalTo(button.snp.trailing).offset(-10)
                $0.centerY.equalTo(button.snp.centerY)
                $0.width.height.equalTo(40)
            }
            
            button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        }
    }

    
    @objc func radioButtonTapped(_ sender: UIButton) {
        if selectedRadioButton != sender {
            selectedRadioButton?.isSelected = false
            selectedRadioButton = sender
            selectedRadioButton?.isSelected = true
            
            if let radioButton = sender.subviews.compactMap({ $0 as? UIImageView }).first {
                if sender.isSelected {
                    radioButton.image = UIImage(named: "radioButtonChecked")
                } else {
                    radioButton.image = UIImage(named: "radioButton")
                }
            }
            
            // Update Next button color to systemBlue
            nextButton.backgroundColor = .systemBlue
        }
    }

    
    @objc func nextButtonTapped() {
        if selectedRadioButton != nil {
            selectedButtonName = selectedRadioButton?.titleLabel?.text // 선택된 버튼의 이름을 변수에 저장

            let addActionItemController = AddActionItemController()
            addActionItemController.selectedButtonName = selectedButtonName // 선택된 버튼의 이름을 전달
            addActionItemController.delegate = self // Set ActionItemController as the delegate

            navigationController?.pushViewController(addActionItemController, animated: true)
        }
    }
    
    func didAddActionItemText(_ text: String) {
        // Handle the text received from AddActionItemController here
        print("Text received in ActionItemController: \(text)")
    }


    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func closeButtonTapped() {
        let gotoMainController = MainVC()
        navigationController?.pushViewController(gotoMainController, animated: true)
    }

    func getActionData() {
        if let url = URL(string: "\(urlLink)actionItem/\(userId)/all") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                       if let error = error {
                           print("🚨 Error: \(error.localizedDescription)")
                           return
                       }
                // JSON data를 가져온다. optional 풀어줘야 함
                if let JSONdata = data {
                    let dataString = String(data: JSONdata, encoding: .utf8) //얘도 확인을 위한 코드임
                    print(dataString!)
                    // JSONDecoder 사용하기
                    let decoder = JSONDecoder() // initialize
                    do {
                                        let decodeData = try decoder.decode(actionItemData.self, from: JSONdata)
                                        DispatchQueue.main.async {
                                            self.actionItemData = decodeData
                                            // self.collectionView.reloadData()
                                        }
                                    } catch {
                                        print("🚨 JSON decoding error: \(error)")
                                    }
                }
            }
            task.resume()
        }
    }
    
}

