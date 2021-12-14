import UIKit

var greeting = "옵셔널 체이닝 and nil 병합 연산자"
//옵셔널체이닝은 옵셔널의 내부의 내부의 내부로 옵셔널이 연결되어 있을때 유용하게 활용할 수 있음
//매번 nil 확인을 하지 않고 최종적으로 원하는 값이 있는지 없는지 확인 할 수 있음

class Person{
    var name : String
    var job : String?
    var home : Apartment?
    
    init(name : String) {
        self.name = name
    }
}

class Apartment{
    var bulidingNumber : String
    var roomNumber : String
    var `guard`: Person?
    var owner : Person?
    
    init(dong : String, ho:String) {
        bulidingNumber = dong
        roomNumber = ho
    }
}

let Bard : Person? = Person(name: "Bard")
let apart : Apartment? = Apartment(dong: "101", ho: "202")
let superman : Person? = Person(name: "Superman")
//옵셔널 체이닝 미사용
//옵셔널 체이닝 실행후 결과값이 nil일 수 있으므로 결과 타입도 옵셔널
func guardJob(owner : Person?){
    if let owner = owner{ // owner 가 nil이 아니면
        if let home = owner.home{ //owner.home 이 nil이 아니면
            if let `guard` = home.guard { // home.guard가 nil 이 아니면 `기호는 변수로 쓸수 없는 키워드를 사용하게 해줌
                if let guardJob = `guard`.job { // `guard`.job이 nil 이 아니면
                    print("우리집 경비원의 직업은 \(guardJob)입니다.")
                }else{
                    print("우리집 경비원의 직업은 없어요")
                }
            }
        }
    }
}
guardJob(owner: Bard)
//옵셔널 체이닝 사용
func guardjobWithOptionalChaining(owner : Person?){
    if let guardJob = owner?.home?.guard?.job { // owner가 nil이아니면 -> home이 nil이 아니면 -> guard가 nil이아니면 job 추출
        print("우리집 경비원의 직업은 \(guardJob)입니다.")
    }else{
        print("우리집 경비원은 직업이 없습니다.")
    }
}
guardjobWithOptionalChaining(owner: Bard)

Bard
Bard?.home

Bard?.home?.guard?.job //nil
Bard?.home = apart //101동과 202호 입력
Bard?.home // 옵셔널 아파트
Bard?.home?.guard //nil

Bard?.home?.guard = superman //name에 superman 입력
Bard?.home?.guard // 옵셔널 person

Bard?.home?.guard?.name // superman 값을 가지고 있음
Bard?.home?.guard?.job // nil

Bard?.home?.guard?.job = "개발자"
Bard?.home?.guard?.job //개발자 값을 가지고 있음

//*********************************nil병합 연산자

var guardjob : String

guardjob = Bard?.home?.guard?.job ?? "슈퍼맨" // Optional ?? Value 옵셔널 값이 nil일경우 Value값을 반환함
print(guardjob)

Bard?.home?.guard?.job = nil

guardjob = Bard?.home?.guard?.job ?? "슈퍼맨"
print(guardjob) // 슈퍼맨





