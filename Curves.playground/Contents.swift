//: Playground - noun: a place where people can play

import Cocoa

var xPositionLinear = 0.0

for index in 1...320 {
    xPositionLinear += 1.0;
}


var xPositionSqrt = 0.0
for index in 1...320 {
    xPositionSqrt = sqrt(Double(index))
}

var xPositionLog10 = 0.0
for index in 1...320 {
    xPositionSqrt = log10(1 + Double(index))
}

var xPosition4sqrt = 0.0
var sum = 0.0
for index in 1...320 {
    sum += 1.0
    xPosition4sqrt = sum - pow(Double(index)/20, 2)
}
