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
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(GameDataArchive.getListOfMatches(), id: \.self) {
                        i in
                        if i.a == -1 {
                            Text("Error")
                        } else if i.a == -2 {
                            Text("No data")
                        } else {
                            HStack {
                                Text(verbatim: "(\(GameDataArchive.gameList.count - i.a)) Team: \(i.b)")
                                Spacer()
                                Button {
                                    GameDataArchive.loadItem(index: i.a)
                                    dismiss()
                                } label: {
                                    Text("Load")
                                }
                            }
                        }
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        HStack {
                            Button {
                                displayPopup = true
                            } label: {
                                Text("Delete")
                                
                                if #available(iOS 16.0, *) {
                                    Image(systemName: "trash.fill").fontWeight(.semibold)
                                } else {
                                    Image(systemName: "trash.fill")
                                }
                            }
                        }
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
        }
    }
}



struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
