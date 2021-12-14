import UIKit

var greeting = "옵셔널 바인딩은 옵셔널로 래핑된 값을 추출하는것"

//1. nil체크 + 안전한추출
//2. 옵셔널 안에 값이 들어있는지 확인하고 추출
//3. if-let     방식

func printName(_ name : String){
    print(name)
}

var myName : String? = nil

//printName(myName) -> 전달되는 타입의 값이 다르기 때문에 에러발생 -> 이럴때 옵셔널 바인딩을 사용

if let name : String = myName { // name상수는 if let 구문 안에서만 사용가능
    printName(name)
} else{
    print("myName이 nil값을 가지고 있습니다.")
}

var yourName : String! = nil

if let name : String = yourName {
    print(name)
} else {
    print("yourName 이 nil값을 가지고 있습니다.")
}

myName = "Bard"
yourName = nil

if let name = myName, let friend = yourName{
    print("myName : \(name) and yourname : \(friend)")
}

yourName = "kihoon"

if let name = myName, let friend = yourName {
    print("myName : \(name) and yourname : \(friend)")
}

if let _ = myName, let _ = yourName {
    print("myname : \(myName ?? "") and yourname : \(yourName ?? "") ") // -> 옵셔널값으로 나오므로 nil병합연산을 사용
}

