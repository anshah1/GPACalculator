import SwiftUI

struct ContentView: View {
    
    @State var subjects: [String] = [""]
    @State var grades: [String] = [""]
    var possibleGrades = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "E"]
    var correspondingGPA = [4.0, 4.0, 3.66, 3.33, 3, 2.66, 2.33, 2, 1.66, 1.33, 1, 0.66, 0]
    @State var cumulativeGPA: Double = 0.0
    @State var totalClasses: Int = 0
    @State var totalGradePoints = 0.0
    
    func calculateGPA() -> Double {
        totalGradePoints = 0.0
        totalClasses = 0
        
        for index in 0..<subjects.count {
            if let gradeIndex = possibleGrades.firstIndex(of: grades[index]) {
                if gradeIndex < correspondingGPA.count {
                    totalGradePoints += correspondingGPA[gradeIndex]
                    totalClasses += 1
                }
            }
        }
        
        if totalClasses == 0 {
            return 0.0
        }
        
        let GPA = totalGradePoints / Double(totalClasses)
        return (GPA * 100).rounded() / 100
    }
    
    func addClassRow() {
        subjects.append("")
        grades.append("")
    }
    
    func removeClass(at index: Int) {
        subjects.remove(at: index)
        grades.remove(at: index)
    }
    
    func gpa(for grade: String) -> String {
        if let index = possibleGrades.firstIndex(of: grade),
           index < correspondingGPA.count {
            return String(correspondingGPA[index])
        }
        return ""
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("GPA Calculator")
                            .font(.title)
                            .padding(.trailing, 20.0)
                    }
                    ForEach(0..<subjects.count, id: \.self) { index in
                        HStack {
                            Button(action: {
                                removeClass(at: index)
                            }) {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(.red)
                            }
                            TextField("Class Name (optional)", text: $subjects[index])
                                .frame(width: 200.0)
                                .autocorrectionDisabled()
                                .padding(0.0)
                            TextField("Letter Grade", text: $grades[index])
                                .autocorrectionDisabled()
                            Text(gpa(for: grades[index]))
                        }
                    }
                    HStack {
                        Button(action: {
                            addClassRow()
                        }) {
                            Text("Add Class")
                                .frame(width: 140, height: 40)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .font(.subheadline)
                        }
                        .padding()
                        Button(action: {
                            cumulativeGPA = calculateGPA()
                        }) {
                            Text("Calculate GPA")
                                .frame(width: 140, height: 40)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(20)
                                .font(.subheadline)
                        }
                    }
                    
                    Text("Your cumulative GPA is \(String(format: "%.2f", cumulativeGPA))")
                        .padding(.bottom, 20.0)
                    NavigationLink(destination: GoalView(cumulativeGPA: $cumulativeGPA, totalClasses: $totalClasses)) {
                        Text("Let's set some GPA Goals!")
                    }
                    .frame(width: 300, height: 50)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(20)
                    .font(.headline)
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
