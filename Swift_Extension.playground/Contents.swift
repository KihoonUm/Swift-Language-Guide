import UIKit

var greeting = "Extension 익스텐션은 기능을 추가하려는 타입의 구현된 소스 코드를 알지 못하거나 볼 수 없다 해도, 타입만 알고 있다면 그 타입의 기능을 확장할 수도 있음 -> 기능확장의 개념으로 상속과 다르게 구조체, 클래스, 프로토콜 등에 적용이 가능함"


extension Int{ // 기존에 있던 Int(Struct타입)에 extension을 이용해 확장
    var isEven : Bool{ // 짝수이면 트루 홀수이면 펄스 (연산프로퍼티) => Bool타입으로 반환
     return self % 2 == 0 // Int값이 짝수이면 => 반환값은 True
    }
    var isOdd : Bool { // 홀수이면 트루 짝수이면 펄스
        return self % 2 == 1
    }
}
print(1.isEven) //추가된 연산프로퍼티 => false
print(2.isEven) // true
print(1.isOdd)
print(2.isOdd)

var number : Int = 3
print(number.isEven)
print(number.isOdd)

number = 2
print(number.isEven)
print(number.isOdd)

//메서드 추가

extension Int{
    func multyply(by n : Int) -> Int { // -> 인자레벨 사용 함수내부에서는 n으로 사용 외부 전달인자에선 by
        return self*n
    }
}
print(3.multyply(by: 2)) // 6
print(4.multyply(by: 5)) // 20

// 이니셜라이저 추가

extension String {
    init(int : Int) {
        self = "\(int)"
    }
    init(double : Double) {
        self = "\(double)"
    }
}

let stringFromInt:String = String(int: 100)
let stirngFromDouble : String = String(double: 100.0)

// extension 타입에 기능을 추가하는 덧 붙임

extension Int{ // Int에 enum 타입을 추가한 예제 -> Int를 0, 양수, 음수로 표현
    enum Kind {
        case negative, zero, positive
    }
    var kind : Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers : [Int]){
    for number in numbers {
        switch number.kind {
        case .negative: // switch 문에서 Int.Kind 타입이란것을 알고 있으므로 축약형을 사용가능
            print("-", terminator: " ") // => terminator : swift는 자동줄바꿈을 해주는데 print 끝나고 수행할 것을 지정해 주는것
        case .zero:
        print("0", terminator: " ")
        case .positive:
            print("+", terminator: " ")
            }
    }
}
printIntegerKinds([3, 19, -27, 0, 14, -14, 0, -7])

//
class Person {
    var name: String
    var home: Apartment?
    init(name: String) {
        self.name = name
    }
}
class Apartment {
    var buildingNumber: String
    var roomNumber: String
    var `guard`: Person?
    var owner: Person?
    init(dong: String, ho: String) {
        buildingNumber = dong
        roomNumber = ho
    }
}

var yagom: Person? = Person(name: "yagom")
yagom?.home = Apartment.init(dong: "101동", ho: "202호")
yagom?.home?.guard = Person(name: "외계인")
//var guardName : String? = yagom?.home?.guard?.name
yagom?.home?.guard?.name = "슈퍼맨"
yagom?.home?.guard?.name = "왜"
//let name = guardName ?? "경비원"
//print(name) // [출력결과]
print(yagom?.home?.guard?.name)
