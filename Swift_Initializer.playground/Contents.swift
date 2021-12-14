import UIKit

var greeting = "이니셜라이저"

class PersonA{
    var name : String = "unknown"
    var age : Int = 0
    var nickName : String = "nick"
}

let jason : PersonA = PersonA() // 클래스의 인스턴스 생성 - > 일반적인 과정
print(jason.name)
//******************************
class PersonB{
    var name :String
    var age : Int
    var nickName : String
    
    init(name : String, age : Int, nickName : String) {
        self.name = name
        self.age = age
        self.nickName = nickName
    }
}
//swift에서 클래스는 참조타입이고 매개변수가 없으므로 이니셜라이져로 초기값을 설정함(?)
// 초기화와 동시에 원하는 값을 입력하기 위해서 사용함
let bard : PersonB = PersonB(name: "엄기훈", age: 26, nickName: "Bard")

//*************************************
class PersonC{
    var name : String
    var age : Int
    var nickName : String? // 꼭 초기화를 할 필요가 없을때 옵셔널 타입을 사용한다
    
    init(name : String, age : Int, nickName : String) {
        self.name = name
        self.age = age
        self.nickName = nickName
    }
    // class  내부의 init을 사용할때는 convenience키워드를 사용한다.
    // 위와 동일한 기능 수행
    // convenience init(name: String, age: Int, nickName: String) {
    //       init(name: name, age: age)
    //       self.nickName = nickName
    //  }
    init(name : String, age : Int) {
        self.name = name
        self.age = age
    }
}

let kihoon : PersonC = PersonC(name: "kihoon", age: 26)
let bard2 : PersonC = PersonC(name: "bard", age: 24, nickName: "B")
//********************************************************************

class Tobea{
    var name : String
    var owner : PersonC! // 암시적 추출은 옵셔널은 인스턴스 사용에 꼭 필요하지만 초기값을 할당하지 않고자 할 때 사용 -> name먼저 받고 owner는 나중에 세팅
    
    init(name : String) {
        self.name = name
    }
    func goOut(){
        print("\(name)가 주인 \(owner.name)을 잘 따라다닙니다.")
    }
}

let happy : Tobea = Tobea(name: "Tobea")
//happy.goOut()//에러발생 owner의 이름을 지정하지 않았음 nil값이 들어있음
happy.owner = kihoon// kihoon = personC타입이고 owner 도 personC이라 입력이 됨
happy.goOut()
print("\(happy.owner.age)")//26
happy.owner = bard2
happy.goOut()
//**********************************************************************
//실패가능한 이니셜라이저 -> 인스턴스 생성에 실패하면 nil값을 반환합니다. (실패가능한 이니셜라이저의 반환타입은 옵셔널타입이고 init?을 사용)

class PersonD{
    var name : String
    var age : Int
    var nickname : String?
    
    init?(name : String, age : Int) { // 리턴값을 nil로 사용가능
        if (0...120).contains(age) == false { // contains 은 특정 문자가 속해있는지 포함여부를 bool타입으로 반환
            return nil
        }
        if name.count == 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}

//let john : PersonD = PersonD(name: "john", age: 40) // 실패 가능한 init이라 nil이 반환될수 있음을 고려 해야함
let john : PersonD? = PersonD(name: "john", age: 23)
let joker : PersonD? = PersonD(name: "joker", age: 123)
let batman : PersonD? = PersonD(name: "", age: 10)

print(joker)//age가 0...120 사이에 존재하지않으며 nil
print(batman)//name의 count값이 0이므로 nil
print("내 이름은 \(john?.name ?? "존")")// john.name이 nil값이면 "존" 출력

//****************************************************************
//디이니셜라이져 deinit은 클래스의 인스턴스가 메모리에서 해체되는 시점에 호출됨 -> 클래스 타입에서만 구현가능

class PersonE{
    var name : String
    var pet: Tobea?
    var child : PersonC
    
    init(name : String, child : PersonC) {
        self.name = name
        self.child = child
    }
    
    deinit {
        if let petName = pet?.name{
            print("\(name)가 \(child.name)에게 \(petName)을 인도합니다.")
            self.pet?.owner = child
            print(self.pet?.owner.name ?? "")
        }
    }
}

var donald :PersonE? = PersonE(name: "donald", child: kihoon)
donald?.pet = happy
donald = nil// 인스턴스가 더이상 필요없으므로 메모리에서 해제 => deinit 구문 실행




