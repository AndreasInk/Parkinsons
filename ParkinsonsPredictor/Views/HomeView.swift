//
//  HomeView.swift
//  ParkinsonsPredictor
//
//  Created by Andreas on 3/4/21.
//

import SwiftUI

struct HomeView: View {
    
    @State var week = Week(id: UUID().uuidString,  sun: [Day](), mon:  [Day](), tue:  [Day](), wed:  [Day](), thur:  [Day](), fri:  [Day](), sat:  [Day]())
    @State var progressValue = 0.5
    @State var rawDataToday = [0.2, 0.3, 0.5]
    @State var rawDataWeek = [Double]()
    @State var days = [Day]()
    @State var day = Day(id: "", score: [Score](), tremor: [Tremor](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date())
    var body: some View {
        VStack {
            HStack {
            Text("Hello there!")
                .bold()
                .font(.custom("Poppins-Bold", size: 24, relativeTo: .title))
                .foregroundColor(Color("blue"))
                Spacer()
            } .padding()
            .padding(.vertical)
            .onAppear() {
                for day in days {
                    let components = Date().get(.day, .month, .year, .weekOfMonth)
                    let components2 = day.date.get(.day, .month, .year, .weekOfMonth)
                    if let today = components2.day, let month = components.month, let year = components.year, let week = components.weekOfMonth {
                    if let today2 = components.day, let month2 = components.month, let year2 = components.year, let week2 = components.weekOfMonth  {
                        print("day: \(day), month: \(month), year: \(year)")
                    
                    if "\(today)" + "\(month)" + "\(year)" == "\(today2)" + "\(month2)" + "\(year2)" {
                        self.day = day
                    }
                        if "\(week)" + "\(month)" + "\(year)" == "\(week2)" + "\(month2)" + "\(year2)" {
                            if today == 0 {
                                self.week.mon.append( day)
                            } else if today == 1 {
                                
                                self.week.tue.append( day)
                                
                            } else if today == 2 {
                                self.week.wed.append( day)
                            } else if today == 3 {
                                self.week.thur.append( day)
                            }  else if today == 4 {
                                self.week.fri.append( day)
                            }  else if today == 5 {
                                self.week.sat.append( day)
                        } else if today == 6 {
                            self.week.sun.append( day)
                        }
                        }
                    }
                    }
                }
            }
            }
           
//                Text("AVG")
//                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
//                    .foregroundColor(Color("blue"))
//                Text("\(Double(progressValue*100).removeZerosFromEnd())")
//                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
//                    .foregroundColor(Color("blue"))
                HalvedCircularBar(progress: CGFloat(progressValue), min: CGFloat(rawDataToday.min() ?? 0.0), max: CGFloat(rawDataToday.max() ?? 0.0))
            Spacer()
            
        
        BarChartView(data: ChartData(values: [("Monday", (week.mon.score.reduce(0, +) / Double(week.mon.score.count)])  , title: "Stride Progress", legend: "")
            }
        
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
