import UIKit

var greeting = "array set Dictionary"

var someInts = [Int]() // 빈 배열
someInts.append(3) // 배열인덱스 +1 숫자 3입력



// set
var letters = Set<Character>() // 비어있는 set
print("letters is of type Set<Character> with \(letters.count) items.")

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
print("letters is of type Set<Character> with \(favoriteGenres.count) items.")
favoriteGenres.insert("Jazz") // 셋 데이터추가
print(favoriteGenres)

favoriteGenres.remove("Jazz")
print(favoriteGenres)
//set 메서드
//intersection(_:) 메서드는 두 집합의 교집합을 구하여, 즉 두 집합에 모두 있는 값들을 모아 새로운 집합을 만든다.
//symmetricDifference(_:) 메서드는 두 개의 집합에서 교집합을 뺀 값들을 모아 새로운 집합을 만든다.
//union(_:) 메서드는 두 개의 집합의 모든 값들로 새로운 집합을 만든다 (물론 중복된 값은 알아서 처리된다)
//substracting(_:) 메서드는 차집합으로 지정된 집합에는 없는 값들을 제거한 새로운 집합을 만든다.
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sorted() // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted() // []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted() // [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted() // [1, 2, 9]


//Dictionaries
var namesOfIntegers = [Int: String]() // 빈딕셔너리
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
print("The airports dictionary contains \(airports.count) items.") // 키-쌍 의 개수를 알려줌
airports["LHR"] = "London" // 새로운값 추가
print(airports["LHR"]!) // 키값으로 값추출
print(airports.values)
airports["YYZ"] = "London"

for airportCode in airports.keys { print("Airport code: \(airportCode)") } 
for airportName in airports.values { print("Airport name: \(airportName)") }
