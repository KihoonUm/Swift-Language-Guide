import UIKit

var greeting = "에러 처리는 프로그램의 오류 조건에 응답하고 복구하는 프로세스이며 발생(throwing), 감지(catching), 증식(propagating), 조작(manipulating)하는 일급 객체를 제공함"



enum VendingMachineError : Error{ // Error라는 프로토콜 타입을 준수하는 타입 값으로 표현함
    case invalidSeletion // 잘못된선택
    case insufficientFunds(coinNeeded : Int) // 금액부족
    case outOfStock // 품절
    case invalidInput // 잘못된 입력
}

//throw VendingMachineError.insufficientFunds(coinNeeded: 5) // 에러발생코드 -> 자판기에 코인 5개가 더 필요함


class VendingMachine{ // 자판기 개체
    let itemPrice : Int = 100
    var itemCount : Int = 5
    var deposited : Int = 0

    func receiveMoney(_ money: Int)throws{ // 돈받기 메서드 -> throws 오류 발생여지가있음
        
        guard money > 0 else { // 입력한 돈이 0이하면 오류를 던짐 -> money가 0보다 작으면 else 구문실행 0 보다 크거나 같으면 guard문 지나감
            throw VendingMachineError.invalidInput // 잘못된 수량 에러 -> throw 오류를 던지면서 함수를 끝내버림
        }
        self.deposited += money // 예치금에 전달받은 매개변수입력
        print("\(money)원 받음")
    }
	
    func vend(numberOfItems numberOfItemsToVend : Int) throws -> String {
        guard numberOfItemsToVend > 0 else {  // 원하는 아이템의 수량이 잘못 입력되면 오류를 던짐 -> number...이 0보다 작거나 같으면 else구문 실행
            throw VendingMachineError.invalidInput // 잘못된 수량 에러
        }
        guard numberOfItemsToVend * itemPrice <= deposited else { // number... * itemsPrice 가격이 예치금 보다 작으면 else
            let moneyNeeded : Int
            moneyNeeded = numberOfItemsToVend * itemPrice - deposited // 부족한 금액
            throw VendingMachineError.insufficientFunds(coinNeeded: moneyNeeded) // 금액부족 에러 부족한 금액표시
        }
        guard itemCount >= numberOfItemsToVend else { // 아이템의 갯수부족하면 에러 -> itemCount가 number...보다 작으면 else
            throw VendingMachineError.outOfStock // 품절에러
        }
        let totalPrice = numberOfItemsToVend * itemPrice // 총합계 금액
        
        self.deposited -= totalPrice // 잔액 = 예치금 - 총합계금액
        self.itemCount -= numberOfItemsToVend // 남은재고 = 남은재고 - 구매갯수
        
        return "\(numberOfItemsToVend)개 제공함"
    }
}

let machine : VendingMachine = VendingMachine() // 자판기 인스턴스

var result : String? // 판매결과를 받을 변수

//오류를 내포하고 있는 throws함수는 반드시 try문을 사용해야함
//do { // 오류처리 오류를 던질수도 있지만 오류가 던져지는것에 대해 오류를 처리하기 위한 코드도 작성해야함 예를 들면 던져진 오류가 무엇인지 판단하여 다시 문제를 해결한다던지, 다른 방법으로 시도해 본다던지, 사용자에게 오류를 알리고 사용자에게 선택권한을 넘겨주어 다음에 어떤 동작을 할 것인지 결정하도록 유도하는 코드
//    try machine.receiveMoney(0) // 오류발생의 여지가 있는 throws함수는 try를 사용하여 호출해야함
//} catch VendingMachineError.invalidInput {
//    print("입력이 잘못되었습니다.")
//} catch VendingMachineError.insufficientFunds(let moneyNeeded){
//    print("\(moneyNeeded)원이 부족합니다.")
//}catch VendingMachineError.outOfStock{
//    print("수량이 부족합니다.")
//} // - > 입력이 잘못되었습니다

//#################################################################

do {
    try machine.receiveMoney(300) // 여기서 만약 오류가 발생했음
} catch /*let error */{ // 위 캐치문을 스위치 문으로 표현한것으로 별반 다르게 없음 -> 암시적으로 error상수가 넘어옴 -> 변수명 변경가능
    switch error {
    case VendingMachineError.invalidInput:
        print("입력이 잘못되었습니다.")
    case VendingMachineError.insufficientFunds(let moneyNeeded):
    print("\(moneyNeeded)원이 부족합니다.")
    case VendingMachineError.outOfStock:
        print("수량이 부족합니다.")
    default:
        print("알수없는 오류 \(error)")
    }
} // 300원받음
//#########################
//do { // 딱히 케이스별로 오류처리 할 필요가 없다면 catch문 내부를 간략화해도 무방
//    result = try machine.vend(numberOfItems: 4)
//} catch  {
//    print(error)
//} // insufficientFunds 에러 금액부족 최소금액 100원
//#########################
//do { // 케이스별로 오류처리 할 필요가 없다면 do 구문만 써도 무방
//    result = try machine.vend(numberOfItems: 4)
//}

//########################### try?, try!

result = try? machine.vend(numberOfItems: 2) // 별도의 오류처리 결과를 통보받지 않고 오류가 발생했으면 결과값을 nil로 돌려받을 수 있음
result // Optional("2개 제공함") -> 정상동작 후에는 옵셔널 타입으로 정상 반환값을 돌려받음

result = try? machine.vend(numberOfItems: 2) // 오류발생 -> 오류가 발생한다면 nil이 들어감
result // nil

//###########################

result = try! machine.vend(numberOfItems: 1) // 오류가 발생하지 않을 것이라는 강력한 확신을 가질 때 try!를 사용하면 정상동작 후에 바로 결과를 돌려받음
result // 1개 제공함

result = try! machine.vend(numberOfItems: 1) // runtime error



