//
//  ContentView.swift
//  Ibermatica
//
//  Created by Victor Castro on 23/06/23.
//

import SwiftUI

struct Item {
    var title: String
    var description: String
}

struct ContentView: View {
    var body: some View {
        VStack {
            ItemListComponent()
        }.padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
