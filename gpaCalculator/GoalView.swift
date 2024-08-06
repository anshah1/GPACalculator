//
//  GoalView.swift
//  gpaCalculator
//
//  Created by Ansh Shah on 4/1/24.
//

import SwiftUI

struct GoalView: View {
    
    @Binding var cumulativeGPA: Double
    @Binding var totalClasses: Int
    @State var goalGPA: String = ""
    @State var remainingClasses: String = ""
    @State var outputThing: String = ""
    
    func calculateNeeded() -> Double {
        let gradePointsSoFar = cumulativeGPA * Double(totalClasses)
        let requiredGradePoints = Double(totalClasses + (Int(remainingClasses) ?? 0)) * (Double(goalGPA) ?? 0)
        return (requiredGradePoints - gradePointsSoFar) / (Double(remainingClasses) ?? 0)
    }
    
    func whatToOutput() -> String {
        if calculateNeeded() > 4.0 {
            return "Please enter a more realistic goal GPA. Your upcoming required GPA is above 4.0, which is impossible"
        }
        else if calculateNeeded() < 0.0 {
            return "Please enter a higher realistic goal GPA. Your upcoming required GPA is below 0.0, which is impossible"
        }
        else if calculateNeeded() == 0.0 {
            return "Please enter a goal GPA. We cannot calculate a required GPA without a goal GPA."
        }
        else if Double(remainingClasses) == 0.0 {
            return "Please enter how many more classes you will be taking. We cannot calculate required GPA without that information"
        }
        else if calculateNeeded() >= cumulativeGPA {
            return "You need an average GPA of " + "\(String(format: "%.2f", calculateNeeded()))" + " for your next " + String(remainingClasses) + " classes. Good luck!"
        }
        else {
            return "You need an average GPA of " + "\(String(format: "%.2f", calculateNeeded()))" + "for your next " + String(remainingClasses) + " classes. You got this!"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Your GPA from the previous page was " + String(cumulativeGPA))
                .font(.title2)
                .padding(.trailing, 20.0)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20.0)
                HStack {
                    Text("Enter your goal GPA: ")
                        .padding(.trailing, 10.0)
                        .padding(.leading, 10.0)
                        .font(.headline)
                    TextField("Goal GPA", text: $goalGPA)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.headline)
                        .keyboardType(.decimalPad)
                }
                .padding(.bottom, 20.0)
                HStack {
                    Text("Enter how many more classes you will take: ")
                        .padding(.trailing, 10.0)
                        .padding(.leading, 10.0)
                        .font(.headline)
                    TextField("Remaining Classes #", text: $remainingClasses)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.headline)
                        .keyboardType(.decimalPad)
                }
                .padding(.bottom, 20.0)
                Button("Calculate my required GPA for my upcoming classes") {
                    outputThing = whatToOutput()
                }
                .padding(.bottom, 20)
                .frame(width: 260, height: 60)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(20)
                .font(.headline)
                .padding(.bottom, 10.0)
                Text(outputThing)
                
            }
            
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a binding to a dummy value for cumulativeGPA
        let dummyGPA = Binding.constant(3.5)
        let dummyTotalClasses = Binding.constant(1)
        // Pass the binding to the GoalView
        return GoalView(cumulativeGPA: dummyGPA, totalClasses: dummyTotalClasses)
    }
}
