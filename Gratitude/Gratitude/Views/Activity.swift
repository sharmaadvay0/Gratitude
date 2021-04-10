//
//  Activity.swift
//  Gratitude
//
//  Created by Bill Wu on 4/10/21.
//

import SwiftUI
import SwiftUICharts

struct Activity: View {
    let moodData = [0.0, 0.0, 0.0, 2.0, 2.2, 3.6, 4.4, 4.7, 3.1, 3.8, 4.0, 4.1, 4.8, 5.0, 4.7]
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Color(red: 255/255, green: 163/255, blue: 24/255), gradientColor: GradientColors.orange, textColor: Color(red: 130/255, green: 130/255, blue: 130/255), legendTextColor: Color.black, dropShadowColor: Color.black)
    
    var body: some View {
        ZStack {
            Color(red: 255 / 255, green: 246 / 255, blue: 225 / 255)
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .top) {
                    Text("Make a post")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .padding(.leading)
                        .padding(.top, 10)
                    Spacer()
                }
                .padding([.top, .trailing], 25)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        BarChartView(data: ChartData(points: moodData), title: "Mood", legend: "Past month", style: chartStyle, form: ChartForm.extraLarge, dropShadow: false)
                    }
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
