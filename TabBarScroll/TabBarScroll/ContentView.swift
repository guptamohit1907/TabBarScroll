//
//  ContentView.swift
//  TabBarScroll
//
//  Created by Mohit  on 23/04/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isScrolledUp : Bool = false
    @State private var storedOffset : CGFloat = 0
    @State private var scrollPhase : ScrollPhase = .idle
    @State private var tabBarVisibility : Visibility = .visible
    var body: some View {
        TabView{
            Tab.init("For You", systemImage : "heart.text.square.fill"){
                ScrollView(.vertical){
                    VStack(spacing : 12){
                        ForEach(1...50, id : \.self){ _ in
                            Rectangle()
                                .fill(.fill.tertiary)
                                .frame(height : 50)
                        }
                    }.padding(15)
                }.onScrollGeometryChange(for: CGFloat.self) {
                    $0.contentOffset.y + $0.contentInsets.top
                } action: { oldValue, newValue in
                    let isScrolledUp = oldValue < newValue
                    if  self.isScrolledUp != isScrolledUp{
                        // Storing content off set
                        storedOffset = newValue - (tabBarVisibility == .hidden ? 60 : 0)
                        self.isScrolledUp = isScrolledUp
                    }
                    let diff = newValue - storedOffset
                    if scrollPhase == .interacting{
                        tabBarVisibility = diff > 50 ? .hidden : .visible
                    }
                }
                .onScrollPhaseChange { oldPhase, newPhase in
                    scrollPhase = newPhase
                }
                .toolbarVisibility(tabBarVisibility, for: .tabBar)
                .animation(.smooth(duration: 0.3, extraBounce: 0), value: tabBarVisibility)
            }
            Tab.init("Products", systemImage : "macbook.and.iphone"){
                
            }
            Tab.init("More", systemImage : "safari"){
                
            }
            Tab.init("Bag", systemImage : "bag"){
                
            }
            Tab.init(role : .search){
                
            }
        }
        .tabViewBottomAccessory {
            Text("Welcome")
                .font(.caption)
                .multilineTextAlignment(.center)
        }.tabBarMinimizeBehavior(.onScrollDown)
    }
}

#Preview {
    ContentView()
}
