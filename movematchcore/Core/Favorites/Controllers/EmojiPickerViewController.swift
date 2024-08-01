//
//  EmojiPickerViewController.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI
import ElegantEmojiPicker

struct EmojiPickerViewController: UIViewControllerRepresentable {
    @Binding var selectedEmoji: String

    func makeUIViewController(context: Context) -> ElegantEmojiPicker {
        let config = ElegantConfiguration(showSearch: true, showRandom: false, showReset: true, showClose: true)
        let picker = ElegantEmojiPicker(delegate: context.coordinator, configuration: config)
        return picker
    }

    func updateUIViewController(_ uiViewController: ElegantEmojiPicker, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, ElegantEmojiPickerDelegate {
        var parent: EmojiPickerViewController

        init(_ parent: EmojiPickerViewController) {
            self.parent = parent
        }

        func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
            guard let emoji = emoji else { return }
            parent.selectedEmoji = emoji.emoji
        }
    }
}
