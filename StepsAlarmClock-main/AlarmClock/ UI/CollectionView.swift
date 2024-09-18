//
//  Collection.swift
//  AlarmClock
//
//  Created by 平松蒼惟 on 2024/09/12.
//


struct CollectionView: View {
    var collectedItems: [String: Int] // Dictionary of collected items

    var body: some View {
        VStack {
            Text("Collected Items")
                .font(.title)
                .padding()

            List(collectedItems.sorted(by: { $0.key < $1.key }), id: \.key) { item, count in
                HStack {
                    Text(item)
                    Spacer()
                    Text("✖️\(count)") // Display count of each collected item
                }
            }
        }
        .navigationTitle("Collection")
        .padding()
    }
}
