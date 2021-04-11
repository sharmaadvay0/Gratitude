//
//  Activity.swift
//  Gratitude
//
//  Created by William Wu on 4/10/21.
//

import SwiftUI
import SwiftUICharts

struct Activity: View {
    
    @ObservedObject var graphNetworking = GraphNetworking()
    @ObservedObject var network = Networking()
    
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Color(red: 219/255, green: 94/255, blue: 92/255), gradientColor: GradientColor(start: Color(red: 168/255, green: 62/255, blue: 102/255), end: Color(red: 219/255, green: 94/255, blue: 92/255)), textColor: Color(red: 130/255, green: 130/255, blue: 130/255), legendTextColor: Color.black, dropShadowColor: Color.black)
    
    var body: some View {
        ZStack {
            Color(red: 255 / 255, green: 246 / 255, blue: 225 / 255)
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .top) {
                    Text("Activity")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                        .padding(.top, 20)
                    Spacer()
                }.padding(.bottom)
                if self.network.totalChange < -0.1 {
                    Text("Try making a post about what you are grateful for to improve your mood!")
                        .multilineTextAlignment(.center)
                } else if self.network.totalChange >= -0.1 && self.network.totalChange <= 0.1 {
                    Text("You are on the right track! Try writing about what you are grateful for to improve your mood!").multilineTextAlignment(.center)
                } else {
                    Text("Good job! Your mood has improved significantly over time.").multilineTextAlignment(.center)
                }
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { geometry in
                            VStack {
                                
                                LineView(
                                    data: self.graphNetworking.moodArray,
                                    title: "Mood",
                                    legend: "Past month",
                                    style: chartStyle
                                )
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(white: 1.0, opacity: 1.0))
                                            .shadow(radius: 3)
                                            .padding(.top)
                                            .padding(.bottom, -10)
                                    )
                                
                                BarChartView(
                                    data: ChartData(values: self.graphNetworking.category),
                                    title: "Categories",
                                    style: chartStyle,
                                    form: CGSize(width: geometry.size.width, height: 180),
                                    dropShadow: false
                                )
                                    .padding(.top)
                                .padding(.bottom, -10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(white: 1.0, opacity: 1.0))
                                            .shadow(radius: 3)
                                            .padding(.top)
                                            .padding(.bottom, -10)
                                            
                                    )
                            }
                        }
                        .frame(height: 620)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(radius: 3)
                            VStack {
                                HStack {
                                    Text("Posts")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.leading, 20.0)
                                    Spacer()
                                    Text(String(self.network.userPosts.count))
                                        .font(.title)
                                        .fontWeight(.light)
                                        .foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255))
                                        .padding(.trailing, 20.0)
                                }
                                .padding(.top, 10.0)
                                
                                HStack {
                                    Text("Following")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.leading, 20.0)
                                    Spacer()
                                    Text(String(self.network.user.following.count))
                                        .font(.title)
                                        .fontWeight(.light)
                                        .foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255))
                                        .padding(.trailing, 20.0)
                                }
                                .padding([.top, .bottom], 10.0)
                            }
                        }
                        .padding(.top)
                        .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
            }
        }.onAppear {
            self.graphNetworking.fetchGraphData(username: "justinyaodu")
            self.network.fetchUserFeed(username: "justinyaodu")
            self.network.fetchUser(username: "justinyaodu")
        }
    }
}

struct Activity_Previews: PreviewProvider {
    static var previews: some View {
        Activity()
    }
}
