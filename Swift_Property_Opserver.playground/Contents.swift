import UIKit

var greeting = "프로퍼티 감시자" // 프로퍼티 값이 변할때 실행함

struct Money{
    var currencyRate : Double = 1100 {
        willSet(newRate){ // 값이 변경되기 직전에 실행 newset
            print("환율이 \(currencyRate)에서 \(newRate )로 변할 예정입니다.")
        }
        
        didSet(oldSet){ // 값이 변경된후 실행 didset
            print("환율이 \(oldSet)에서 \(currencyRate)로 변했습니다..")
        }
    }

    var dollar : Double = 0{
        
        willSet{//wilset 의 암시적 매개변수 이름 newVlue
            print("\(dollar)달러에서 \(newValue)달러 변할 예정입니다.")
        }
        didSet{//didset 의 암시적 매개변수 이름 oldValue
            print("\(oldValue)에서 \(dollar)달러로 변했습니다.")
        }
    }

    var won : Double{
        get{
            return dollar*currencyRate
        }set{
            dollar = newValue / currencyRate
        }
    }
}

var moneyInMyPocket : Money = Money()

moneyInMyPocket.currencyRate = 1150
moneyInMyPocket.dollar = 10
print(moneyInMyPocket.won)
