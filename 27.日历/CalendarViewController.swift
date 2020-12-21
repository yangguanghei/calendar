//
//  CalendarViewController.swift
//  27.日历
//
//  Created by 梁森 on 2020/12/21.
//

import UIKit

class CalendarViewController: UIViewController {

	// 某个月的所有星期
	var monthWeeks: [WeekModel]?
	// 
	var months: [MonthModel]?
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0.0
		layout.minimumInteritemSpacing = 0.0
		layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
		layout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 300), collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
//		collectionView.isPagingEnabled = true
		collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "CalendarCollectionViewCell")
		collectionView.register(CalendarCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalendarCollectionReusableView")
		collectionView.backgroundColor = .white
		return collectionView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		view.backgroundColor = .yellow
		view.addSubview(collectionView)
    }
    

}


extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return months?.count ?? 0
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let weeks = months?[section].weeks
		return weeks?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
		let weeks = months?[indexPath.section].weeks
		cell.week = weeks?[indexPath.row]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalendarCollectionReusableView", for: indexPath) as! CalendarCollectionReusableView
			let monthModel = months?[indexPath.section]
			header.dateLable.text = "\(String(monthModel?.year ?? 0))年\(String(monthModel?.month ?? 0))月"
			header.backgroundColor = .orange
			return header
		} else {
			return UICollectionReusableView()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: UIScreen.main.bounds.width, height: 40)
	}
}
