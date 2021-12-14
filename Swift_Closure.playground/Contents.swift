import UIKit

var greeting = "클로저는 실행가능한 코드 블럭으로 함수와 다르게 이름정의는 필요하지 않지만, 매개변수 전달과 반환값이 있다는것이 공통점이며 함수는 이름있는 클로저"

//기본 클로저 문법
//{(매개변수 목록) -> 반환타입 in
//    실행코드
//}

let sum:(Int, Int) -> Int = { (a: Int, b: Int)in//sum이라는 상수에 closure할당 in키워드로 실행 코드와 분리함
    return a+b
}

let sumResult : Int = sum(1,2) //클로저는 주로 전달임자로 자주사용함 => 람다식, 익명함수
print(sumResult) // 3

let substract : (Int, Int) -> Int
substract = { (a : Int, b : Int)in
    return a-b
}
let divide : (Int, Int) -> Int
divide = { (a : Int, b : Int)in
    return a/b
}


func calculate(a: Int, b: Int, method : (Int, Int) -> Int) -> Int{
    return method(a,b)// 전달받은 메서드를반환
}

calculate(a: 10, b: 20, method: sum)// 전달인자에 클로저를 전달하여 활용 가능 => 10+20 = 30
calculate(a: 50, b: 10, method: divide) // 50 / 10 = 5
var calculated : Int

calculated = calculate(a: 50, b: 10, method: {(left : Int, right : Int) -> Int in // 함수를 호출할때 클로저를 작성하여 전달가능
                        return left*right
})

var result : Int

result = calculate(a: 10, b: 10) {(left : Int, right : Int) -> Int in// 10*10 = 500 후행클로저 -> 클로저가 함수의 마지막 전달인자일때
    return left * right
}

result = calculate(a: 10, b: 10, method: {(left : Int, right : Int) in // 반환타입 생략 -> int 타입을 반환할걸 알기에 생략가능
    return left * right // 100
})

result = calculate(a: 10, b: 10) {(left : Int, right : Int) in // 후행클로저에 반환타입을 생략
    return left * right
}

//###########################################
result = calculate(a: 10, b: 10, method: { // 클로저에 매개변수 이름을 따로 붙이지 않아도 됨
    return $0 + $1 // 단축인자는 0부터 매개변수 순서대로 0...1...2..3 순으로 표현함 => 20
})

result = calculate(a: 10, b: 10){ // 클로저에 반환하는 값이 있다면 암시적으로 마지막에 나온 구문을 반환함
    $0 + $1 // 20
}
//@@@@@@@@@@@@@@@@@@@@@@@@@@ 축약전과 축약후

result = calculate(a: 10, b: 10, method: {(left : Int, right : Int) -> Int in // 축약전
    return left + right
})
result = calculate(a: 10, b: 10) { $0 + $1 } // 축약후


//********************************************
//ex
//func completeWork(finished : Bool) -> () {
//    print("complete : \(finished)")
//}// 일반적인 메서드

let sample = {(finished : Bool) -> () in print("complete : \(finished)")}// 익명함수
//{(finished : Bool) in print("complete : \(finished)")} //컴파일러가 반환 타입을 미리 알고 있다면 반환타입을 생략가능함
//{(finished) in print("complete : \(finished)")} //매개변수의 파라미터 타입도 생략 가능
//{finnished in print("complete : \(finnished)")}//파라미터 타입이 생략된 경우 매개변수의 소괄호를 생략가능

sample(true)


