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
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(list, id: \.self) {
                        i in
                        if i.a == -1 {
                            Text("Error")
                        } else if i.a == -2 {
                            Text("No data")
                        } else {
                            HStack {
                                Text(verbatim: "(\(GameDataArchive.gameList.count - i.a)) Team: \(i.b)").padding()
                                
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
                    }

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
