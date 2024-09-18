import SwiftUI

struct SetTimeView: View {
    @Binding var myTimer: Date
    @Environment(\.dismiss) private var dismiss
    @State private var settingTime = Date()
    
    private let calendar = Calendar.current
    
    
    var body: some View {
        NavigationStack {
            DatePicker("",
                    selection: $settingTime,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
            .navigationTitle("setting")
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("キャンセル")
                            .foregroundColor(Color("brown"))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        myTimer = settingTime
                        dismiss()
                    } label: {
                        Text("保存")
                            .foregroundColor(Color("brown"))
                    }
                    .padding()
                }
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    @State var a = Date()
    return SetTimeView(myTimer: $a)
}
