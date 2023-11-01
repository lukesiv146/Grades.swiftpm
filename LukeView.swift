//
//  LukeView.swift
//  Grades
//
//  Created by Luke J. Sivulka on 10/24/23.
//

import SwiftUI

struct Grade: Identifiable, Codable {
    var id = UUID()
    var subject: String
    var score: Double
}


struct LukeView: View {
    @State var grades: [Grade] = []
     
    @State var newSubject = ""
    @State var newScore = ""
    
   let gradesKey = "SavedGrades"
    
    var body: some View {
        NavigationView {
            List {
                ForEach(grades) { grade in
                    Text("\(grade.subject): \(grade.score)")
                }
                .onDelete(perform: deleteGrade)
            }
            .navigationBarTitle("Grade Tracker")
            .navigationBarItems(trailing: EditButton())
            
            HStack {
                TextField("Subject", text: $newSubject)
                TextField("Score", text: $newScore)
                    .keyboardType(.decimalPad)
                Button(action: addGrade) {
                    Text("Add Grade")
                }
            }
            .padding()
        }
        .onAppear(perform: loadGrades)
        .onDisappear(perform: saveGrades)
    }
    
    func addGrade() {
        if let score = Double(newScore), !newSubject.isEmpty {
            let grade = Grade(subject: newSubject, score: score)
            grades.append(grade)
            newSubject = ""
            newScore = ""
        }
    }
    
    func deleteGrade(at offsets: IndexSet) {
        grades.remove(atOffsets: offsets)
    }
    
    
    func loadGrades() {
        if let data = UserDefaults.standard.data(forKey: gradesKey) {
            if let loadedGrades = try? JSONDecoder().decode([Grade].self, from: data) {
                grades = loadedGrades
            }
        }
    }
    
    
    func saveGrades() {
        if let data = try? JSONEncoder().encode(grades) {
            UserDefaults.standard.set(data, forKey: gradesKey)
        }
    }
}


