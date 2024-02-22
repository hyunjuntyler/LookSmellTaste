//
//  AddCoffeeNoteView.swift
//  LookSmellTaste
//
//  Created by Hyunjun Kim on 12/9/23.
//

import SwiftUI

struct AddCoffeeNoteView: View {
    @Bindable private var observable = CoffeeNoteObservable.shared
    @State private var showDatePicker = false
    @State private var showTypePicker = false
    @FocusState private var isFocused
    
    @State private var name = ""
    @State private var date = Date()
    @State private var type: CoffeeType = coffeeTypes[0]
    @State private var image: UIImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("커피 이름")
                .font(.gmarketSansSubHeadline)
                .foregroundStyle(.gray)
                .padding(.leading)
                .padding(.top, 5)
            HStack {
                TextField("커피 이름을 입력해주세요", text: $name, axis: .vertical)
                    .font(.gmarketSansBody)
                    .focused($isFocused)
                    .tint(.accent)
                    .onTapGesture {
                        Haptic.impact(style: .soft)
                    }
                Button {
                    Haptic.impact(style: .soft)
                    name = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray, .appPickerGray)
                        .font(.title3)
                }
                .buttonStyle(PressButtonStyle())
                .opacity(name.isEmpty ? 0 : 1)
            }
            .padding()
            .frame(height: 60)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundStyle(.appSheetBoxBackground)
            }
            
            Text("마신 날짜")
                .font(.gmarketSansSubHeadline)
                .foregroundStyle(.gray)
                .padding(.leading)
                .padding(.top, 5)
            HStack {
                Text("\(date.formatted(date: .complete, time: .omitted))")
                    .font(.gmarketSansBody)
                    .onChange(of: date) { _, _ in
                        Haptic.impact(style: .soft)
                    }
                Spacer()
                Button {
                    isFocused = false
                    showDatePicker = true
                    Haptic.impact(style: .soft)
                } label: {
                    Text("바꾸기")
                        .font(.gmarketSansFootnote)
                        .foregroundStyle(.gray)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .foregroundStyle(.appPickerGray)
                        }
                }
                .buttonStyle(PressButtonStyle())
            }
            .padding(.leading, 10)
            .padding(8)
            .frame(height: 60)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundStyle(.appSheetBoxBackground)
            }
            
            Text("커피 종류")
                .font(.gmarketSansSubHeadline)
                .foregroundStyle(.gray)
                .padding(.leading)
                .padding(.top, 5)
            HStack {
                Image(type.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                Text(LocalizedStringKey(type.name))
                    .font(.gmarketSansBody)
                Spacer()
                Button {
                    isFocused = false
                    showTypePicker = true
                    Haptic.impact(style: .soft)
                } label: {
                    Text("바꾸기")
                        .font(.gmarketSansFootnote)
                        .foregroundStyle(.gray)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .foregroundStyle(.appPickerGray)
                        }
                }
                .buttonStyle(PressButtonStyle())
            }
            .padding(8)
            .frame(height: 60)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .foregroundStyle(.appSheetBoxBackground)
            }
            
            Text("대표 이미지")
                .font(.gmarketSansSubHeadline)
                .foregroundStyle(.gray)
                .padding(.leading)
                .padding(.top, 5)
            ImagePicker(selectedImage: $image, defaultImageName: type.imageName)
                .padding(.bottom)
        }
        .padding(.horizontal)
        .sheet(isPresented: $showDatePicker) {
            VStack {
                Text("마신 날짜 변경")
                    .font(.gmarketSansTitle3)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        SheetCloseButton {
                            showDatePicker = false
                        }
                    }
                DatePicker("마신 날짜", selection: $date, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(.accent)
                    .onChange(of: date) { _, _ in
                        showDatePicker = false
                    }
                    .padding()
            }
            .padding(.top, 24)
            .presentationDetents([.medium])
            .presentationCornerRadius(24)
        }
        .sheet(isPresented: $showTypePicker) {
            VStack {
                Text("커피 종류 변경")
                    .font(.gmarketSansTitle3)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        SheetCloseButton {
                            showTypePicker = false
                        }
                    }
                ScrollView {
                    ForEach(coffeeTypes) { coffee in
                        Button {
                            type = coffee
                            Haptic.impact(style: .soft)
                            showTypePicker = false
                        } label: {
                            HStack {
                                Image(coffee.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                Text(LocalizedStringKey(coffee.name))
                                    .font(.gmarketSansBody)
                            }
                        }
                        .buttonStyle(TypeButtonStyle())
                    }
                }
            }
            .padding(.top, 24)
            .presentationDetents([.height(300)])
            .presentationCornerRadius(24)
        }
        .onTapGesture {
            isFocused = false
        }
        .onAppear {
            observable.reset()
        }
        .onDisappear {
            observable.name = name
            observable.date = date
            observable.type = type
            if let image = image {
                observable.image = image.jpegData(compressionQuality: 0.1)
            }
        }
    }
}

#Preview("Korean") {
    AddNoteView()
        .environment(NoteEnvironment())
        .environment(\.locale, .init(identifier: "ko"))
}

#Preview("English") {
    AddNoteView()
        .environment(NoteEnvironment())
        .environment(\.locale, .init(identifier: "en"))
}
