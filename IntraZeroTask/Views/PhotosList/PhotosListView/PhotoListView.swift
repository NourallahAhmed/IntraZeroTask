//
//  PhotoListView.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import SwiftUI

struct PhotoListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    @Environment(\.managedObjectContext) var  managedObjectContext
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
