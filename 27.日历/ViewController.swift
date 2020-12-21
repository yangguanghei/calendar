//
//  ViewController.swift
//  27.日历
//
//  Created by 梁森 on 2020/12/16.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		
		view.backgroundColor = .green
		
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let months = getMonths(range: -2...9)
		let calendarVC = CalendarViewController()
		present(calendarVC, animated: true) {}
		calendarVC.months = months
	}
	
}

extension ViewController {
	// 获取某个范围的所有月份(rang:显示月份的返回 0代表当前月)
	private func getMonths(range: CountableClosedRange<Int>) -> [MonthModel] {
		// 日历
		let calendar = Calendar.current
		// 当前日期
		let currentDate = Date()
		// 获取当前年
		let currentYear = calendar.component(.year, from: currentDate)
		// 获取当前月
		let currentMonth = calendar.component(.month, from: currentDate)
		
		var months = [MonthModel]()
		for i in range {
			var year = currentYear
			var month = currentMonth + i
			if month < 1 {   // 去年以及去年以前
				month = 12 + month % 12   // 1-2 = -1 （去年11月）
				year = currentYear + i / 12 - 1 // 1-2 = -1 （去年）
			}
			if month > 12 {  // 明年以及明年以后
				month = month % 12    // 12 + 1 = 13 （明年1月）
				year = currentYear + i / 12 + 1 // 12 + 1 = 13 （明年）
				if month == 0 {  // 12月的时候需要特殊处理下
					month = 12
					year = currentYear + i / 12
				}
			}
			let weeksInMonth = getMonthWeeks(year: year, month: month)
			let monthModels = MonthModel(year: year, month: month, weeks: weeksInMonth)
			months.append(monthModels)
		}
		
		print("一共\(months.count)个月")
		return months
	}
	
	// 获取某年某月的所有星期
	private func getMonthWeeks(year: Int, month: Int) -> [WeekModel] {
		// 日历
		let calendar = Calendar.current
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM"
		let date = formatter.date(from: "\(year)-\(month)")
		// 某月的所有天数
		let monthDayCount = calendar.range(of: .day, in: .month, for: date!)?.count ?? 0
		// 获取当某月的所有星期
		// 今天在一个星期中的第几天
		let otherFormatter = DateFormatter()
		otherFormatter.dateFormat = "yyyy-MM-dd"
		let firstDay = otherFormatter.date(from: "\(year)-\(month)-\(1)")
		var dayInWeek = calendar.component(.weekday, from: firstDay!)
		var startDayInWeek = dayInWeek
		// 某个星期的所有天数
		var weekDays = [DayModel]()
		// 某个月的所有星期
		var monthWeeks = [WeekModel]()
		
		for i in 1...monthDayCount {	// 遍历某月的所有天
			
			if dayInWeek > 7 {	// 开始下一个星期
				let week = WeekModel(year: year, month: month, startDay: startDayInWeek, days: weekDays)
				monthWeeks.append(week)
				startDayInWeek = 1
				dayInWeek = 1
				weekDays.removeAll()
			}
			let day = DayModel(year: year, month: month, day: i, dayInWeek: dayInWeek)
			weekDays.append(day)
			dayInWeek += 1	// 开始下一天
			
			if i == monthDayCount {	// 一个月中的最后一天
				let week = WeekModel(year: year, month: month, startDay: startDayInWeek, days: weekDays)
				monthWeeks.append(week)
			}
		}
		
		print("\(year)年\(month)月有\(monthWeeks.count)个星期")
		
		return monthWeeks
	}
}

// 每天
struct DayModel {
	let year: Int?
	let month: Int?
	let day: Int?
	/// 在一个星期中的第几天（一个星期从周日开始）
	let dayInWeek: Int?
}

// 某年某月某星期
struct WeekModel {
	let year: Int?
	let month: Int?
	/// 一个星期开始的那一天在一个星期中的第几天（一个星期从周日开始）
	let startDay: Int?
	/// 这个星期一共有多少天（有可能是不够七天的）
	let days: [DayModel]?
}

// 某年某月
struct MonthModel {
	let year: Int?
	let month: Int?
	/// 某年某月包含的所有星期
	let weeks: [WeekModel]?
}
