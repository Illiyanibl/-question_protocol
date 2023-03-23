protocol Car {
    var model: String {get set}
}
protocol Dealear {
    var name: String {get set}
    var showroom: [Car] {get set}
    var garage: [Car] {get set}
mutating  func addToShowroom(car: Car)
}
extension Dealear {
    mutating func addToShowroom (car: Car){
        self.showroom.append(car)
        //Добавляем mutating потому что Cannot use mutating member on immutable value: 'self' is immutable
    }
}
protocol Special {
    func spesial()
    }
class Mercedes: Dealear {
    var name: String
    var showroom: [Car]
    var garage: [Car]
    init(name: String){
        self.name = name
        self.showroom = []
        self.garage = []
    }
}
extension Mercedes: Special {
    func spesial() {
        self.garage.enumerated().forEach {index, car in
         //  self.addToShowroom(car: car)
// Получаем Cannot use mutating member on immutable value: 'self' is immutable
          //  Dealear.addToShowroom(car)
// Не работает тоже
           // Mercedes.addToShowroom(car)
// опять ошибка
        }
    }
}
// но если copy - paste func addToShowroom (car: Car) из extension Dealear в class Mercedes все ок

class Mercedes2: Dealear {
    var name: String
    var showroom: [Car]
    var garage: [Car]
    init(name: String){
        self.name = name
        self.showroom = []
        self.garage = []
    }
    // copy - paste func addToShowroom (car: Car)
    func addToShowroom (car: Car){
        self.showroom.append(car)
    }
}
extension Mercedes2: Special {
    func spesial() {
        self.garage.enumerated().forEach {index, car in
           self.addToShowroom(car: car)
    // все в порядке но пришлось повторно пиасть код так как не могу обратится .self когда функция mutating
    // как этого избежать чтобы все работало?
        }
    }
}

