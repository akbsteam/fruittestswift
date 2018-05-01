import Foundation

public struct Product
{
    var name: String
    var value: Int
    
    public static var apple: Product {
        return Product(name: "Apple", value: 60)
    }
    
    public static var orange: Product {
        return Product(name: "Orange", value: 25)
    }
}
