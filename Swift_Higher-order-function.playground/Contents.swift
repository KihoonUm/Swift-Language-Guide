import UIKit

var greeting = "고차 함수는 '다른 함수를 전달인자로 받거나 함수실행의 결과를 함수로 반환하는 함수를 뜻함"

//스위프트 표준라이브러리에 있는 map, filter, reduce
//map 메소드는 제공된 클로저를 각 행렬 항목마다 적용한 후, 새롭게 매핑된 값들이 원래 행렬의 해당 값들의 순서와 같도록 배치된 새 행렬을 반환함
let numbers : [Int] = [0, 1, 2, 3, 4]
var doubleNumbers : [Int]
var strings : [String]

doubleNumbers = [Int]()
strings = [String]()

for num in numbers {
    doubleNumbers.append(num * 2)
    strings.append(String(num))
}
print(doubleNumbers)
print(strings)

doubleNumbers = numbers.map({ (num : Int) -> Int in
    return num * 2
})

strings = numbers.map({(num : Int) -> String in
    return String(num)
})
print(doubleNumbers)
print(strings)

doubleNumbers = numbers.map{$0 * 3} // 클로저를 통해서 매개변수, 반환 타입, 반환키워드를 생략한 후행클로저로 표현가능
print(doubleNumbers)

//#################
// filter함수는 컨테이너 내부의 값을 걸러서 새로운 컨테이너를 추출함
// 기존의 컨테이너에서 내부의 값을 걸러 새로운 컨테이너를 만듦


var filtered : [Int] = [Int]()

for num in numbers{ // 기존 for문으로 홀수구하기
    if num % 2 != 0 {
        filtered.append(num)
    }
}
print(filtered)

let oddNumbers : [Int] = numbers.filter { (numbers:Int) -> Bool in
    return numbers % 2 != 0
}
print(filtered)

let oddNumbers2 : [Int] = numbers.filter {
    $0 % 2 != 0
}

print(oddNumbers2)

// #########################
// reduce힘수는 컨테이너 내부의 콘텐츠를 하나로 통합함
let someNumbers : [Int] = [2,8,20]

var  result = 0

for num in someNumbers {
    result += num
}

print(result)

let sum : Int = someNumbers.reduce(0, {(first : Int, second : Int) -> Int in // 초기값이 0 이고 someNumbers의 내부값을 모두더함
    print("reduce sum\(first) + \(second)") // 초기값 + $0 = sum -> sum + $1 = sum -> sum += &2 ...
    return first + second
})
print(sum)

let subtract = someNumbers.reduce(0, {(first : Int, second : Int) -> Int in // 초기값이 0 이고 someNumbers의 내부값을 모두뺌
    return first - second
})
print(subtract)

let sumFromThree = someNumbers.reduce(3, {$0 + $1})
print(sumFromThree)


//
var doubledNumbers: [Int] = numbers.map  {
  $0 * 2 // $0 에 배열의 0부터 마지막까지 들어감
}
let evenNumbers2: [Int] = numbers.filter {
  $0.isMultiple(of: 2)// $0 에 배열의 0부터 마지막까지 들어감 // isMultiple 함수 of로 나눈 나머지값이 0이 되는 수를 반환
}
