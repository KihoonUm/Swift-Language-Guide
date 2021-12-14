import UIKit

var greeting = "Protocol은 특정 역할을 수행하기 위한 메서드, 프로퍼티, 기타 요구사항등의 청사진을 정의함 프로토콜은 기능을 정의와 제시할뿐 구현하지 않음"
// 쉽게 말해서 어떤 타입의 객체에게 기능을 강요하여 구현하게 하는것
protocol Talkable{
    
    var topic : String{ get set } // 프로퍼티는 상속후에 재정의 해야하기 때문에 var밖에 쓸수 없음 // 읽기 쓰기 모두 가능
    var language : String { get } //읽기만 가능
//    let name = "kihoon" //=> error
    
    func talk()
    
    init(topic : String, language : String)
}

struct Person : Talkable{ // 구조체 Person에 Talkable 프로토콜을 사용하여 정의함
    var topic: String // 읽기쓰기 가능
    let language: String // 읽기 전용 -> 상수로 구현 // 프로토콜에서 set쓰기전용으로 선언하면 let문에서 error발생

    func talk() {
        print("\(topic)에 대해 \(language)로 말합니다.")
    }
    init(topic : String, language : String) {
        self.topic = topic
        self.language = language
    }
}

var person_sample: Person = .init(topic: "러시아", language: "러시아어")
person_sample.talk()

struct Person_2 : Talkable{// 프로토콜 요구는 다양한 방법으로 해석, 구현 가능함
    
    var subject : String = "" // 연산프로퍼티를 사용할때는 반드시 저장프로퍼티가 존재해야함
    var topic: String{ // 프로퍼티 요구는 연산프로퍼티로 대체가능
        set{ // 쓰기전용 블럭 (설정하다) -> 다른 저장 프로퍼티의 값을 얻거나 연산하여 리턴할 때 사용 -> 파라미터로 받은 값을 어떤 저장프로퍼티에 설정할것인가
            self.subject = newValue // set  블럭에서 암시적 매개변수 newValue를 사용가능 -> subject 프로퍼티에 매개변수값을 저장
        }
        get{ //읽기전용 블럭 (얻다) -> 다른 저장프로퍼티에 값을 저장할 때 사용 -> return 문이 항상 있어야함 -> 어떤 저장프로퍼티의 값을 연산해서 반환하는가
            return self.subject //subject 프로퍼티를 반환
        }
    }
    var language: String{ return "한국어" }
    
    func talk() {
        print("\(topic)에 대해 \(language)로 말합니다.")

    }
    
    init(topic: String, language: String) {
        self.topic = topic
    }
}
var person_test : Person_2 = .init(topic: "몽골인", language: "의미없음")
person_test.talk()
person_test.topic = "외국인드르를르"
person_test.talk()


//**********************************************************
//Protocol 상속은 하나 이상의 프로토콜을 상속받아 기존의 요구사항보다 더 많은 요구사항을 추가할 수 있음 -> 다중상속이 가능함

protocol Readable{
    func read()
}

protocol Writeable{
    func Write()
}
    
protocol ReadSpeakable : Readable{
//    func read() 상속받았기 때문에 요구하고있음
    func speak()
}

protocol ReadWriteSpeakable : Readable, Writeable{
//    func read()
//    func Write() // 암시적으로 두개의 함수를 요구하고있음
    func speak()
}

protocol allable : ReadSpeakable, ReadWriteSpeakable, Readable{ // 중복된 제약조건이 있다고 주위뜸
    func all()
}

struct SomeType : ReadWriteSpeakable{
    func read() {
        print("read")
    }
    func Write() {
        print("Write")
    }
    func speak() {
        print("Speak")
    }
}
let test = SomeType()
test.Write()

//***********************************************************************

class SuperClass : Readable{ // 클래스에서 프로토콜 채택
    func read() {
    }
}

class SubClass : SuperClass, Writeable, ReadSpeakable{ // 클래스와 프로토콜 동시에 상속 받음 -> 상속받을 class를 먼저 상속받고 뒤에 프로토콜
    func Write() {
    }
    func speak() {
    }
//    override func read() { // 클래스에서 상속받은건 재정의 개념  -> 오버라이드
//    }
}
//*************************************** 프로토콜 준수 확인
let sup : SuperClass = SuperClass()
let sub : SubClass = SubClass()

var someAny : Any? = sup // is, as 문을 통해서 인스턴스가 특정 프로토콜을 준수하는지 확인가능
someAny is Readable // someAny 타입이 Readable 타입인가 - > 트루 -> Readable은 SuperClass클래스의 참조변수이며 Readable 프로토콜을 상속받음
// 또한 SuperClass를 상속받지 않았어도 ReadSpeakable이 Readable을 상속채택 하였으므로 함수를 구현하면 -> true
someAny is ReadSpeakable // someAny타입이 ReadSpeakable 타입인가 -> 거짓 -> ReadSpeakable은 상속받지 않았음

//ReadSpeakable is ReadSpeakable // <- 에러 앞단에 생성자를 호출하여 확인해야함
ReadSpeakable.self is Readable  // -> false 여기서 self는 무엇을 가르키는지? ReadSpeakable의 값을 의미 즉 프로퍼티 타입이 Readble 프로토콜을 준수하는가
ReadSpeakable.self is ReadSpeakable.Protocol //-> True
ReadSpeakable.Protocol.self is ReadSpeakable.Type
print(ReadSpeakable.Protocol.self)

//****************************************************************

someAny = sub // Subclass()는 Superclass를 상속받았고, ReadSpeakable,Writeable 을 채택하였음
someAny is Readable
someAny is ReadSpeakable

//**************************************************************** 다운 캐스팅
someAny = sup // Superclass()는 Readable 하나만 상속채택하였음

if let someReadable : Readable = someAny as? Readable { // someAny 프로퍼티가 Readable 프로토콜을 채택하였으면 아래구문 실행
    someReadable.read()
    print("1. someReadable동작")
}// read

if let someReadSpeakable : ReadSpeakable = someAny as? ReadSpeakable{ //someAny 프로퍼티가 ReadSpeakable을 채택했으면 아래구문 실행
    someReadSpeakable.speak()
    print("2. someReadSpeakable동작")
}// 동작하지않음 someAny = sup = Superclass() Readalbe프로토콜만 채택하였음

someAny = sub

if let someReadable : Readable = someAny as? Readable{ //someAny가 Readable 프로토콜을 채택하였으면 아래구문 실행
    someReadable.read()
    print("3. someReadable동작")
}// someAny = sub = subClass() 상속받은 SuperClass가 Readable프로토콜을 상속받음

if let sample : ReadSpeakable = someAny as? ReadSpeakable{ // someAny 프로퍼티가 ReadSpeakable을 채택하였으면 아래구문 실행
    print("4. last")
    sample.speak()
    
}// someAny = sub = subClass() SuperClass, Writeable, ReadSpeakable프로토콜을 다중상속받음


// 프로토콜에서 프로토콜을 상속하여 채택하면 최상위 프로토콜을 다운캐스팅으로 확인불가? -> 프로토콜은 인스턴스가 아니기때문? -> is문으로 채택된 프로토콜 확인은 가능 -> as? 문으로 다운캐스팅시 프로토콜을 다운하는게 아니라 인스턴스를 다운캐스팅하여 타입을 찾아 그 타입이 준수한 프로토콜을 채택하였는지 찾기 때문?

someAny = nil
if let sample : ReadSpeakable = someAny as? ReadSpeakable{ // someAny 프로퍼티가 ReadSpeakable을 채택하였으면 아래구문 실행
    print("5. nil값이 들어와서 if let 구문이 실행을 안함")
    sample.speak()
}

// 프로토콜의 입장에선 타입의 객체에게 구현을 강요함
// 사용하는 타입의 인스턴스입장에선 어떠한 프로토콜을 준수하고 있기 때문에 기능을 명확히 알 수 있음 -> 이타입은 이런기능을 가지고 있으니 무엇을 요청할 수 있음을 에측







