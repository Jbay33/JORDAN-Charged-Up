//
//  Mommylo.swift
//  JORDAN Charged Up
//
//  Created by  on 1/17/23.
//

import SwiftUI

struct Mommylo: View {
    //@available(iOS 16, *) typealias NavigationView = NavigationStack
    
    @State private var showingAlert = false
    @State var notes = ""
    @Environment(\.dismiss) var dismiss
    @State var notesForMatch = ""
    @State var disabled = false
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Spacer()
                    Text("Notes").frame(width: 120)
                    Spacer()
                    Spacer()
                    Text("End of match").frame(width: 120)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    VStack {
                        
                        TextEditor(text: $notes)
                            .frame(width: 300, height: 100)
                            .scrollContentBackground(.hidden)
                            .background(Color(white: 0.93), in: RoundedRectangle(cornerRadius: 10))
                            .scrollDismissesKeyboard(.interactively)
                            .onChange(of: notes, perform: { newValue in
                                GameData.notes = notes
                            })
                            .onSubmit {
                                GameData.notes = notes
                            }
                            .padding()
                    }.frame(height: 150)
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Button("Submit Data") {
                                showingAlert = true
                            }.padding().buttonStyle(.bordered)
                            
                            Button("Save for Later") {
                                //TODO: replace .finalize() & .toJSON()
                                print(GameData.ToJSON())
                                GameData.finalize()
                                
                                
                                Flow.waterfall = true
                                dismiss()
                            }.padding().buttonStyle(.borderedProminent)
                        }
                        
                        Spacer()
                    }.frame(height: 150)
                    
                    Spacer()
                }
                
            }.onAppear{
                notes = GameData.notes
            }.alert("Are you sure?", isPresented: $showingAlert) {
                Button("Yes") {
                    //John  Submit
                    
                    //TODO: replace .clear() & .toJSON()
                    print(GameData.ToJSON())
                    GameData.clear()
                    
                    
                    Flow.waterfall = true
                    dismiss()
                }
                
                Button("No", role: .cancel) { }
            }
        }
    }
}


struct Mommylo_Previews: PreviewProvider {
    static var previews: some View {
        Mommylo()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
