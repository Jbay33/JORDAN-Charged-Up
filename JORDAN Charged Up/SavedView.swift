//
//  SavedView.swift
//  JORDAN Charged Up
//
//  Created by Milo Woodman on 1/20/23.
//

import Foundation
import SwiftUI

struct SavedView: View {
    @Environment(\.dismiss) var dismiss
    @State var displayPopup = false
    @State var list = GameDataArchive.getListOfMatches()
    let specBlue = Color("specBlue")
    
    var body: some View {
        NavigationStack {
            ZStack {
                specBlue.ignoresSafeArea(.all).zIndex(-1)
                VStack {
                    List {
                        ForEach(list, id: \.self) {
                            i in
                            if i.a == -1 {
                                Text("Error")
                                    .foregroundColor(Color("gooberGray"))
                            } else if i.a == -2 {
                                Text("No data")
                                    .foregroundColor(Color("gooberGray"))
                            } else {
                                HStack {
                                    Text(verbatim: "(\(i.c)) Team: \(i.b)")
                                        .foregroundColor(Color("gooberGray"))
                                        .padding()
                                    
                                    Spacer()
                                    
                                    Button {
                                        GameDataArchive.uploadItem(index: i.a)
                                        print("Upload")
                                        list = GameDataArchive.getListOfMatches()
                                        dismiss()
                                    } label: {
                                        Text("Upload")
                                    }.buttonStyle(.bordered).padding()
                                    
                                    Button {
                                        GameDataArchive.deleteAt(index: i.a)
                                        print("Delete")
                                        list = GameDataArchive.getListOfMatches()
                                        dismiss()
                                    } label: {
                                        Text("Delete")
                                    }.buttonStyle(.bordered).padding()
                                    
                                    
                                    Button {
                                        GameDataArchive.loadItem(index: i.a)
                                        print("Load")
                                        list = GameDataArchive.getListOfMatches()
                                        dismiss()
                                    } label: {
                                        Text("Load")
                                    }.buttonStyle(.bordered).padding()
                                    
                                }
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.05))
                    }.scrollContentBackground(Visibility.hidden)
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            displayPopup = true
                        } label: {
                            Text("Clear All")
                            
                            if #available(iOS 16.0, *) {
                                Image(systemName: "trash.fill").fontWeight(.semibold)
                            } else {
                                Image(systemName: "trash.fill")
                            }
                        }.disabled(!(GameDataArchive.gameList.count > 0))
                            .opacity((GameDataArchive.gameList.count > 0) ? 1 : 0.5)
                    }.foregroundColor(.white)

                }
            }.alert("Are you sure?", isPresented: $displayPopup) {
                Button {
                    GameDataArchive.clearArchive()
                    displayPopup = false
                    dismiss()
                } label: {
                    Text("Ok")
                }
                Button {
                    displayPopup = false
                } label: {
                    Text("Cancel")
                }
            }
            .onAppear {
                list = GameDataArchive.getListOfMatches()
            }
        }
    }
}



struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
