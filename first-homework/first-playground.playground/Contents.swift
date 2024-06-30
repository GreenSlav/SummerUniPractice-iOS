import Foundation

// протокол, который предоставит характеристики для гонки
protocol RaceCar {
    var maxSpeed: Float { get }
    var acceleration: Float { get }
    var handling: Float { get }
    
    func racePerformance() -> Float
}

// базовый(супер) класс автомобиля
class Car: RaceCar {
    var maxSpeed: Float = 0
    var acceleration: Float = 0
    var handling: Float = 0
    var brand: String
    var model: String
    private var _dateOfManufacture: Date?
    
    var dateOfManufacture: Int {
        get {
            let currentCalendar = Calendar.current
            
            if let dateToCheck = _dateOfManufacture {
                return currentCalendar.component(.year, from: dateToCheck)
            }
            
            // по-хорошему бы здесь монаду сделать, потому что -1 - это как-то не очень
            return -1 // если дата производства = nil
        }
        set(newValue) {
            var dateComponents = DateComponents() // параметры нашей даты
            dateComponents.year = newValue // устанавливаем год выпуска
            let currentCalendar = Calendar.current // получаем календарь на текущем устройстве
            _dateOfManufacture = currentCalendar.date(from: dateComponents)
            // присвоили значение нашей даты относительно календаря на текущем устройстве
        }
    }
    
    init(_ brand: String, _ model: String, _ dateOfManufacture: Int) {
        self.brand = brand
        self.model = model
        self.dateOfManufacture = dateOfManufacture
    }
    
    func getInformation() -> Void {
        print("Brand: \(self.brand)")
        print("Model: \(self.model)")
        print("Date of Manufacture: \(self.dateOfManufacture)")
    }
    
    func racePerformance() -> Float {
        return maxSpeed / acceleration * handling
    }
}

class Bmw: Car {
    var enginePower: Double
    var fuelConsumption: Double
    
    init(brand: String, model: String, dateOfManufacture: Int, enginePower: Double, fuelConsumption: Double) {
        self.enginePower = enginePower
        self.fuelConsumption = fuelConsumption
        super.init(brand, model, dateOfManufacture) // вызываем конструктор базового(супер) класса
        maxSpeed = 280;
        acceleration = 3.2
        handling = 0.85
    }
    
    override func getInformation() -> Void {
        super.getInformation() // вызываем НЕпереопределенный метод базового(супер) класса
        print("Engine Power: \(self.enginePower) HP")
        print("Fuel Consumption: \(self.fuelConsumption) L/100km")
    }
}

class Mercedes: Car {
    var enginePower: Double
    var fuelConsumption: Double
    
    init(brand: String, model: String, dateOfManufacture: Int, enginePower: Double, fuelConsumption: Double) {
        self.enginePower = enginePower
        self.fuelConsumption = fuelConsumption
        super.init(brand, model, dateOfManufacture)
        maxSpeed = 290;
        acceleration = 3.5
        handling = 0.8
    }
    
    override func getInformation() -> Void {
        super.getInformation()
        print("Engine Power: \(self.enginePower) HP")
        print("Fuel Consumption: \(self.fuelConsumption) L/100km")
    }
}

class Toyota: Car {
    var enginePower: Double
    var fuelConsumption: Double
    
    init(brand: String, model: String, dateOfManufacture: Int, enginePower: Double, fuelConsumption: Double) {
        self.enginePower = enginePower
        self.fuelConsumption = fuelConsumption
        super.init(brand, model, dateOfManufacture)
        maxSpeed = 230;
        acceleration = 5.7
        handling = 0.95
    }
    
    override func getInformation() -> Void {
        super.getInformation()
        print("Engine Power: \(self.enginePower) HP")
        print("Fuel Consumption: \(self.fuelConsumption) L/100km")
    }
}

class Moskvich: Car {
    var enginePower: Double
    var fuelConsumption: Double
    
    init(brand: String, model: String, dateOfManufacture: Int, enginePower: Double, fuelConsumption: Double) {
        print("Ay, ay, ay I'm your little butterfly 🇨🇳")
        self.enginePower = enginePower
        self.fuelConsumption = fuelConsumption
        super.init(brand, model, dateOfManufacture)
        maxSpeed = 200;
        acceleration = 7.9
        handling = 0.62
    }
    
    override func getInformation() -> Void {
        print("The bluetooth device is ready to pair 🗣🗣🗣")
        super.getInformation()
        print("Engine Power: \(self.enginePower) HP")
        print("Fuel Consumption: \(self.fuelConsumption) L/100km")
    }
}

// для удобства создадим enum
enum CarType {
    case Bmw
    case Mercedes
    case Toyota
    case Moskvich
}

class CarFactory {
    static func createCar(type: CarType, brand: String, model: String, dateOfManufacture: Int, enginePower: Double, fuelConsumption: Double) -> Car {
        switch type {
        case .Bmw:
            return Bmw(brand: brand, model: model, dateOfManufacture: dateOfManufacture, enginePower: enginePower, fuelConsumption: fuelConsumption)
        case .Mercedes:
            return Mercedes(brand: brand, model: model, dateOfManufacture: dateOfManufacture, enginePower: enginePower, fuelConsumption: fuelConsumption)
        case .Toyota:
            return Toyota(brand: brand, model: model, dateOfManufacture: dateOfManufacture, enginePower: enginePower, fuelConsumption: fuelConsumption)
        case .Moskvich:
            return Moskvich(brand: brand, model: model, dateOfManufacture: dateOfManufacture, enginePower: enginePower, fuelConsumption: fuelConsumption)
        }
    }
}

// создание автомобилей с помощью реализованного метода
let car1 = CarFactory.createCar(type: .Bmw, brand: "BMW", model: "M3", dateOfManufacture: 2020, enginePower: 480, fuelConsumption: 10)
let car2 = CarFactory.createCar(type: .Mercedes, brand: "Mercedes-Benz", model: "C63", dateOfManufacture: 2019, enginePower: 503, fuelConsumption: 11)
let car3 = CarFactory.createCar(type: .Toyota, brand: "Toyota", model: "Camry", dateOfManufacture: 2021, enginePower: 335, fuelConsumption: 8)
let car4 = CarFactory.createCar(type: .Moskvich, brand: "Moskvich", model: "Chin-Chan-Chun", dateOfManufacture: 1980, enginePower: 75, fuelConsumption: 15)

// метод проведения гонок между автомобилями
func doCarRace(cars: Car ...)
{
    let listOfWinners = cars.sorted { $0.racePerformance() > $1.racePerformance() } // здесь передали в качестве параметра замыкание(closure), которое сортирует по значению .racePerformance()
    
    print("Place - Car")
    for (index, car) in listOfWinners.enumerated() {
        print("\(index + 1) - \(car.brand)")
    }
}

var listOfCars: [Car] = [car1, car2, car3, car4]

// гонка всех со всеми
doCarRace(cars: car1, car2, car3, car4)

print()

// гонка парами
for (index1, car1) in listOfCars.enumerated() {
    for (index2, car2) in listOfCars.enumerated() {
        if index1 != index2 && index1 < index2 { // чтоб гонок-реваншей не было
            print("Race is starting...")
            doCarRace(cars: car1, car2)
            print("Race finished", terminator: "\n\n")
        }
    }
}
