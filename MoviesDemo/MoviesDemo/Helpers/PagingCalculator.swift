//
//  PagingCalculator.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

// MARK: - PagingCalculator

protocol PagingCalculable {
    func shouldLoadMoreItems(atRow row: Int,
                             numberOfItimes: Int,
                             isLastPageReached: Bool) -> Bool
    func isLastPageReached(numberOfNewItems: Int, dataPerPage: Int) -> Bool
    func calculatingCurrentPage(_ currentPage: Int, isLastPage: Bool) -> Int
}

struct PagingCalculator: PagingCalculable {
    func shouldLoadMoreItems(atRow row: Int,
                             numberOfItimes: Int,
                             isLastPageReached: Bool) -> Bool {
        let isLastRow =  (row == numberOfItimes - 1)
        return isLastRow && !isLastPageReached
    }
    
    func isLastPageReached(numberOfNewItems: Int, dataPerPage: Int) -> Bool {
        return numberOfNewItems < dataPerPage
    }
    
    func calculatingCurrentPage(_ currentPage: Int, isLastPage: Bool) -> Int {
        return isLastPage ? currentPage : currentPage + 1
    }
}
