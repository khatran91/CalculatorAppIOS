//
//  ContentView.swift
//  Calculator
//
//  Created by kha tran on 5/23/22.
//

import SwiftUI

// for all the buttons in the display
enum CalButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case percentage = "%"
    case plus = "+"
    case minus = "-"
    case division = "/"
    case multiplication = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case posneg = "+/-"
    
    var buttonColor: Color { //variable for all the colors with specific buttons
        switch self {
        case .division, .multiplication, .minus, .plus, .equal:
            return .orange
        case .clear, .posneg, .percentage:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1)) //dark gray color
        }
    }
}
enum Operation {
    case plus, minus, multiplication, division, none
}
struct ContentView: View {
    @State var value = "0" //set the default value as 0
    // State helps to control with changeable value
    @State var currentNum = 0
    @State var currentOperation: Operation = .none //none taken from the Operation so the default value of operation = none
    
    let buttons: [[CalButton]] = [ //All the buttons in order
        [.clear, .posneg, .percentage, .division],
        [.seven, .eight, .nine, .multiplication],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all) //background color, ignore safe area to cover top and bottom area
            VStack  { //Vertical
                Spacer() //remove bottom space
                HStack { // Horizon)tal
                // Display Text
                    Spacer() // move text to the side
                    Text (value) //default value 0
                        .bold()
                        .font(.system(size: 85))
                        .foregroundColor(.white)
                }
                // Display button
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12) {
                        // spacing 12 to add space horizontally
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.Tap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .bold()
                                    .font(.system(size: 40))
                                    .frame (
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor) //call the variable buttonColor
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2) // self button width divide by 2 so the circle look more rounded
                            })
                        }
                    }
                }
            }.padding(.bottom) //give vertical space

        }
    }
    func Tap (button: CalButton) {
        switch button {
        case .minus, .plus, .multiplication, .division, .equal:
            if button == .plus {
                self.currentOperation = .plus // set the operation once the button is tapped
                self.currentNum = Int(self.value) ?? 0 //value on self is a string, it will return optional
            }
            else if button == .minus {
                self.currentOperation = .minus
                self.currentNum = Int(self.value) ?? 0
            }
            else if button == .division {
                self.currentOperation = .division
                self.currentNum = Int(self.value) ?? 0
            }
            else if button == .multiplication {
                self.currentOperation = .multiplication
                self.currentNum = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.currentNum
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .plus: self.value = "\(runningValue + currentValue)"
                case .minus: self.value = "\(runningValue - currentValue)"
                case .division: self.value = "\(runningValue / currentValue)"
                case .multiplication: self.value = "\(runningValue * currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0" //if user tap AC it will return 0 as the default value
        case .decimal, .posneg, .percentage:
            break
        default:
            let number = button.rawValue //show the number as the user taps
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    func buttonWidth(item: CalButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
            //set 0 as twice the size of the other numbers
            // 4 instead of 5 for the row and divide by 4 (column) multiply by 2 for twice the size
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
        // 5 represents 5 space in between buttons vertically
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
