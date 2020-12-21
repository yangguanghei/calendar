//
//  CalendarCollectionViewCell.swift
//  27.日历
//
//  Created by 梁森 on 2020/12/21.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
	lazy var labels: [UILabel] = {
		let labels = [UILabel]()
		return labels
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initSubViews()
		self.backgroundColor = .red
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var week: WeekModel? {
		didSet{
			let lblStartIndex = (week?.startDay ?? 1) - 1	// 可显示的label开始下标
			let lblEndIndex = lblStartIndex + (week?.days?.count ?? 1) - 1	// 可显示的label结束下标
			var dayIndex = 0	// 某个星期中所有日期的下标
			for i in 0..<labels.count {
				let label = labels[i]
				if (i < lblStartIndex) || (i > lblEndIndex) {	// 不在某个星期范围的隐藏掉
					label.isHidden = true
				} else {
					label.isHidden = false
					let dayModel = week?.days?[dayIndex]
					let label = labels[i]
					label.text = "\(String(dayModel?.day ?? 0))"
					dayIndex += 1
				}
			}
		}
	}
	
}

extension CalendarCollectionViewCell {
	
	private func initSubViews() {
		
		let lblWidth = self.bounds.width / 7
		let lblHeight = self.bounds.height
		for i in 0..<7{
			let lbl = UILabel()
			lbl.textAlignment = .center
			contentView.addSubview(lbl)
			lbl.frame = CGRect(x: lblWidth * CGFloat(i), y: 0, width: lblWidth, height: lblHeight)
			labels.append(lbl)
			lbl.backgroundColor = .green
		}
	}
}
