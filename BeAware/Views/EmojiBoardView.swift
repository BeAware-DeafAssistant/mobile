//
//  SpeechView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/7/22.
//
import SwiftUI

struct EmojiBoardView : View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var uiImage: UIImage?
    @State private var image: Image?
    @AppStorage("SelectedEmoji") var selectedEmoji = "🙂"
    @State var data = ["✈️","🍽","🏥","⏰","☕️","🎵","💦","🧻","☀️","📷","🚌","☎️","🏠","🌙","🔋","💵"]
    @State var images: [AddedImage?] = []
    @State var imageHere: Image?
    let columns = [
        GridItem(.adaptive(minimum: 75))
    ]
    init(){
    // These don't have any effect
        //UIToolbar.appearance().backgroundColor =        UIColor(named: "BrandColor")
//        UIToolbar.appearance().barTintColor = UIColor(named: "BrandColor")
    }
    var body : some View {
        
        NavigationView{
            ZStack{
                Color("BrandColor")
                
                ScrollView{
                    VStack {
                        Text(selectedEmoji)
                            .font(.custom("Avenir", size: 128))
                            .padding()
                        Text("Select an emoji from the list to display above")
                            .foregroundColor(Color("SecondaryColor"))
                            .font(.custom("Avenir", size: 17))
                            .accessibilityLabel("Add")
                            .accessibilityHint("Adds images that you can show")
                            .padding()
                        HStack{
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(data, id: \.self) { item in
                                        Text(item).font(Font.custom("Avenir", size: 44))
                                            .onTapGesture {
                                                selectedEmoji = item
                                            }
                                    }
                                }
                            }
                            Text("\(Image(systemName: "chevron.right"))").foregroundColor(Color("SecondaryColor"))
                        }.padding([.top, .leading, .bottom])
                        Button(
                            action: {
                                showingImagePicker = true
                            }
                        ){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).frame(width: 200, height: 40).foregroundColor(Color("SecondaryColor")).shadow(color: .black, radius: 5, x: 0, y: 4)
                                Text("ADD IMAGE").foregroundColor(Color("BrandColor"))
                                    .font(.custom("Avenir", size: 17))
                                    .accessibilityLabel("Add")
                                    .accessibilityHint("Adds images that you can show")
                            }
                        }
                        Spacer ()
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach(images, id: \.self) { item in
                                ZStack{
                                    Circle()
                                        .foregroundColor(Color("SecondaryColor"))
                                        .frame(width:70, height:70)
                                        .shadow(color: .black, radius: 2, x: 0, y: 4)
                                    Image(uiImage: item!.image)
                                        .resizable()
                                        .frame(width:70.0, height:70)
                                        .cornerRadius(35)
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("EMOJI BOARD")
                .navigationBarTitleTextColor(Color("SecondaryColor"))
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(
                            destination: SettingsView()
                        ) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(Color("SecondaryColor"))
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
        
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        print(inputImage)
        image = Image(uiImage: inputImage)
        uiImage = inputImage
        images.append(AddedImage(image: inputImage))
    }
}
struct EmojiBoardView_Previews : PreviewProvider {
    static var previews: some View {
        EmojiBoardView()
    }
}
