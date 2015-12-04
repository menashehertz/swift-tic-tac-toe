//
//  WinTacticTests.swift
//  TicTacToe
//
//  Created by Joshua Smith on 11/30/15.
//  Copyright © 2015 iJoshSmith. All rights reserved.
//

import XCTest

class WinTacticTests: XCTestCase {
    
    func test_chooseWhereToPutMark_cannotWin_returnsNil() {
        XCTAssertNil(WinTactic().chooseWhereToPutMark(.O, onGameBoard: board3x3(
            "X O",
            "O X",
            "X  ")))
    }
    
    func test_chooseWhereToPutMark_rowCanWin_returnsPositionInRow() {
        let position = WinTactic().chooseWhereToPutMark(.X, onGameBoard: board3x3(
            "XX ",
            "O  ",
            "X O"))
        if let position = position {
            XCTAssertTrue(position == (row: 0, column: 2))
        }
        else {
            XCTFail("Did not detect winning row.")
        }
    }
    
    func test_chooseWhereToPutMark_columnCanWin_returnsPositionInColumn() {
        let position = WinTactic().chooseWhereToPutMark(.O, onGameBoard: board3x3(
            "XOX",
            " O ",
            "X  "))
        if let position = position {
            XCTAssertTrue(position == (row: 2, column: 1))
        }
        else {
            XCTFail("Did not detect winning column.")
        }
    }
    
    func test_chooseWhereToPutMark_topLeftToBottomRightDiagonalCanWin_returnsPositionInDiagonal() {
        let position = WinTactic().chooseWhereToPutMark(.X, onGameBoard: board3x3(
            "XXO",
            "O  ",
            "  X"))
        if let position = position {
            XCTAssertTrue(position == (row: 1, column: 1))
        }
        else {
            XCTFail("Did not detect winning diagonal.")
        }
    }
    
    func test_chooseWhereToPutMark_bottomLeftToTopRightDiagonalCanWin_returnsPositionInDiagonal() {
        let position = WinTactic().chooseWhereToPutMark(.O, onGameBoard: board3x3(
            "X  ",
            "XO ",
            "O X"))
        if let position = position {
            XCTAssertTrue(position == (row: 0, column: 2))
        }
        else {
            XCTFail("Did not detect winning diagonal.")
        }
    }
    
    func test_chooseWhereToPutMark_onlyOtherPlayerCanWin_returnsNil() {
        XCTAssertNil(WinTactic().chooseWhereToPutMark(.O, onGameBoard: board3x3(
            "XX ",
            "X O",
            "O  ")))
    }
    
    func test_chooseWhereToPutMark_bothPlayersCanWin_returnsPositionForCorrectPlayer() {
        let position = WinTactic().chooseWhereToPutMark(.X, onGameBoard: board3x3(
            "OO ",
            " XX",
            "   "))
        if let position = position {
            XCTAssertTrue(position == (row: 1, column: 0))
        }
        else {
            XCTFail("Did not detect correct winning row.")
        }
    }
}