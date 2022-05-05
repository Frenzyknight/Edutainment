//
//  ContentView.swift
//  Edutainment
//
//  Created by Gaurav Ganju on 27/02/22.
//

import SwiftUI

struct ContentView: View {
    @State private var difficultyLevel = 2
    @State private var noOfQuestions = 5
    @State private var userAnswer = 0
    @State private var questionNumber = 1
    @State private var showQuestions = false
    @State private var showOptions = true
    @State private var showAlert = false
    @State private var questionGenerated = 0
    @State private var score = 0
    let questionAmount = [5, 10, 20]
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Neon"), Color("Life")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Multiplication")
                        .font(.largeTitle)
                        .bold()
                        .padding(10)
                    Spacer()
                    Button("Done") {
                        generateQuestion()
                        showOptions.toggle()
                        showQuestions.toggle()
                    }
                    .padding()
                }
                .opacity(showOptions ? 1 : 0)
                .animation(
                    .easeIn(duration: 1),
                    value: showOptions
                )

                Stepper("Enter difficulty level: \(difficultyLevel)", value: $difficultyLevel, in: 2...12)
                    .font(.title3)
                    .padding(10)
                    .opacity(showOptions ? 1 : 0)
                    .animation(
                        .easeIn(duration: 1),
                        value: showOptions
                    )
                VStack(alignment: .leading) {
                    Text("Pick no. of questions: ")
                        .font(.title3)
                        .padding(10)
                    Picker("Number of questions", selection: $noOfQuestions) {
                           ForEach(questionAmount, id: \.self) {
                               Text($0, format: .number)
                           }
                    }
                    .padding(10)
                    .pickerStyle(.segmented)
                }
                .opacity(showOptions ? 1 : 0)
                .animation(
                    .easeIn(duration: 1),
                    value: showOptions
                )

                Spacer()
                VStack() {
                    Text("Question: \(questionNumber)" )
                    Text("\(difficultyLevel) multiplied by \(questionGenerated) equals ")
                        .font(.title2)
                        .padding()
                        .background(.thickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                    TextField("Answer", value: $userAnswer, format: .number )
                        .keyboardType(.numberPad)
                        .font(.title2)
                        .padding()
                        .background(.thinMaterial)
                        .frame(width: 100, height: nil, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
                .opacity(showQuestions ? 1 : 0)
                .animation(
                    .easeIn(duration: 1),
                    value: showQuestions
                )
                Spacer()
                Spacer()
                HStack() {
                    Button("Restart") {
                        score = 0
                        questionNumber = 1
                        generateQuestion()
                        showOptions.toggle()
                        showQuestions.toggle()
                    }
                    .padding(22)
                    .foregroundColor(.red)
                    .background(.thickMaterial)
                    .clipShape(Circle())
                    Spacer()
                    Text("Score \(score)")
                        .padding()
                        .background(.thickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Spacer()
                    Button("Submit") {
                        checkAns()
                        questionNumber += 1
                        generateQuestion()
                        if questionNumber > noOfQuestions {
                            showAlert.toggle()
                        }
                    }
                    .padding(20)
                    .background(.thickMaterial)
                    .clipShape(Circle())
                }
                .opacity(showQuestions ? 1 : 0)
                .animation(
                    .easeIn(duration: 1),
                    value: showQuestions
                )
            }
        }
        .alert("GG it's finished", isPresented: $showAlert) {
            Button("OK!!") {
                score = 0
                questionNumber = 1
                generateQuestion()
                showOptions.toggle()
                showQuestions.toggle()
            }
        } message: {
            Text("Your score was \(score)")
        }
    }
    func generateQuestion() {
        questionGenerated = Int.random(in: 0...20)
    }
    func checkAns() {
        withAnimation(.linear) {
            if questionGenerated * difficultyLevel == userAnswer {
                score += 1
            } else {
                score -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
