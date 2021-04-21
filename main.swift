// Для решения задач достаточно книги по Swift от Apple и стандартной библиотеки языка.
// https://s...content-available-to-author-only...t.org/documentation/
// Предпочтительнее использовать стандартную библиотеку и функциональные подходы.
// Редактируй код только внутри методов, у которых есть документация. 
// Тесты можно добавить, но не убрать. По ним удобно понять, какие входные значения могут быть.

// Можно решать в Swift Playgrounds для удобства и автоподстановки. 
// Решение нужно скинуть в leetcode, сделав Fork.
// Не забудьте сохранить решение! Без fork весь прогресс потеряется!

// В каждом задании нужно:
// Написать содержимое метода. Что делает метод - описано над ним.
// Примеры можно посмотреть по тестам под методом в конце задания.
// Эти тесты проверяют, правильно ли работает метод.
// ensure(input:, output:). Первый аргумент - входные параметры. Второй аргумент - ожидаемый ответ.


/// Задание #1
func task1() {
    /// Сумма уникальных элементов массива опциональных значений.
    /// Возвращает 0, если Int в массиве нет.
    /// Например, для массива [20,10,20,nil] результат будет 30
    func sumOfUnique(_ input: [Int?]) -> Int {
        var unique = Set<Int>()       
        for case let num? in input {
            if num is Int {
                unique.insert(num)               
            }            
        }
        if unique.isEmpty{
            return 0
        } else {
            let sum = unique.reduce(0,+)
            return sum
        }    
    }

    // Tests
    func ensure(input: [Int?], equals sum: Int) {
        let result = sumOfUnique(input)
        if result != sum {
            fatalError("Sum is wrong. \(result) is not \(sum)")
        } else {
            print("Test on sum is OK! \(result) is \(sum)")
        }
    }
    ensure(input: [nil, nil], equals: 0)
    ensure(input: [20, 10, 20, nil], equals: 30)
    print("All tests passed. Task #1 is done.")
    print("---")
}

/// Задание #2
func task2() {
    /// Собирает ФИО, учитывая правила только русского языка. 
    /// Возвращает <не известно>, если получается пустое значение.
    /// Например, для "Иван", "Иванов", "Иванович" результат будет "Иванов Иван Иванович"
    func displayName(firstName: String?, lastName: String?, patronym: String?) -> String {
        let charset = CharacterSet(charactersIn: "АаБбВвГгДдЕеЁёЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя")
        var fullName:String = ""
        if lastName?.rangeOfCharacter(from: charset) != nil{
            fullName = fullName + (lastName ?? "")
        }
        if firstName?.rangeOfCharacter(from: charset) != nil{
            if lastName != "" && lastName != nil{
                fullName = fullName + " " + (firstName ?? "")
            } else{
                fullName = fullName + (firstName ?? "")
            } 
        }        
        if patronym?.rangeOfCharacter(from: charset) != nil{
            if (firstName != "" && firstName != nil) || (lastName != "" && lastName != nil) {
                fullName = fullName + " " + (patronym ?? "")
            } else{
                fullName = fullName + (patronym ?? "")
            } 
        }
        if fullName != ""{
            return fullName
        } else {
            return "<не известно>"
        }
        
    }

    // Tests
    func ensure(input: (String?, String?, String?), equals fullName: String) {
        let result = displayName(firstName: input.0, lastName: input.1, patronym: input.2)
        if result != fullName {
            fatalError("Display name is wrong. \(result) != \(fullName)")
        } else {
            print("Test on display name is OK! \(result) is \(fullName)")
        }
    }
    
    ensure(input: (nil, nil, nil), equals: "<не известно>")
    ensure(input: (nil, "", nil), equals: "<не известно>")
    ensure(input: ("Иван", "Иванов", "Иванович"), equals: "Иванов Иван Иванович")
    ensure(input: ("Иван", nil, "Иванович"), equals: "Иван Иванович")
    print("All tests passed. Task #2 is done.")
    print("---")
}

/// Задание #3
func task3() {
    /// Для словаря значений возвращает query в формате "key1=value1&key2=value2" с сортировкой по алфавиту.
    /// Ограничение на Any: можно считать, что может быть опциональным (Int, String, Double).
    func query(from dictionary: [String: Any]) -> String {
        let sortedDictionary = dictionary.sorted {
           $0.0 < $1.0
        }                
        var ans:String = ""
        var i = 0
        for (key,value) in sortedDictionary{
            if key is String{
                var tmpStr:String?
                switch value {
                case let int as Int:
                    tmpStr = String(int)
                case let string as String:
                    tmpStr = String(string)
                case let double as Double:
                    tmpStr = String(double)
                default:
                    tmpStr = nil
                }               
                if i == 0 && tmpStr != nil{
                        ans = ans + key + "=\(tmpStr ?? "")"
                } else if tmpStr != nil {
                        ans = ans + "&" + key + "=\(tmpStr ?? "")"
                }
            }
            i+=1
        }   
        return ans
    }

    // Tests
    func ensure(dictionary: [String: Any], is expectedQuery: String) {
        let result = query(from: dictionary)
        if result != expectedQuery {
            fatalError("Query is wrong. \(result) != \(expectedQuery)")
        } else {
            print("Test on query is OK! \(result) is \(expectedQuery)")
        }
    }

    ensure(dictionary: ["id": 0, "progress": Optional<Double>(5.34)], is: "id=0&progress=5.34")
    ensure(dictionary: ["key": Optional<String>("anthony"), "other_key": Optional<String>(nil)], is: "key=anthony")
    print("All tests passed. Task #3 is done.")
    print("---")
}

/// Задание #4
func task4() {
    /// Получает количество тестовых площадок.
    /// Возвращает массив ссылок с названием test-i.service.ru, где i - номер площадки.
    func testURLs(count: Int) -> [String] {
        var urlArray:[String] = []
        if count > 0{
            for i in 0...count-1{
                urlArray.append("test-\(i).service.ru")
            }
        }        
        return urlArray   
    }

    // Tests
    func ensure(testURLsForCount count: Int, is urlArray: [String]) {
        let result = testURLs(count: count)
        if result != urlArray {
            fatalError("Urls array is wrong. \(result) != \(urlArray)")
        } else {
            print("Test on urls array is OK! \(result) is \(urlArray)")
        }
    }

    ensure(testURLsForCount: 0, is: [])
    ensure(testURLsForCount: 1, is: ["test-0.service.ru"])
    ensure(testURLsForCount: 3, is: ["test-0.service.ru", "test-1.service.ru", "test-2.service.ru"])
    print("All tests passed. Task #4 is done.")
    print("---")
}

// Задание #5
func task5() {
    typealias SectionId = Int
    struct Item {
        let title: String
        let sectionId: SectionId       
    }

    struct Section: Equatable {
        let sectionId: SectionId
        let items: [String]
    }

    /// Перевести массив элементов в массив секций с сортировкой по алфавиту и по id секции.
    func sections(for items: [Item?]) -> [Section] {
        var dict = [Int: [String]]()        
        var ans:[Section] = []
         for item in items{
            if item != nil{                
                if var value = dict[item?.sectionId ?? -1 ]{
                    value.append(item?.title ?? "")
                    dict[item?.sectionId ?? -1] = value
                } else{
                    dict[item?.sectionId ?? -1] = [item?.title ?? ""]
                }
            }          
        }
        for (id,titles) in dict{
            let sortedStrings = titles.sorted (by: {
            $0 < $1
            })
            dict[id] = sortedStrings
        }
        let sortedDict = dict.sorted (by: {
            $0.0 < $1.0
        })
        for (id,titles) in sortedDict{
            ans.append(Section(sectionId: id,items: titles))
        }
        return ans
    }

    // Tests
    func ensure(input: [Item?], isSections expectedSections: [Section]) {
        let result = sections(for: input)
        if result != expectedSections {
            fatalError("Sections are wrong. \(result) != \(expectedSections)")
        } else {
            print("Test on sections is OK! \(result) is \(expectedSections)")
        }
    }
    ensure(
        input: [nil, Item(title: "item1", sectionId: 0), nil],
        isSections:  [Section(sectionId: 0, items: ["item1"])]
    )
    ensure(
        input: [Item(title: "item3", sectionId: 0), Item(title: "item1", sectionId: 0), nil, Item(title: "item2", sectionId: 2)],
        isSections: [
            Section(sectionId: 0, items: ["item1", "item3"]),
            Section(sectionId: 2, items: ["item2"])
        ]
    )
    print("All tests passed. Task #5 is done.")
    print("---")
}

/// Задание #6
func task6() {
    enum Fruit : Equatable{
        case apple(color: String)
        case orange(size: Int)
    }

    // #6.1 сравнение по типу. Возвращает true, если это такой же вид фрукта
    func isEqualShallow(fruit: Fruit, to otherFruit: Fruit) -> Bool {       
        switch (fruit, otherFruit){            
            case (.apple, .apple):
                return true            
            case (.orange, .orange):
                return true
            default:
                return false
        }        
    }

    // #6.2 сравнение по параметрам. Возвращает true, если все параметры фруктов совпадают.
    func isEqualDeep(fruit: Fruit, to otherFruit: Fruit) -> Bool {
        switch (fruit, otherFruit){            
            case (let .apple(fruitColor), let .apple(othetFruitColor)):
                return fruitColor == othetFruitColor           
            case (let .orange(fruitSize), let .orange(othetFruitSize)):
                return fruitSize == othetFruitSize
            default:
                return false
        }
    }

    // Tests
    func ensureShallow(input: (Fruit, Fruit), is expected: Bool) {
        let result = isEqualShallow(fruit: input.0, to: input.1)
        if result != expected {
            fatalError("Shallow compare is wrong. \(result) != \(expected)")
        } else {
            print("Test on shallow is OK! \(result) is \(expected)")
        }
    }
    func ensureDeep(input: (Fruit, Fruit), is expected: Bool) {
        let result = isEqualDeep(fruit: input.0, to: input.1)
        if result != expected {
           fatalError("Deep compare is wrong. \(result) != \(expected)")
        } else {
            print("Test on deep is OK! \(result) is \(expected)")
        }
    }
    ensureShallow(input: (Fruit.apple(color: "green"), Fruit.orange(size: 1)), is: false)
    ensureShallow(input: (Fruit.apple(color: "green"), Fruit.apple(color: "red")), is: true)
    ensureDeep(input: (Fruit.apple(color: "green"), Fruit.apple(color: "red")), is: false)
    ensureDeep(input: (Fruit.orange(size: 1), Fruit.apple(color: "green")), is: false)
    ensureDeep(input: (Fruit.apple(color: "green"), Fruit.apple(color: "green")), is: true)
    print("All tests passed. Task #6 is done.")
    print("---")
}

// Можно закомментировать вызовы определенных заданий, чтобы было удобнее работать по одному заданию.
task1()
task2()
task3()
task4()
task5()
task6()

