//
//  ContentView.swift
//  SwiftBullsEye
//
//  Created by Sergio Barrera on 6/27/20.
//  Copyright © 2020 Sergio Barrera. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    create a state var to save the alert data
    @State var alertIsVisible: Bool = false
    //create a state var to set the  slider value
    @State var sliderValue: Double = 50.0
    
    @State var target: Int = Int.random(in: 1...100)
    @State var score = 0
    
    var body: some View {
        VStack {
            //vstack will have 3 nested hstacks
            //target row
            Spacer()
            HStack {
                Text("Put the bulls eye as close as you can to:")
                Text("\(self.target)")
            }
            Spacer()
            //slider row
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            
            //button row
            Button(action: {
//                print("Button pressed")
                self.alertIsVisible = true
               
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me"/*@END_MENU_TOKEN@*/)
            }
            
            .alert(isPresented: $alertIsVisible){ () ->
                Alert in
                let roundedValue: Int = Int(self.sliderValue.rounded()) //cast the double as int type
                return Alert(title: Text("Hello player!"), message: Text("Slider's value \(roundedValue) \n You made \(self.pointsForCurrentRound()) points"), dismissButton: .default(Text("Done")) {
                    //will do the calulation here
                        //print("dismissed...")
                        self.score = self.score + self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                    })
            }
            
            Spacer()
            //Score row
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("\(self.score)")
                Spacer()
                Text("Round")
                Text("999")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
                .padding(.bottom, 20)
            }
            
        }
    }
    
    //my own method
    func pointsForCurrentRound() -> Int {
        var difference: Int
        //due to type inference, i can get rid of the type
        let roundedValue = Int(self.sliderValue.rounded()) //it's the sliders reading
        
        //logic 1
        /*if self.target > roundedValue{
            difference = self.target - roundedValue
        } else if roundedValue > self.target{
            difference = roundedValue - self.target
        }else{
            difference = 0
        }
         */
        
        //logic 2
        //dif = target-slidervalue, if comes out negative multiply result by -1
        //difference = self.target - roundedValue
//        if difference < 0 {
//            difference *= -1
//        }
        
        //logic 3 - use abs
        difference = abs(self.target) - roundedValue
        
        let awardedPoints = 100 - difference
        return awardedPoints
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 812, height: 375))
    }
}
