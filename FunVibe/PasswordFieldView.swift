import SwiftUI

struct PasswordField: View {
    
    let icon: String
    let title: String
    let placeholder: String
    @Binding var text: String
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            Text(title)
                .font(.title)
            
            ZStack(alignment: .trailing) {
                
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .font(.title)
                .padding(.trailing, 40)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.orange, lineWidth: 2)
                )
                .cornerRadius(20)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing, 12)
                }
            }
        }
    }
}
