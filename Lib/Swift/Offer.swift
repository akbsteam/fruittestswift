import Foundation

public typealias OfferType = ([Product]) -> Int

public struct Offer
{
    static var bogof: OfferType = { list in
        guard let value = list.first?.value else { return 0 }
        let count = list.count
        
        let bogof = Int(floor(Double(count) / 2))
        let remainder = count % 2
        
        return (bogof + remainder) * value
    }
    
    static var threeForTwo: OfferType = { list in
        guard let value = list.first?.value else { return 0 }
        let count = list.count
        
        let threes = Int(floor(Double(count) / 3))
        let remainder = count % 3
        
        return (threes * value * 2) + (remainder * value)
    }
}
