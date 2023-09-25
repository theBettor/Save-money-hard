//
//  ViewController.swift
//  Save money hard
//
//  Created by 김찬교 on 2023/09/13.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    let calManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        setupTableView()
    }
    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupNaviBar() {
        self.title = "Save Money Hard"
        
        // 네비게이션바 우측에 Plus 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self // 이거 설정안하면 셀 눌렀을때 다음 화면으로 못감
        // 테이블뷰의 선 없애기
        tableView.separatorStyle = .none
    }
    
    @objc func plusButtonTapped() {
        performSegue(withIdentifier: "CalCell", sender: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if calManager.getCalListFromCoreData().count == 0 {
            self.tableView.setEmptyMessage("당신의 돈을 기록하여 주세요")
        } else {
            self.tableView.restore()
        }

        return calManager.getCalListFromCoreData().count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalCell", for: indexPath) as! CalCell
        // 셀에 모델(ToDoData) 전달
        let calData = calManager.getCalListFromCoreData()
        cell.calData = calData[indexPath.row]
        
//         셀위에 있는 버튼이 눌렸을때 (뷰컨트롤러에서) 어떤 행동을 하기 위해서 클로저 전달
//        cell.updateButtonPressed = { [weak self] (senderCell) in
//            // 뷰컨트롤러에 있는 세그웨이의 실행
//            self?.performSegue(withIdentifier: "CalCell", sender: indexPath)
//        }
//
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CalCell", sender: indexPath) // 나는 updatebutton 안쓸거니까 이거 써야될거같은데
    }
    
    // (세그웨이를 실행할때) 실제 데이터 전달 (ToDoData전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CalCell" {
            let detailVC = segue.destination as! ResultViewController
            
            guard let indexPath = sender as? IndexPath else { return }
            detailVC.calData = calManager.getCalListFromCoreData()[indexPath.row]
        }
    }
    
    // 테이블뷰의 높이를 자동적으로 추청하도록 하는 메서드
    // (ToDo에서 메세지가 길때는 셀의 높이를 더 높게 ==> 셀의 오토레이아웃 설정도 필요)
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


/// 강의 활용-10 16:46 참조
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
