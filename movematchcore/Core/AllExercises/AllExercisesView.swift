//
//  AllExercisesView.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-16.
//

import SwiftUI


struct SearchFieldStyle: TextFieldStyle {
    var icon: String = "search_icon"
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(alignment: .center, spacing: 0) {
            if !icon.isEmpty {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()                    .frame(width: 16)
                    .padding(.trailing, 8)
            }

            configuration

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
        .cornerRadius(8)
    }
}

enum ImageType {
    case web(link: String = "https://picsum.photos/200")
    case asset(name: String = "placeholder_mountains")
}

struct ImageView: View {
    let type: ImageType

    var body: some View {
        Group {
            switch type {
            case .web(let link):
                AsyncImage(
                    url: URL(string: link),
                    content: { image in
                        image
                            .resizable()
                    }, placeholder: {
                        Color.gray.overlay(ProgressView())
                    }
                )
            case .asset(let name):
                Image(name)
                    .resizable()
            }
        }
    }
}


struct LongCardView: View {
    let image: ImageType
    let title: String
    let subTitle: String
    let icon: String
    var onIconTap: () -> Void = {}

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ImageView(type: image)
                .scaledToFill()
                .frame(width: 64, height: 64)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)

                Text(subTitle)
            }

            Spacer(minLength: 0)

            Button(action: onIconTap, label: {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
            })
        }
        .padding([.vertical, .leading], 8)
        .padding(.trailing, 20)
        .cornerRadius(8)
    }
}



struct AllExercisesView: View {
    @StateObject var vm = AllExercisesVM()

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .center, spacing: 16) {
                NavBar(title: "All Exercises") {}
                    .padding(.horizontal, 16)

                VStack(alignment: .center, spacing: 24) {
                    TextField("Search something", text: $vm.searchText)
                        .textFieldStyle(SearchFieldStyle())
                        .padding(.horizontal, 16)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 16) {
                            ForEach(vm.categories, id: \.self) { category in
                                Button(category) {
                                    vm.activeCategory = category
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.bottom, 8)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 16) {
                    ForEach(vm.exercises, id: \.id) { exercise in
                        LongCardView(
                            image: .web(link: exercise.image),
                            title: exercise.name,
                            subTitle: exercise.time,
                            icon: "i_icon"
                        )
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 24)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
        AllExercisesView()
//            .environmentObject(ThemeManager.shared)
}
