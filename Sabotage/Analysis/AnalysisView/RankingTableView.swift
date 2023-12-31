import UIKit

class RankingTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let cellIdentifier = "CustomCell"
    let cellCount = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        addSubview(tableView)
        
        // Remove cell separator
        tableView.separatorStyle = .none
        
//        tableView.backgroundColor = .systemGroupedBackground
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    
    // MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.backgroundColor = .systemGray
//        cell.textLabel?.text = "\(indexPath.row + 1)"
        
        // Left Text
        let number = UILabel()
        number.translatesAutoresizingMaskIntoConstraints = false
        number.text = "\(indexPath.row + 1)"
        number.textColor = .black
        cell.contentView.addSubview(number)
        
        NSLayoutConstraint.activate([
            number.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 30),
            number.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        // Left Text
        let leftText = UILabel()
        leftText.translatesAutoresizingMaskIntoConstraints = false
        leftText.text = "Left Text"
        leftText.textColor = .black
        cell.contentView.addSubview(leftText)
        
        NSLayoutConstraint.activate([
            leftText.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 70),
            leftText.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        // Right Text
        let rightText = UILabel()
        rightText.translatesAutoresizingMaskIntoConstraints = false
        rightText.text = "Right Text"
        rightText.textColor = .black
        rightText.textAlignment = .right
        cell.contentView.addSubview(rightText)
        
        NSLayoutConstraint.activate([
            rightText.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -50),
            rightText.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        return cell
    }
}
