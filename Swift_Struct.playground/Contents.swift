import UIKit

//클래스는 참조타입 구조체, 열거형은 값타입 // 클래스는 상속이 가능하지만 구조체, 열거형은 상속이 불가능함

struct Sample{
    var name : String
    var age :  Int
    
    var mutableProperty : Int = 100
    let immutableProperty : Int = 100
    
    static var typeProperty : Int = 100
    
    func instanceMethod() {
        print("instance method")
    }
    
    static func typeMethod() {
        print("type method")
        
    }
}

var mutable = Sample(name: "kihoon", age: 26)

mutable.mutableProperty = 200 // 구조체안의 가변 프로퍼티 변경가능
//mutable.immutableProperty = 200 // 구조체안의 불변 프로퍼티 변경 불가능

let immutable = Sample(name: "kihoon", age: 26 ) // 구조체안에 가변프로퍼티가 존재하면 자동완성 리스트하나더나옴

//immutable.age = 20 //불변프로퍼티로 선언하게 되면 안에 포함되는 프로퍼티 수정 불가능

Sample.typeProperty = 300//타입프로퍼티
Sample.typeMethod()//타입메서드 -> static 을 연결고리로 바로 동작?

//mutable.typeMethod()//인스턴스에서는 타입 프로퍼티를 사용할 수 없다. static이 정적으로 만들어 버림

//구조체는 상속x
//타입캐스팅은 클래스의 인스턴스에만 허용됨
//참조 횟수 계산은 클래스 인스턴스에만 허용됨
//구조체를 사용할 상황
//1. 연관된 간단한 값의 집합을 캡슐화 하는 것만이 목적일 때
//2. 캡슐화된 값이 참조되는 것보다 복사되는 것이 합당할 때
//3. 구조체에 저장된 프로퍼티가 값 타입이며 참조되는 것보다 복사되는 것이 합당할 때
//4. 다른 타입으로부터 상속받거나 자신이 상속될 필요가 없을 때

//###################################################

struct ValueType{
    var property = 1
}

class ReferenceType{
    var property = 1
}
// 구조체
let firstStructInstance = ValueType()
var secondStructInstance = firstStructInstance

secondStructInstance.property = 2
print(secondStructInstance.property)
print(firstStructInstance.property) // 값타입은 값을 복사하여 처리를 하기 때문에 구조체에 있는 변수값이 바뀌지 않았음

// 클래스
var firestClassInstance = ReferenceType()
var secondClassInstance = firestClassInstance

secondClassInstance.property = 2

print(secondClassInstance.property)
print(firestClassInstance.property) // 참조타입은 값의 메모리 주소값을 참조하기 때문에 참조하는 곳에서 값을 변경하면 주소로 접근하여 참조된 값이 변경됨








