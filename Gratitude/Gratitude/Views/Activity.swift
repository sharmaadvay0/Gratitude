//
//  Activity.swift
//  Gratitude
//
//  Created by William Wu on 4/10/21.
//

import SwiftUI
import SwiftUICharts

struct Activity: View {
    let moodData: [Double] = [0.0, 0.0, 0.0, 2.0, 2.2, 3.6, 4.4, 4.7, 3.1, 3.8, 4.0, 4.1, 4.8, 5.0, 4.7]
    let categoryData: [Double] = [1.0, 5.0, 4.0, 8.0, 6.0, 7.0]
    let numPosts: Int = 10
    let numFollowers: Int = 20
    let numFollowing: Int = 30
    
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Color(red: 255/255, green: 163/255, blue: 24/255), gradientColor: GradientColors.orange, textColor: Color(red: 130/255, green: 130/255, blue: 130/255), legendTextColor: Color.black, dropShadowColor: Color.black)
    
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
                        .padding(.top, 10)
                    Spacer()
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { geometry in
                            VStack {
                                BarChartView(
                                    data: ChartData(points: moodData),
                                    title: "Mood",
                                    legend: "Past month",
                                    style: chartStyle,
                                    form: CGSize(width: geometry.size.width, height: 180),
                                    dropShadow: false
                                )
                                    .padding(.top)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(white: 1.0, opacity: 1.0))
                                            .shadow(radius: 3)
                                            .padding(.top)
                                    )
                                
                                PieChartView(
                                    data: categoryData,
                                    title: "Categories",
                                    style: chartStyle,
                                    form: CGSize(width: geometry.size.width, height: 180),
                                    dropShadow: false
                                )
                                    .padding(.top)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color(white: 1.0, opacity: 1.0))
                                            .shadow(radius: 3)
                                            .padding(.top)
                                    )
                            }
                        }
                        .frame(height: 400)
                        
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
                                    Text("\(numPosts)")
                                        .font(.title)
                                        .fontWeight(.light)
                                        .foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255))
                                        .padding(.trailing, 20.0)
                                }
                                .padding(.top, 10.0)
                                
                                HStack {
                                    Text("Followers")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.leading, 20.0)
                                    Spacer()
                                    Text("\(numFollowers)")
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
                                    Text("\(numFollowing)")
                                        .font(.title)
                                        .fontWeight(.light)
                                        .foregroundColor(Color(red: 130/255, green: 130/255, blue: 130/255))
                                        .padding(.trailing, 20.0)
                                }
                                .padding([.top, .bottom], 10.0)
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct Activity_Previews: PreviewProvider {
    static var previews: some View {
        Activity()
    }
}
