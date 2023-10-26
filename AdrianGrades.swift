//
//  SwiftUIView.swift
//  Grades.swiftpm
//
//  Created by Adrian Jurczenia on 10/24/23.
//

import SwiftUI

struct Grade: Identifiable {
    var id = UUID()
    var subject: String
    var score: Double
}

struct AdrianGrades: View {
    @State private var grades: [Grade] = []
    @State private var newSubject = ""
    @State private var newScore = ""
    
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
}

