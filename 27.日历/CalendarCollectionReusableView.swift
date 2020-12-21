//
//  CalendarCollectionReusableView.swift
//  27.日历
//
//  Created by 梁森 on 2020/12/21.
//

import UIKit

class CalendarCollectionReusableView: UICollectionReusableView {
        
	lazy var dateLable: UILabel = {
		let dateLable = UILabel()
		dateLable.textAlignment = .center
		return dateLable
	}()

	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(dateLable)
		dateLable.frame = self.bounds
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
