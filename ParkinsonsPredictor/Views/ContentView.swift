//
//  ContentView.swift
//  ParkinsonsPredictor
//
//  Created by Andreas on 3/4/21.
//

import SwiftUI
import HealthKit
import CoreMotion
struct ContentView: View {
    @State var animate = true
    @State var animate2 = false
    @State var days = [Day]()
  
    @State var values = [Double]()
    
    @State var week = Week(id: UUID().uuidString,  sun: Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), mon:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](),  walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), tue:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), wed:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), thur:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), fri:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()), sat:  Day(id: "", score: [Score](), tremor: [Tremor](), balance: [Balance](), walkingSpeed: [WalkingSpeed](), strideLength: [Stride](), aysm: [Asymmetry](), date: Date()))
    var body: some View {
        ZStack {
            Color.white
            .ignoresSafeArea()
            .onAppear() {
                getHealthData()
                
                
                  
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 1.5)) {
                    animate = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            let sumArray = self.values.reduce(0, +)
                            let avgArrayValue = (sumArray) / Double(self.values.count)
                            print(avgArrayValue)
                            animate2 = true
                        }
                    }
                }
            }
        if animate {
            LoadingView()
                .transition(.opacity)
        }
            if animate2 {
                Color.white
                    .ignoresSafeArea()
                TabView {
                    HomeView(week: week)
                    .transition(.opacity)
                       .font(.system(size: 30, weight: .bold, design: .rounded))
                       .tabItem {
                           Image(systemName: "house")
                           Text("Home")
                       }
                    DataView(days: $days)
                    .transition(.opacity)
                       .font(.system(size: 30, weight: .bold, design: .rounded))
                       .tabItem {
                           Image(systemName: "chart.bar")
                           Text("Data")
                       }
//                    FeedView()
//                    .transition(.opacity)
//                       .font(.system(size: 30, weight: .bold, design: .rounded))
//                       .tabItem {
//                           Image(systemName: "person.3")
//                           Text("Social")
//                       }
            }
            }
        }
    }
   
    func getHealthData() {
        let defaults = UserDefaults.standard
        let healthStore = HKHealthStore()
       
        let readData = Set([
            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
            HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
            HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!
        ])
      
        healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
            if success {
        if HKHealthStore.isHealthDataAvailable() {
        let readType = HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)
            
            let url = self.getDocumentsDirectory().appendingPathComponent("data.txt")
            do {
               
                let input = try String(contentsOf: url)
                
               
                let jsonData = Data(input.utf8)
                do {
                    let decoder = JSONDecoder()

                    do {
                        
                       
                    } catch {
                        print(error.localizedDescription)
                    }
            } catch {
                print(error.localizedDescription)
                
            }
        } catch {
            print(error.localizedDescription)
            
        }
            print("Values")
           
        let query2 = HKObserverQuery(sampleType: readType!, predicate: nil) { query, completionHandler, error in
            if error != nil {
                print(#function + ": Error receiving data from background for type \(readType!.identifier): \(error.debugDescription)")
            } else {
               
                print(#function + ": Successfully received data from background for type \(readType!.identifier)")
               
                    let readData = Set([
                        HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
                        HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
                        HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!
                    ])
                   
                    healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                        if success {
                            let calendar = NSCalendar.current
                            
                            var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
                            
                            let offset = (7 + anchorComponents.weekday! - 2) % 7
                            
                            anchorComponents.day! -= offset
                            anchorComponents.hour = 2
                            
                            guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
                                fatalError("*** unable to create a valid date from the given components ***")
                            }
                            
                            let interval = NSDateComponents()
                            interval.minute = 30
                                                
                            let endDate = Date()
                                                        
                            guard let startDate = calendar.date(byAdding: .month, value: -12, to: endDate) else {
                                fatalError("*** Unable to calculate the start date ***")
                            }
                                                
                            guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingSpeed) else {
                                fatalError("*** Unable to create a step count type ***")
                            }

                            let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                                    quantitySamplePredicate: nil,
                                                                    options: .discreteAverage,
                                                                        anchorDate: anchorDate,
                                                                        intervalComponents: interval as DateComponents)
                            
                            query.initialResultsHandler = {
                                query, results, error in
                                
                                guard let statsCollection = results else {
                                    fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                                    
                                }
                                                    
                                statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                                    if let quantity = statistics.averageQuantity() {
                                        let date = statistics.startDate
                                        //for: E.g. for steps it's HKUnit.count()
                                        let value = quantity.doubleValue(for: HKUnit.meter().unitDivided(by: HKUnit.second()))
                                        
                                        let components = Date().get(.day, .month, .year, .weekOfMonth)
                                        let components2 = date.get(.day, .month, .year, .weekOfMonth)
                                        if let today = components2.day, let month = components.month, let year = components.year, let week = components.weekOfMonth {
                                        if let today2 = components.day, let month2 = components.month, let year2 = components.year, let week2 = components.weekOfMonth  {
                                           
                                       // print(value)
                                        
                                            if "\(week)" + "\(month)" + "\(year)" == "\(week2)" + "\(month2)" + "\(year2)" {
                                                if today == 0 {
                                                    self.week.mon.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                                                } else if today == 1 {
                                                    
                                                    self.week.tue.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                                                    
                                                } else if today == 2 {
                                                    self.week.wed.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                                                } else if today == 3 {
                                                    self.week.thur.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                                                }  else if today == 4 {
                                                    self.week.fri.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                                                }  else if today == 5 {
                                                    self.week.sat.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                                            } else if today == 6 {
                                                self.week.sun.walkingSpeed.append(WalkingSpeed(id: UUID().uuidString, speed: value, date: date))
                                            }
                                            }
                                        }
                                        }
                                       // print(quantity)
                                       
                                       
                                        //print(date)
                                        
                                       
                                       // dates = defaults?.array(forKey: "dates") as? [Date] ?? []
    //                                        self.values.append(value)
    //                                        self.dates.append(date)
    //
    //
    //                                        defaults?.set(self.values, forKey: "values")
    //                                        defaults?.set(self.dates, forKey: "dates")
    //                                        defaults?.set(self.values.last ?? 0.0, forKey: "last")
    //
    //
    //                                        WidgetCenter.shared.reloadAllTimelines()
                                        print("avg")
                                        print((defaults.double(forKey: "avg") ?? 0.0) )
                                        
                                       
                                       
                                    }
                                   
                                    
                                }
                                
                             
                                //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
                              
                             
                            }
                            guard let quantityType2 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingDoubleSupportPercentage) else {
                                fatalError("*** Unable to create a step count type ***")
                            }

                            let query2 = HKStatisticsCollectionQuery(quantityType: quantityType2,
                                                                    quantitySamplePredicate: nil,
                                                                    options: .discreteAverage,
                                                                        anchorDate: anchorDate,
                                                                        intervalComponents: interval as DateComponents)
                            
                            query2.initialResultsHandler = {
                                query, results, error in
                                
                                guard let statsCollection = results else {
                                    fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                                    
                                }
                                                    
                                statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                                    if let quantity = statistics.averageQuantity() {
                                        let date = statistics.startDate
                                        //for: E.g. for steps it's HKUnit.count()
                                        let value = quantity.doubleValue(for: HKUnit.percent())
                                        values.append(value*100)
                                       // print(quantity)
                                       
                                        let components = Date().get(.day, .month, .year, .weekOfMonth)
                                        let components2 = date.get(.day, .month, .year, .weekOfMonth)
                                        if let today = components2.day, let month = components.month, let year = components.year, let week = components.weekOfMonth {
                                        if let today2 = components.day, let month2 = components.month, let year2 = components.year, let week2 = components.weekOfMonth  {
                                           
                                      //  print(value)
                                        
                                            if "\(week)" + "\(month)" + "\(year)" == "\(week2)" + "\(month2)" + "\(year2)" {
                                                if today == 0 {
                                                    self.week.mon.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                                } else if today == 1 {
                                                    
                                                    self.week.tue.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                                    
                                                } else if today == 2 {
                                                    self.week.wed.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                                } else if today == 3 {
                                                    self.week.thur.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                                }  else if today == 4 {
                                                    self.week.fri.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                                }  else if today == 5 {
                                                    self.week.sat.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                            } else if today == 6 {
                                                self.week.sun.balance.append(Balance(id: UUID().uuidString, value: value, date: date))
                                            }
                                            }
                                        }
                                        }
                                        //print(date)
                                        
                                       
                                       // dates = defaults?.array(forKey: "dates") as? [Date] ?? []
    //                                        self.values.append(value)
    //                                        self.dates.append(date)
    //
    //
    //                                        defaults?.set(self.values, forKey: "values")
    //                                        defaults?.set(self.dates, forKey: "dates")
    //                                        defaults?.set(self.values.last ?? 0.0, forKey: "last")
    //
    //
    //                                        WidgetCenter.shared.reloadAllTimelines()
                                        print("avg")
                                        print((defaults.double(forKey: "avg") ?? 0.0) )
                                        
                                       
                                       
                                    }
                                   
                                    
                                }
                                
                             
                                //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
                              
                             
                            }
                            
                            guard let quantityType3 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingStepLength) else {
                                fatalError("*** Unable to create a step count type ***")
                            }

                            let query3 = HKStatisticsCollectionQuery(quantityType: quantityType3,
                                                                    quantitySamplePredicate: nil,
                                                                    options: .discreteAverage,
                                                                        anchorDate: anchorDate,
                                                                        intervalComponents: interval as DateComponents)
                            
                            query3.initialResultsHandler = {
                                query, results, error in
                                
                                guard let statsCollection = results else {
                                    fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                                    
                                }
                                                    
                                statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                                    if let quantity = statistics.averageQuantity() {
                                        let date = statistics.startDate
                                        //for: E.g. for steps it's HKUnit.count()
                                        
                                        let components = Date().get(.day, .month, .year, .weekOfMonth)
                                        let components2 = date.get(.day, .month, .year, .weekOfMonth)
                                        if let today = components2.day, let month = components.month, let year = components.year, let week = components.weekOfMonth {
                                        if let today2 = components.day, let month2 = components.month, let year2 = components.year, let week2 = components.weekOfMonth  {
                                            let value = quantity.doubleValue(for: HKUnit.mile())
                                        //print(value)
                                        
                                            if "\(week)" + "\(month)" + "\(year)" == "\(week2)" + "\(month2)" + "\(year2)" {
                                                if today == 0 {
                                                    self.week.mon.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                                } else if today == 1 {
                                                    
                                                    self.week.tue.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                                    
                                                } else if today == 2 {
                                                    self.week.wed.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                                } else if today == 3 {
                                                    self.week.thur.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                                }  else if today == 4 {
                                                    self.week.fri.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                                }  else if today == 5 {
                                                    self.week.sat.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                            } else if today == 6 {
                                                self.week.sun.strideLength.append(Stride(id: UUID().uuidString, length: value, date: date))
                                            }
                                            }
                                        }
                                        }
                                       
                                        //print(date)
                                        
                                       
                                       // dates = defaults?.array(forKey: "dates") as? [Date] ?? []
    //                                        self.values.append(value)
    //                                        self.dates.append(date)
    //
    //
    //                                        defaults?.set(self.values, forKey: "values")
    //                                        defaults?.set(self.dates, forKey: "dates")
    //                                        defaults?.set(self.values.last ?? 0.0, forKey: "last")
    //
    //
    //                                        WidgetCenter.shared.reloadAllTimelines()
                                        print("avg")
                                        print((defaults.double(forKey: "avg") ?? 0.0) )
                                        
                                       
                                       
                                    }
                                   
                                    
                                }
                                
                             
                                //if (self.values.last ?? 0.0) - 11 > ((defaults.double(forKey: "avg")))  {
                              
                             
                            }
                            healthStore.execute(query)
                            healthStore.execute(query2)
                            healthStore.execute(query3)
                        } else {
                            print("Authorization failed")

                        }
                    }
               
            }
            completionHandler()
                
        
            
        }
        // defaults?.set(try? PropertyListEncoder().encode(data), forKey:"data")
        healthStore.execute(query2)
           
        }
            }
           
        }
        //defaults?.set(dates, forKey: "dates")
      
       
       
        //defaults?.set(self.values.reduce(0, +)/Double(self.values.count), forKey: "avg")
        //WidgetCenter.shared.reloadAllTimelines()
    }
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
  
}

