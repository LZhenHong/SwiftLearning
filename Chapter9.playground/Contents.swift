import UIKit

// Swift is one of the few languages that handles Unicode characters correctly while maintaining maximum predictable performance.

let string = "Matt"
for char in string {
    print(char)
}
let stringLength = string.count
// The short answer is because characters do not have a ﬁxed size so can’t be accessed like an array.
// let fourthChar = string[3]

// Grapheme clusters are represented by the Swift type Character.

let cafeNormal = "café"
let cafeCombining = "cafe\u{0301}"

cafeNormal.count
cafeCombining.count

cafeNormal.unicodeScalars.count
cafeCombining.unicodeScalars.count

for codePoint in cafeCombining.unicodeScalars {
    print(codePoint.value)
}

let firstIndex = cafeCombining.startIndex
let firstChar = cafeCombining[firstIndex]

let lastIndex = cafeCombining.index(before: cafeCombining.endIndex)
let lastChar = cafeCombining[lastIndex]

let fourthIndex = cafeCombining.index(cafeCombining.startIndex, offsetBy: 3)
let fourthChar = cafeCombining[fourthIndex]
fourthChar.unicodeScalars.count
fourthChar.unicodeScalars.forEach {
    print($0.value)
}

let equal = cafeNormal == cafeCombining

// Swift 字符串规范化用在比较字符串是否相等，还用在计算字符串的长度

let name = "Matt"
let backwardsName = name.reversed()
let secondCharIndex = backwardsName.index(backwardsName.startIndex, offsetBy: 1)
let secondChar = backwardsName[secondCharIndex]
// Staying in the reversed collection domain will save memory space, which is fine if you don’t need the whole reversed string.
let backwardsNameString = String(backwardsName)

let raw1 = #"Raw "No Escaping" \(no interpolation!). Use all the \ you want!"#
print(raw1)

let raw2 = ##"Aren't we "# clever"##
print(raw2)

let can = "can do that too"
let raw3 = #"Yes we \#(can)!"#
print(raw3)

let fullName = "Matt Galloway"
let spaceIndex = fullName.firstIndex(of: " ")!
let firstName = fullName[..<spaceIndex]
let lastName = fullName[fullName.index(after: spaceIndex)...]
let lastNameString = String(lastName)

let singleCharacter: Character = "x"
singleCharacter.isASCII

let space: Character = " "
space.isWhitespace

let hexDigit: Character = "d"
hexDigit.isHexDigit

let thaiNine: Character = "๙"
thaiNine.wholeNumberValue

let char = "\u{00bd}"
for i in char.utf8 {
    print(i)
}

let characters = "+\u{00bd}\u{21e8}\u{1f643}"
for i in characters.utf8 {
    print("\(i): \(String(i, radix: 2))")
}
for i in characters.utf16 {
    print("\(i) : \(String(i, radix: 2))")
}

let arrowIndex = characters.firstIndex(of: "\u{21e8}")!
characters[arrowIndex]

if let unicodeScalarsIndex = arrowIndex.samePosition(in: characters.unicodeScalars) {
    characters.unicodeScalars[unicodeScalarsIndex]
}

if let utf8Index = arrowIndex.samePosition(in: characters.utf8) {
    characters.utf8[utf8Index]
}

if let utf16Index = arrowIndex.samePosition(in: characters.utf16) {
    characters.utf16[utf16Index]
}

// ----- Challenges -----
func printCharacterCount(_ str: String) {
    guard str.count > 0 else {
        return
    }

    var charCountMap: [Character: Int] = [:]
    for char in str {
        let count = charCountMap[char, default: 0]
        charCountMap[char] = count + 1
    }
    
    for (char, count) in charCountMap {
        print("\(char): \(count)")
    }
}
printCharacterCount("Eden")

func printWordCount(_ sentence: String) {
    var count = 0
    for char in sentence {
        if char.isWhitespace {
            count += 1
        }
    }
    print(count)
}
printWordCount("Write a function that tells you how many words there are in a string. Do it without splitting the string.")

func formatName(_ name: String) -> String? {
    let index = name.firstIndex(of: ",")
    guard let splitorIndex = index else {
        return nil
    }
    
    let lastName = name[..<splitorIndex]
    let firstName = name[name.index(after: splitorIndex)...]
    return firstName + " " + lastName
}
print(formatName("Galloway,Matt") as Any)

func wordReverser(_ sentence: String) -> String {
    guard sentence.count > 0 else {
        return ""
    }
    
    let words = sentence.components(separatedBy: [" "])
    var resSentence = ""
    for word in words {
        resSentence += word.reversed()
        resSentence += " "
    }
    resSentence.dropLast()
    return resSentence
}

print(wordReverser("My dog is called Rover"))
