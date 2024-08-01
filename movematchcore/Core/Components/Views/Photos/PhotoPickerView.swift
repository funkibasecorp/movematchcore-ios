//
//  PhotoPickerView.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/24/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView<Label: View>: View {

    // MARK: Data
    @Binding var selectedImages: [UIImage]
    @State private var selection: [PhotosPickerItem] = []
    @State private var photoLoadingTask: Task<Void,Error>? = nil
    
    // MARK: UI
    @ViewBuilder var label: () -> Label
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        PhotosPicker(
            selection: $selection,
            maxSelectionCount: 9,
            matching: .images
        ) {
            label()
        }
        .onChange(of: selection) {
            photoLoadingTask?.cancel()
            photoLoadingTask = Task {
                selectedImages.removeAll()
                
                for item in selection {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            await MainActor.run {
                                selectedImages.append(uiImage)
                            }
                        }
                    }
                }
            }
        }
    }
}
//#Preview {
//    PhotoPickerView()
//}
