//
//  CalCell.swift
//  Save money hard
//
//  Created by 김찬교 on 2023/09/15.
//

import UIKit

final class CalCell: UITableViewCell {

    // 수업내용에서 backgroundView를 ==> backView로 속성이름 바꿈 ⭐️⭐️
    // (테이블뷰셀에는 원래 backgroundView속성이 존재하기 때문에 이름 충돌발생함)
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var calLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    
    // ToDoData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행) ⭐️
    var calData: CalData? {
        didSet {
            configureUIwithData()
        }
    }
    
    // (델리게이트 대신에) 실행하고 싶은 클로저 저장
    // 뷰컨트롤러에 있는 클로저 저장할 예정 (셀(자신)을 전달)
//    var updateButtonPressed: (CalCell) -> Void = { (sender) in }
    
    // 아마 위에 여기서 셀 눌러서 넘어가게 해야될거같은데
    
    // 스토리보드의 생성자
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // 기본 UI
    func configureUI() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 8
        
    }
    
    // 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        calLabel.text = calData?.callabel
        dateTextLabel.text = calData?.dateString
        guard let colorNum = calData?.color else { return }
        let color = MyColor(rawValue: colorNum) ?? .red
        backView.backgroundColor = color.backgoundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
