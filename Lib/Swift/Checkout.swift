import Foundation

public struct Checkout
{
    var products: [Product]
    var offers: [String: OfferType]
    
    public init(offers: [String: OfferType] = [:],
                products: [Product] = [])
    {
        self.products = products
        self.offers = offers
    }
    
    public mutating func add(list: [Product]) {
        self.products += list
    }
    
    public mutating func add(product: Product) {
        self.products.append(product)
    }
    
    public func total() -> Int
    {
        return products.reduce(0, { $0 + $1.value })
    }
    
    public func totalIncludingOffers() -> Int
    {
        let dict = Dictionary(grouping: self.products, by: { $0.name })
        
        return dict
            .map { (key, list) -> Int in
                let offer: OfferType? = self.offers[key]
                return offer?(list) ?? list.reduce(0, { $0 + $1.value })
            }
            .reduce(0, +)
    }
}
