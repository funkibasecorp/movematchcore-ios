//
//  ExerciseCollectionsListView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct ExerciseCollectionsListView: View {
    @Binding var collections: [ExerciseCollection]
    
    var body: some View {
        List {
            ForEach(collections) { collection in
                NavigationLink(destination: CollectionItemsView(collection: collection)) {
                    ExerciseCollectionItemView(collection: collection)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
                            collections.remove(at: index)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .onMove { indices, newOffset in
                collections.move(fromOffsets: indices, toOffset: newOffset)
            }
        }
        .listStyle(.plain)
        .background(Color.white)
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    ExerciseCollectionsListView(collections: .constant(MockExerciseData.collections))
}
