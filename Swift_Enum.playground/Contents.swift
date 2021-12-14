import UIKit


enum Swifft_Edu{
    case iosedu
    case normaledu
    case projectedu
}

var edu = Swifft_Edu.iosedu // 열거형의 타입과 case 구문 모두 사용가능

edu = .normaledu //타입이 명확하다면 .케이스이름 으로 표현해도 무방

print(edu)

enum Fruit : Int {
    case apple = 0
    case grape = 1
    case banana = 2
    case peach
    case orange
//    case mango = 0 // 원시값은 각각 달라야함
}
print("Fruit.peach.rawValue == \(Fruit.peach.rawValue) " )// 자동으로 1이 증가한 값을 나타냄
print("Fruit.orange.rawValue == \(Fruit.orange.rawValue)")//4

enum School : String{
    case elementary = "초등"
    case middle = "중등"
    case high = "고등"
    case university
}

print("School.elemetary.rawValue == \(School.elementary.rawValue)") // 초등
print("university.elementary.rawValue == \(School.university.rawValue)") // 원시값이 없으면 케이스 이름이나옴

let apple : Fruit? = Fruit(rawValue: 0)//rawValue로 초기화한 값은 옵셔널 타입으로 Fruit 형이 아님
if let peach : Fruit = Fruit(rawValue: 3){
    print("원시값 3에 해당하는 케이스는 \(peach) 입니다.")
}else{
    print("원시값 3에 해당하는 케이스는 없습니다.")
}

enum Month{
    case dec,jan,feb
    case mar,apr, may
    case jun, jul, aug
    case sep, oct, nov

    func printMessage() {
        switch self {
        case .mar,.apr,.may:
            print("따스한 봄")
        case .jun, .jul, .aug:
        print("무더운 여름")
        case .sep, .oct, .nov:
        print("시원한 가을")
        case .dec, .jan, .feb:
        print("추운 겨울")
        }
    }
}
Month.mar.printMessage()//열거형 안에 메서드를 추가가능
Month.feb.printMessage()
