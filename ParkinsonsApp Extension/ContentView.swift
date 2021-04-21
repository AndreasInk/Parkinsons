//
//  ContentView.swift
//  ParkinsonsApp Extension
//
//  Created by Andreas on 4/9/21.
//

import SwiftUI
import CoreMotion
struct ContentView: View {
    @State var  movementDisorderManager = CMMovementDisorderManager()
    
    var body: some View {
        Text("Hello, World!")
            .padding()
            .onAppear() {
                getTremorData()
            }
    }
    func getTremorData() {
        guard CMMovementDisorderManager.isAvailable() else {
            // The movement disorder manager is not availble on this device.
            return
        }
       
        // Instantiate the Movement Disorder Manager
        movementDisorderManager = CMMovementDisorderManager()

        // Start monitoring the user. The maximum duration is seven days.
        movementDisorderManager.monitorKinesias(forDuration: 60.0 * 60.0 * 24.0 * 7.0)
        
        guard let endDate = movementDisorderManager.lastProcessedDate() else {
            // The manager has not processed any results yet.
            return
        }
        let calendar = NSCalendar.current
        guard var startDate = calendar.date(byAdding: .day, value: -7, to: endDate) else {
            fatalError("*** Unable to calculate the start date ***")
        }
        // Get the last batch of tremor results.
        movementDisorderManager.queryTremor(from: startDate, to: endDate) { (tremorResults, error) in
            
            // Check for errors.
            if let error = error {
                // Handle the error here.
                print("*** An error occurred: \(error.localizedDescription) ***")
                return
            }
            print(tremorResults)
            // Do something with the tremor results here.
        }

        // Get the last batch of dyskinetic symptom results.
        movementDisorderManager.queryDyskineticSymptom(from: startDate, to: endDate) { (dyskineticSymptomResults, error) in
            
            // Check for errors.
            if let error = error {
                // Handle the error here.
                print("*** An error occurred: \(error.localizedDescription) ***")
                return
            }
            
            // Do something with the dyskinetic symptom results here.
            print(dyskineticSymptomResults)
        }

        startDate = endDate
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
