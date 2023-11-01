//
//  SwiftUIView.swift
//  Grades.swiftpm
//
//  Created by Adrian Jurczenia on 10/24/23.
//

import SwiftUI

struct AdrianGrades: View {
    @State private var grades: [Grade] = []
    @State private var newSubject = ""
    @State private var newScore = ""
    @State private var isEditing = false 

    var body: some View {
        NavigationView {
            List {
                ForEach(grades.indices, id: \.self) { index in
                    VStack {
                        Text("\(grades[index].subject): \(grades[index].score)")
                        Spacer()
                        if isEditing {
                            Button(action: {
                               
                            }) {
                                Text("Edit")
                                    .foregroundColor(.blue)
                            }
                            Button(action: {
                                deleteGrade(at: IndexSet(integer: index))
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteGrade)
            }
            .navigationBarTitle("Grade Tracker")
            .navigationBarItems(trailing: Button(action: {
                isEditing.toggle()
            }) {
                Text(isEditing ? "Done" : "Edit")
            })
            
            VStack(alignment: .leading, spacing: 20) {
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
