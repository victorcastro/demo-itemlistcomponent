//
//  ItemListComponent.swift
//  Ibermatica
//
//  Created by Victor Castro on 23/06/23.
//

import SwiftUI

struct ItemListComponent: View {
    
    @State private var items: [Item] = []
    @State private var newItemTitle = ""
    @State private var newItemDescription = ""
    @State private var isInputInvalid = false
    @State private var isEditing = false
    @State private var editedItemIndex = 0
    @State private var editedItemTitle = ""
    @State private var editedItemDescription = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(items.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(items[index].title)
                                .font(.headline)
                            Text(items[index].description)
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(action: {
                            startEditingItem(at: index)
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
            
            if isEditing {
                VStack {
                    HStack(spacing: 10) {
                        Text("Title:").font(.headline)
                        TextField("Title", text: $editedItemTitle)
                    }
                    HStack(spacing: 10) {
                        Text("Description:").font(.headline)
                        TextField("Description", text: $editedItemDescription)
                    }
                    HStack {
                        Button(action: cancelEditing) {
                            Text("Cancel")
                        }.buttonStyle(.plain)
                        Button(action: saveChanges) {
                            Text("Save")
                        }.buttonStyle(.borderedProminent)
                            .disabled(isInputInvalid)
                    }
                }
                .padding()
            } else {
                HStack {
                    TextField("Title", text: $newItemTitle)
                    TextField("Description", text: $newItemDescription)
                    Button(action: addItem) {
                        Text("Add Item")
                    }
                    .buttonStyle(.bordered)
                    .disabled(isInputInvalid)
                }
                .padding()
            }
        }
        .alert(isPresented: $isInputInvalid) {
            Alert(title: Text("Fields are empty"), message: Text("Please enter title and description before to addItem."), dismissButton: .default(Text("Got it")))
        }
    }
    
    func startEditingItem(at index: Int) {
        editedItemIndex = index
        editedItemTitle = items[index].title
        editedItemDescription = items[index].description
        isEditing = true
    }
    
    func saveChanges() {
        guard !editedItemTitle.isEmpty, !editedItemDescription.isEmpty else {
            isInputInvalid = true
            return
        }
        
        items[editedItemIndex].title = editedItemTitle
        items[editedItemIndex].description = editedItemDescription
        isEditing = false
    }
    
    func cancelEditing() {
        isEditing = false
    }
    
    func addItem() {
        let newItem = Item(title: newItemTitle, description: newItemDescription)
        validateInput()
        if !isInputInvalid {
            items.append(newItem)
            resetStatesInputs()
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func validateInput() {
        isInputInvalid = newItemTitle.isEmpty || newItemDescription.isEmpty
    }
    
    func resetStatesInputs() {
        newItemTitle = ""
        newItemDescription = ""
    }
}

struct ItemListComponent_Previews: PreviewProvider {
    static var previews: some View {
        ItemListComponent()
    }
}
