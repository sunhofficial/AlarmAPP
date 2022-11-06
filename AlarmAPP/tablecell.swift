//
//  tablecell.swift
//  AlarmAPP
//
//  Created by SunHo Lee on 2022/11/05.
//

import Foundation
import UIKit
class TTAB : UITableViewCell{
    static let identifier = "alarmTableCell"
    let label : UILabel = {
       let label = UILabel()
        label.textColor = .blue
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [label,dateLabel].forEach{
            contentView.addSubview($0)
        }
        label.snp.makeConstraints{
            $0.top.leading.equalToSuperview()
        }
        dateLabel.snp.makeConstraints{
            $0.bottom.equalTo(contentView)
           
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
