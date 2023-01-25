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
    let specBlue = Color("specBlue")
    var body: some View {
        NavigationStack {
            ZStack{
                specBlue.ignoresSafeArea(.all)
                VStack{
                    Text("End of Match")
                        .padding()
                        .bold()
                        .foregroundColor(Color("goofballPink"))
                        .monospaced()
                        .font(.title)
                    
                    HStack {
                        Spacer()
                        Text("Notes")
                            .foregroundColor(Color("gooberGray"))
                            .frame(width: 120)
                        Spacer()
                        Spacer()
                        Text("End of match")
                            .foregroundColor(Color("gooberGray"))
                            .frame(width: 120)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        VStack {
                            
                            TextEditor(text: $notes)
                                .frame(width: 300, height: 100)
                                .scrollContentBackground(.hidden)
                                .background(Color("gooberGray"), in: RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.black)
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
                                }.foregroundColor(.black).tint(.white).padding().buttonStyle(.borderedProminent)
                            }
                            
                            Spacer()
                        }.frame(height: 150)
                        
                        Spacer()
                    }
                    
                }
            }.foregroundColor(.white)
            .onAppear{
                notes = GameData.notes
            }.alert("Are you sure?", isPresented: $showingAlert) {
                Button("Yes") {
                    //John  Submit
                    
                    GameData.finalize()
                    GameDataArchive.uploadItem(index: GameDataArchive.gameList.count-1)
                    
                    
                    Flow.waterfall = true
                    dismiss()
                }
                
                Button("No", role: .cancel) { }
            }
        }
    }
}


struct Momylo: PreviewProvider {
    static var previews: some View {
        Mommylo()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
