import XCTest
@testable import Lib

class LibTests: XCTestCase
{
    func test_testApple()
    {
        let product = Product.apple
        
        XCTAssertEqual(product.name, "Apple", "Name \(product.name) is not 'Apple'")
        XCTAssertEqual(product.value, 60, "Value \(product.value) is not 60")
    }
    
    func test_testOrange()
    {
        let product = Product.orange
        
        XCTAssertEqual(product.name, "Orange", "Name \(product.name) is not 'Orange'")
        XCTAssertEqual(product.value, 25, "Value \(product.value) is not 25")
    }
    
    func test_createAndAppendFruits()
    {
        var checkout = Checkout()
        var expected: Int = 0
        
        for _ in 0...100 {
            let product = self.randomProduct()
            expected += product.value
            checkout.add(product: product)
        }
        
        let total = checkout.total()
        
        XCTAssertEqual(total, expected, "Total \(total), does not match expected: \(expected)")
    }
    
    func test_checkoutList()
    {
        let (list, expectedTotal) = productList()
        let checkout = Checkout(products: list)
        let total = checkout.total()
        
        XCTAssertEqual(total, expectedTotal, "Total \(total), does not match expected: \(expectedTotal)")
    }
    
    func test_checkoutListAlternate()
    {
        var checkout = Checkout()
        
        let (list, expectedTotal) = productList()
        checkout.add(list: list)
        let total = checkout.total()
        
        XCTAssertEqual(total, expectedTotal, "Total \(total), does not match expected: \(expectedTotal)")
    }
    
    func test_bogof()
    {
        let list: [Product] = [.apple, .apple, .apple]
        let expectedTotal = (Product.apple.value * 2)
        
        let total = Offer.bogof(list)
        XCTAssertEqual(total, expectedTotal, "Total \(total), does not match expected: \(expectedTotal)")
    }

    func test_threeForTwo_twoOranges()
    {
        let list: [Product] = [.orange, .orange]
        let expectedTotal = (Product.orange.value * 2)
        
        let total = Offer.threeForTwo(list)
        XCTAssertEqual(total, expectedTotal, "Total \(total), does not match expected: \(expectedTotal)")
    }
    
    func test_threeForTwo_threeOranges()
    {
        let list: [Product] = [.orange, .orange]
        let expectedTotal = (Product.orange.value * 2)
        
        let total = Offer.threeForTwo(list)
        XCTAssertEqual(total, expectedTotal, "Total \(total), does not match expected: \(expectedTotal)")
    }
    
    func test_productsAndOffers()
    {
        let offers: [String: OfferType] = ["Apple": Offer.bogof, "Orange": Offer.threeForTwo]
        let list: [Product] = [.apple, .apple, .apple, .orange, .orange]
        let expectedTotal = (Product.apple.value * 2) + (Product.orange.value * 2)
        
        let checkout = Checkout(offers: offers, products: list)
        
        let total = checkout.totalIncludingOffers()
        XCTAssertEqual(total, expectedTotal, "Total \(total), does not match expected: \(expectedTotal)")
    }
    
    func test_productsAndOffersTwo()
    {
        let offers: [String: OfferType] = ["Apple": Offer.bogof, "Orange": Offer.threeForTwo]
        let list: [Product] = [.apple, .apple, .apple, .apple, .orange, .orange, .orange]
        let expectedTotal = (Product.apple.value * 2) + (Product.orange.value * 2)
     
        let checkout = Checkout(offers: offers, products: list)
     
        let total = checkout.totalIncludingOffers()
        XCTAssertEqual(total, expectedTotal, "Total \(total), does not match expected: \(expectedTotal)")
        
    }
    
    // MARK: Helper functions
    
    func randomProduct() -> Product
    {
        return arc4random_uniform(10) % 2 == 0 ? .apple : .orange
    }
    
    func productList() -> ([Product], Int)
    {
        var expected: Int = 0
        var list: [Product] = []
        
        for _ in 0...100 {
            let product = self.randomProduct()
            expected += product.value
            list.append(product)
        }
        
        return (list, expected)
    }
}
