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
    @State var animate2 = true
    @State var days = [Day]()
    @State var values = [Double]()
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
                HomeView()
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
            HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!,
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
                        HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!,
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
                                                
                            guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingDoubleSupportPercentage) else {
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
                                        let value = quantity.doubleValue(for: HKUnit.percent())
                                        values.append(value*100)
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
                           
                            healthStore.execute(query)
                           
                           
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

