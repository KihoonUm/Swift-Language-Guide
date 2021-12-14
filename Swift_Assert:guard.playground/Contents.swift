import UIKit

var greeting = "assert and guard 애플리케이션이 동작도중 생성하는 다양한 연산 결과를 동적으로 확인하고 안전하게 처리할 수 있도록 확인하고 빠르게 처리함"

var somelet : Int = 0

assert(somelet == 0 , "somelet != 0")// assert함수는 디버깅작업에서만 작동함 예상했던 조건의 검증을 위해서 사용 -> 디버깅작업에서만 동작함 배포된 어플에선 동작 x -> 0이아니면 동작 멈추고 뒤에 메시지

somelet = 1
//assert(somelet == 0) // 위에 작성한 assert 때문에 동작중지, 검증실패

func functionWithAssert(age:Int?){
    assert(age != nil, "age == nil")
    
    assert(( age! >= 0 )&&( age! <= 130 ),"나잇값을 입력이 잘못되었습니다.")
    print("당신의 나이는 \(age!)세 입니다.")
}

functionWithAssert(age: 26)
//functionWithAssert(age: nil) //assert문에 작성한 조건에 해당하여 해당 오류문과 함께 에러발생

//************************************************
//guard 문은 잘못된 값의 전달시 특정 실행구문을 빠르게 종료합니다. -> 타입캐스팅 옵셔널과 자주사용하며 return, break 가 있어야함 -> 단순조건 빠르게 종료시에도 유용
//빠른종료를 위한 문법 -> return, break 문 사용
func functionWithGuard(age : Int?){
    guard let unwrappedAge = age, // nil이면 실행안하고 리턴
          unwrappedAge < 130, // age값이 130 미만이고
          unwrappedAge >= 0 else { // age값이 0이상이면 guard탈출 -> else 위 조건에 해당되되지 않으면 else 구문 실행
        print("나잇값이 입력이 잘못되었습니다.")// 범위벗어날시 오류문
        return
    }
    
//    guard unwrappedAge < 100 else {
//        return
//    }
//    if unwrappedAge < 100 {
//    } else{
//        return
//    } // 같음
    
    print("당신의 나이는 \(unwrappedAge)세 입니다.!!!") // 여기서 if let과 차이점은 guard문은 언래핑이후에도 상수를 계속 사용가능
}
functionWithGuard(age: 100)


var count = 1

while true {
    guard count < 3 else {
        break
    }
    print(count)
    count += 1
}// 1 2

func someFunction(info : [String : Any]){ //딕셔너리 타입 -> 옵셔널값 -> 해쉬맵과 비슷
    guard let name = info["name"] as? String else { // info에 "name"키값이 없거나 String타입이 아니라면 리턴을함
        return
    }
    guard let age = info["age"] as? Int, age >= 0 else{ // info에 들어오는 값이 "age"이 아니고 Int타입이 아니며 0보다 작으면 리턴을함
        return
    }
    guard let nickname = info["nickname"] as? String else {
        return
    }
    
    print("\(name) : \(age) -> \(nickname)")
}

someFunction(info: ["name":"jenny","age":"10"])
someFunction(info: ["name":"bard"])
someFunction(info: ["name":"yagome","age":10])
someFunction(info: ["name":"kihoon", "age":26,"nickname":"bard"])

