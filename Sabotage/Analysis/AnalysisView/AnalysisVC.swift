import UIKit

let scrollView = UIScrollView()
let contentView = UIView()
let label1 = UILabel()
let label2 = UILabel()
let label3 = UILabel()
let label4 = UILabel()

let rankingTableView = RankingTableView()
let rankingBG = UIImageView(image: UIImage(named: "RankingBG"))

class AnalysisVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        scrollViewUI()
        contentViewUI()
        
        titleUI()
        
        rankingUI()
    }
    
    func scrollViewUI() {
        // MARK: - UIScrollView 생성
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .orange
        view.addSubview(scrollView)
        
        // MARK: ScrollView autolayout 설정
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func contentViewUI() {
        // MARK: - 스크롤뷰 content 추가
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .blue
        scrollView.addSubview(contentView)
        
        // MARK: - contentView의 오토레이아웃 설정
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            contentView.heightAnchor.constraint(equalToConstant: 1000),
        ])
    }
    
    func titleUI() {
        // MARK: - contentView에 추가할 content 생성 및 설정
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "이번주"
        label1.font = .boldSystemFont(ofSize: 20)
        label1.textColor = .black
        label1.numberOfLines = 0
        // MARK: - 스크롤 방향 설정
        contentView.addSubview(label1)
        
        // MARK: - contentView에 추가할 content 생성 및 설정
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "사용자 순위"
        label2.font = .boldSystemFont(ofSize: 20)
        label2.textColor = .black
        label2.numberOfLines = 0
        contentView.addSubview(label2)
        
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "변화량"
        label3.font = .boldSystemFont(ofSize: 20)
        label3.textColor = .black
        label3.numberOfLines = 0
        contentView.addSubview(label3) // label3를 contentView에 추가
        
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.text = "앱 별 사용량"
        label4.font = .boldSystemFont(ofSize: 20)
        label4.textColor = .black
        label4.numberOfLines = 0
        contentView.addSubview(label4)
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            label1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 50),
            label2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 50), // label3의 topAnchor를 label2의 bottomAnchor에 연결
            label3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            label4.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 50), // label4의 topAnchor를 label3의 bottomAnchor에 연결
            label4.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    func rankingUI() {
        rankingTableView.translatesAutoresizingMaskIntoConstraints = false
        rankingTableView.backgroundColor = .brown
        contentView.addSubview(rankingTableView)
        
        rankingBG.translatesAutoresizingMaskIntoConstraints = false
        rankingBG.contentMode = .scaleAspectFit
        rankingBG.backgroundColor = .base200
        contentView.addSubview(rankingBG)
        
        NSLayoutConstraint.activate([
            // 배경 이미지 뷰 위치 설정
            rankingBG.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 5),
            rankingBG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            rankingBG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            rankingBG.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50)),
            
            // 테이블 뷰 위치 설정
            rankingTableView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            rankingTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            rankingTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rankingTableView.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50)-20),
        ])
        
        // 테이블 뷰를 배경 이미지 뷰 위에 올리기
        contentView.sendSubviewToBack(rankingBG)
    }

}
