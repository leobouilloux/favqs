//
//  FavqsTests.swift
//  FavqsTests
//
//  Created by Leo Marcotte on 04/10/2020.
//

@testable import Favqs
import XCTest
import RealmSwift

class FavqsTests: XCTestCase {
    func testQuoteCellViewModelNotFavorite() throws {
        // GIVEN
        let quote = Quote()
        quote.author = "John Doe"
        quote.body = "Lorem Ipsum"
        quote.isFavorite = false
        quote.tags = List<String>()
        quote.tags.append("tag1")
        quote.tags.append("tag2")
        quote.tags.append("tag3")
        

        // WHEN
        let cellViewModel = QuoteTableViewCellViewModel(quote: quote)
                
        // THEN
        XCTAssertTrue(cellViewModel.author.value == "John Doe")
        XCTAssertTrue(cellViewModel.body.value == "Lorem Ipsum")
        XCTAssertTrue(cellViewModel.tags.value == "tag1, tag2, tag3")
        XCTAssertTrue(cellViewModel.favoriteImage.value == UIImage())
    }
    
    func testQuoteCellViewModelIsFavorite() throws {
        // GIVEN
        let quote = Quote()
        quote.author = "John Doe"
        quote.body = "Lorem Ipsum"
        quote.isFavorite = true
        quote.tags = List<String>()
        quote.tags.append("tag1")
        quote.tags.append("tag2")
        quote.tags.append("tag3")
        

        // WHEN
        let cellViewModel = QuoteTableViewCellViewModel(quote: quote)
                
        // THEN
        XCTAssertTrue(cellViewModel.author.value == "John Doe")
        XCTAssertTrue(cellViewModel.body.value == "Lorem Ipsum")
        XCTAssertTrue(cellViewModel.tags.value == "tag1, tag2, tag3")
        XCTAssertTrue(cellViewModel.favoriteImage.value == Assets.Icons.starCircleFill)
    }

}
