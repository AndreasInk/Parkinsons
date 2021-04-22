//
//  HomeView.swift
//  ParkinsonsPredictor
//
//  Created by Andreas on 3/4/21.
//

import SwiftUI

struct HomeView: View {
    @State var ready = false
    @State var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](),  walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()))
    @State var progressValue = 0.5
    @State var rawDataToday = [0.2, 0.3, 0.5]
    @State var rawDataWeek = [Double]()
    @State var days = [Day]()
    @State var day = Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date())
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
                let model = ParkinsonsScore()
               
               
                do {
                    let double = week.mon.balance.map({ $0.value })
                   
                    let speed = week.mon.walkingSpeed.map({ $0.speed })
                    let length = week.mon.strideLength.map({ $0.length })
                    let prediction = try model.prediction(double_: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length))
                    if  !prediction.sourceName.isNaN {
                    week.mon.totalScore = prediction.sourceName
                        print("Prediction")
                        print(prediction.sourceName)
                    }
                 
                } catch {
                    // something went wrong!
                }
                do {
                    let double = week.tue.balance.map({ $0.value })
                    let speed = week.tue.walkingSpeed.map({ $0.speed })
                    let length = week.tue.strideLength.map({ $0.length })
                    let prediction = try model.prediction(double_: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length))
                    if  !prediction.sourceName.isNaN {
                    week.tue.totalScore = prediction.sourceName
                    }
                  
                } catch {
                    // something went wrong!
                }
                do {
                    let double = week.wed.balance.map({ $0.value })
                    let speed = week.wed.walkingSpeed.map({ $0.speed })
                    let length = week.wed.strideLength.map({ $0.length })
                    let prediction = try model.prediction(double_: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length))
                    if  !prediction.sourceName.isNaN {
                    week.wed.totalScore = prediction.sourceName
                    }
                  
                } catch {
                    // something went wrong!
                }
                do {
                    let double = week.thur.balance.map({ $0.value })
                    let speed = week.thur.walkingSpeed.map({ $0.speed })
                    let length = week.thur.strideLength.map({ $0.length })
                    let prediction = try model.prediction(double_: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length))
                    if  !prediction.sourceName.isNaN {
                    week.thur.totalScore = prediction.sourceName
                    }
                } catch {
                    // something went wrong!
                }
                do {
                    let double = week.fri.balance.map({ $0.value })
                    let speed = week.fri.walkingSpeed.map({ $0.speed })
                    let length = week.fri.strideLength.map({ $0.length })
                    let prediction = try model.prediction(double_: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length))
                    week.fri.totalScore = prediction.sourceName
                  
                } catch {
                    // something went wrong!
                }
                do {
                    let double = week.sat.balance.map({ $0.value })
                    let speed = week.sat.walkingSpeed.map({ $0.speed })
                    let length = week.sat.strideLength.map({ $0.length })
                    let prediction = try model.prediction(double_: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length))
                    if  !prediction.sourceName.isNaN {
                    week.sat.totalScore = prediction.sourceName
                    }
                  
                } catch {
                    // something went wrong!
                }
                do {
                    let double = week.sun.balance.map({ $0.value })
                    let speed = week.sun.walkingSpeed.map({ $0.speed })
                    let length = week.sun.strideLength.map({ $0.length })
                    let prediction = try model.prediction(double_: average(numbers: double), speed: average(numbers: speed), length: average(numbers: length))
                    if  !prediction.sourceName.isNaN {
                    week.sun.totalScore = prediction.sourceName
                    }
                    
                } catch {
                    // something went wrong!
                }
                ready = true
//                for day in days {
//                    let components = Date().get(.day, .month, .year, .weekOfMonth)
//                    let components2 = day.date.get(.day, .month, .year, .weekOfMonth)
//                    if let today = components2.day, let month = components.month, let year = components.year, let week = components.weekOfMonth {
//                    if let today2 = components.day, let month2 = components.month, let year2 = components.year, let week2 = components.weekOfMonth  {
//                        print("day: \(day), month: \(month), year: \(year)")
//
//                    if "\(today)" + "\(month)" + "\(year)" == "\(today2)" + "\(month2)" + "\(year2)" {
//                        self.day = day
//                    }
//                        if "\(week)" + "\(month)" + "\(year)" == "\(week2)" + "\(month2)" + "\(year2)" {
//                            if today == 0 {
//                                self.week.mon = day
//                            } else if today == 1 {
//
//                                self.week.tue = day
//
//                            } else if today == 2 {
//                                self.week.wed = day
//                            } else if today == 3 {
//                                self.week.thur = day
//                            }  else if today == 4 {
//                                self.week.fri = day
//                            }  else if today == 5 {
//                                self.week.sat = day
//                        } else if today == 6 {
//                            self.week.sun = day
//                        }
//                        }
//                    }
//                    }
//                }
        
            }
           
//                Text("AVG")
//                    .font(.custom("Poppins-Bold", size: 14, relativeTo: .headline))
//                    .foregroundColor(Color("blue"))
//                Text("\(Double(progressValue*100).removeZerosFromEnd())")
//                    .font(.custom("Poppins-Bold", size: 16, relativeTo: .headline))
//                    .foregroundColor(Color("blue"))
            
            
                //HalvedCircularBar(progress: CGFloat(progressValue), min: CGFloat(rawDataToday.min() ?? 0.0), max: CGFloat(rawDataToday.max() ?? 0.0))
            Spacer()
            
            if ready {
        BarChartView(data: ChartData(values: [("Monday", week.mon.totalScore ?? 0.01), ("Tuesday", week.tue.totalScore ?? 0.01), ("Wednesday", week.wed.totalScore ?? 0.01), ("Thursday", week.thur.totalScore ?? 0.01), ("Friday", week.fri.totalScore ?? 0.01), ("Saturday", week.sat.totalScore ?? 0.01), ("Sunday", week.sun.totalScore ?? 0.01)])  , title: "Stride Progress", legend: "")
    }
        }
   
    
}
    func average(numbers: [Double]) -> Double {
        print(numbers)
        return Double(numbers.reduce(0,+))/Double(numbers.count)
    }
}
