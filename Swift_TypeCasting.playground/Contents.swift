import UIKit

var greeting = "TypeCasting as문과 is 문 인스턴스의 타입을 확인하는 용도, 클래스의 인스턴스를 부모 또는 자식클래스의 타입으로 사용가능 확인 용도"

class Person{
    var name : String = ""
    func breath() {
        print("숨을 쉽니다")
    }
}

class Student : Person{
    var school : String = ""
    func goToSchool() {
        print("내일은 등교를 합니다")
    }
}

class UniversityStudent : Student{
    var major : String = ""
    func goToMT() {
        print("멤버쉽 트레이닝을 갑니다 파이팅!")
    }
}

var bard : Person = Person()
var hana : Student = Student()
var halls : UniversityStudent = UniversityStudent()

var result : Bool

result = bard is Person// true 타입확인 bard는 Person 타입
result = bard is Student// false
result = bard is UniversityStudent // false

result = hana is Person// true Student 타입은 Person 클래스를 상속받아서 true
result = hana is Student// true 타입확인 bard는 Student 타입
result = hana is UniversityStudent// false

//**************************************************** as 업캐스팅
// as문을 사용하여 부모클래스의 인스턴스로 사용할 수 있도록 컴파일러에게 타입정보를 전환해줌// 대부분암시적으로 처리됨

var mike : Person = UniversityStudent() as Person // UniversityStudent 인스턴스를 생성하여 Person행세를 할 수 있도록 업 캐스팅
//mike 는 Person 최상위 클래스 타입으로 자식클래스 university...타입의 업캐스팅 person하여 인스턴스로 사용할수 있도록 컴파일에 타입정보를 전환해줌
var jenny:Student = Student()

var Jina : Any = Person() //Any 혹은 AnyObject로도 타입정보를 반환할 수 있음 암시적으로 as Any가 생략이 되어있음

var kihoon : Person = Person()
//*************************************************** as! as?  다운캐스팅 하위클래스의 인스턴스를 참조하는 것

var optionalCasted : Student?
//person -> student -> university
optionalCasted = mike as? UniversityStudent // 조건부 다운캐스팅 캐스팅에 실패하면 nil을 반환함// 캐스팅성공시 옵셔널타입 반환
optionalCasted = mike as? Student
//optionalCasted = mike // student 타입에 Person 타입 입력불가능함 이걸 가능케 하기 위해 다운캐스팅을 사용하고 mike는 person타입
optionalCasted = mike as? UniversityStudent

optionalCasted = jenny as? UniversityStudent
optionalCasted = jenny

optionalCasted = Jina as? UniversityStudent
optionalCasted = Jina as? Student

//optionalCasted = kihoon
optionalCasted = kihoon as? Student
optionalCasted = kihoon as? UniversityStudent

//*************************************************** 강제다운캐스팅
//person -> student -> university
var forcedCasted : Student
forcedCasted = mike as! UniversityStudent //캐스팅에 실패하면 런타임에러가 발생 캐스팅 성공시 옵셔널이아닌 일반타입 반환
//forcedCasted = jenny as! UniversityStudent//에러
//***************************활용

func doSomethingWithSwitch(someOne : Person){
    switch someOne {
    case is UniversityStudent:
        (someOne as! UniversityStudent).goToMT()
    case is Student:
        (someOne as! Student).goToSchool()
    case is Person:
    (someOne as! Person).breath()
    }
}

doSomethingWithSwitch(someOne: mike as Person) //mike 의 인스턴스는 대학생 이라 mt를감
doSomethingWithSwitch(someOne: mike)// mike의 인스턴스는 대학생이라 mt를감
doSomethingWithSwitch(someOne: jenny) // jenny의 인스턴스는 학생으로 등교를감
doSomethingWithSwitch(someOne: bard) // bard의 인스턴스는 person으로 숨을쉼

func doSomething(someone : Person){ //if let -> 전달인자가 nil값이 아니면
    if let universityStudent = someone as? UniversityStudent{ // someone은 최상위 클래스로 자식 클래스에 universitystudent가 있는지 다운캐스팅
        universityStudent.goToMT()
//        print("1. doSomething 메서드")
    }else if let student = someone as? Student{// 전달받은 someone의 타입이 student 타입을 포함하면 아래 구문실행
        student.goToSchool()
//        print("2. doSomething 메서드")
    }else if let person = someone as? Person{ // person타입을 포함하면 아래 구문실행
        person.breath()
//        print("3. doSomething 메서드")
    }
}
//print("\(jenny.school)여긴뭐가나올까")
print("")
doSomething(someone: mike as Person) // mike 대학생
doSomething(someone: mike)
doSomething(someone: jenny) // 학생
doSomething(someone: bard) // 인간

