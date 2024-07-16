import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetails: View {
    var myObject: Result // Assuming `Result` is your object type
    @State private var textWidth: CGFloat = 50 // Initial width
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                WebImage(url: myObject.imageURL)
                                 .resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(height: geometry.size.height * 0.5)
                                 .cornerRadius(35)
                                 .padding(.bottom, 20)
                
                
                
                VStack(spacing: 20){
                    HStack(alignment: .top){
                        // title
                        VStack(alignment:.leading,spacing: 0){
                            Text(myObject.name ?? "").font(.system(size: 25, weight: .bold))
                            
                            HStack(spacing: 5){
                                Text("\(myObject.species ?? "-")").fontWeight(.semibold)
                                DotView(color: .secondary, size: 5)
                                
                                Text(myObject.gender ?? "").fontWeight(.regular).foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        
                        // Status
                        Text(myObject.status ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .cornerRadius(30).background(
                                Color(hexString: "61CBF4")
                                    .frame(width: textWidth + 20, height: 30) // Adjust width with padding
                                    .cornerRadius(30)
                            )
                            .overlay(
                                GeometryReader { geometry in
                                    Color.clear.onAppear {
                                        self.textWidth = geometry.size.width
                                    }
                                }
                            )
                        
                        
                        
                    }

                    HStack {
                                       Text("Location:")
                                           .font(.system(size: 20, weight: .medium))
                   
                                       Text(myObject.location?.name ?? "")
                                           .font(.system(size: 20))
                   
                                       Spacer()
                                   }

                }.padding(.horizontal, 20)
                
                // Adju
                //                WebImage(url: myObject.imageURL)
                //                    .resizable()
                //                    .aspectRatio(contentMode: .fill)
                //                    .frame(height: geometry.size.height * 0.5)
                //                    .cornerRadius(35)
                //                    .padding(.bottom, 20)
                
                //                VStack(alignment: .trailing, spacing: 0) {
                //                    Text("Zphlyr")
                //                        .font(.system(size: 25, weight: .bold))
                //
                
                //                        HStack(spacing: 5) {
                //                            Text(myObject.species ?? "")
                //                                .font(.system(size: 20))
                //                                .foregroundColor(.black)
                //
                //                            Text(myObject.gender ?? "")
                //                                .font(.system(size: 20))
                //                                .foregroundColor(.gray)
                //                        }
                //                    }.padding(.trailing,0)
                //                HStack {
                //                    Text("Location:")
                //                        .font(.system(size: 20, weight: .bold))
                //
                //                    Text(myObject.location?.name ?? "")
                //                        .font(.system(size: 20))
                //
                //                    Spacer()
                //                }
                //                .padding(.horizontal)
                //                .padding(.top, 20)
            }
            
            .edgesIgnoringSafeArea(.all)
            
            
        }
    }
}


struct CharacterDetails_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetails(myObject: Result(name: "Example Character")) // Replace with actual `Result` object initialization
    }
}





struct DotView: View {
    var color: Color
    var size: CGFloat
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
    }
}


