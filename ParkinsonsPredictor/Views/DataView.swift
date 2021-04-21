//
//  SwiftUIView.swift
//  ParkinsonsPredictor
//
//  Created by Andreas on 3/5/21.
//

import SwiftUI

struct DataView: View {
    @State private var date = Date()
    @State var week = Week(id: UUID().uuidString,  sun: [Day](), mon:  [Day](), tue:  [Day](), wed:  [Day](), thur:  [Day](), fri:  [Day](), sat:  [Day]())
    @Binding var days: [Day]
    @State var progressValue = 0.5
    @State var rawData = [0.2, 0.3, 0.5]
    @State var day = Day(id: "", score: [Score](), tremor: [Tremor](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date())
    var body: some View {
        ScrollView {
        VStack {
        DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
            
                        .frame(maxHeight: 400)
            .padding()
            .onAppear() {
                for day in days {
                    let components = date.get(.day, .month, .year)
                    let components2 = day.date.get(.day, .month, .year)
                    if let today = components2.day, let month = components.month, let year = components.year {
                    if let today2 = components.day, let month2 = components.month, let year2 = components.year {
                        print("day: \(day), month: \(month), year: \(year)")
                    
                    if "\(today)" + "\(month)" + "\(year)" == "\(today2)" + "\(month2)" + "\(year2)" {
                        self.day = day
                    }
                    }
                    }
                }
            }
           // BarChartView(data: ChartData(values: [("12", day.score.map { $0.date. == Date() } )))
                                            //, ("3", week.tues.last?.score.reduce(0, +)/week.tues.last?.score.count), ("6", week.wed.last?.score.reduce(0, +)/week.wed.last?.score.count), ("9",week.thurs.last?.score.reduce(0, +)/week.thurs.last?.score.count), ("12", week.thurs.last?.score.reduce(0, +)/week.thurs.last?.score.count), ("3", week.thurs.last?.score.reduce(0, +)/week.thurs.last?.score.count), ("6", week.sun.score.last ?? 0.0)]), title: "Daily Progress", legend: "")
                .padding()
            
           // BarChartView(data: ChartData(values: [("12", week.mon.stride.last ?? 0.0), ("3", week.tue.stride.last ?? 0.0), ("6", week.wed.stride.last ?? 0.0), ("9", week.thur.stride.last ?? 0.0), ("12", week.fri.stride.last ?? 0.0), ("3", week.sat.stride.last ?? 0.0), ("6", week.sun.stride.last ?? 0.0)]), title: "Stride Progress", legend: "")
                .padding()
            
//            BarChartView(data: ChartData(values: [("12", week.mon.last ?? 0.0), ("3", week.tue.last ?? 0.0), ("6", week.wed.last ?? 0.0), ("9", week.thur.last ?? 0.0), ("12", week.fri.last ?? 0.0), ("3", week.sat.last ?? 0.0), ("6", week.sun.last ?? 0.0)]), title: "Tremor Severity", legend: "")
//                .padding()
    }
        }
    }
}

