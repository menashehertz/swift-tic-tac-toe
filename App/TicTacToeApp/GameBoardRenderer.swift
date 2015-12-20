//
//  GameBoardRenderer.swift
//  TicTacToeApp
//
//  Created by Joshua Smith on 12/20/15.
//  Copyright © 2015 iJoshSmith. All rights reserved.
//

import TicTacToe
import UIKit

/** Draws a game board on the screen. */
final class GameBoardRenderer {
    
    init(context: CGContextRef, gameBoard: GameBoard, layout: GameBoardLayout) {
        self.context = context
        self.gameBoard = gameBoard
        self.layout = layout
    }
    
    func renderWithWinningPositions(winningPositions: [GameBoard.Position]?) {
        renderPlatformBorder()
        renderPlatform()
        renderGridLines()
        renderMarks()
        if let winningPositions = winningPositions {
            renderWinningLineThroughPositions(winningPositions)
        }
    }
    
    private let context: CGContextRef
    private let gameBoard: GameBoard
    private let layout: GameBoardLayout
}



// MARK: - Rendering routines

private extension GameBoardRenderer {
    struct Color {
        static let
        borderInner  = UIColor.darkGrayColor(),
        borderOuter  = UIColor.whiteColor(),
        gridLine     = UIColor.darkGrayColor(),
        markO        = UIColor.blueColor(),
        markX        = UIColor.greenColor(),
        platformFill = UIColor.whiteColor(),
        winningLine  = UIColor.redColor()
    }
    
    func renderPlatformBorder() {
        let
        lineCount = 2,
        lineWidth = GameBoardView.Thickness.platformBorder / CGFloat(lineCount),
        outerRect = layout.platformBorderRect,
        innerRect = outerRect.insetUniformlyBy(lineWidth)
        
        context.strokeRect(outerRect, color: Color.borderOuter, width: lineWidth)
        context.strokeRect(innerRect, color: Color.borderInner, width: lineWidth)
    }
    
    func renderPlatform() {
        context.fillRect(layout.platformRect, color: Color.platformFill)
    }
    
    func renderGridLines() {
        layout.gridLineRects.forEach {
            context.fillRect($0, color: Color.gridLine)
        }
    }
    
    func renderMarks() {
        gameBoard.marksAndPositions
            .filter  { $0.mark != nil }
            .map     { (mark: $0.mark!, cellRect: layout.cellRectAtPosition($0.position)) }
            .forEach { renderMark($0.mark, inRect: $0.cellRect) }
    }
    
    func renderMark(mark: Mark, inRect rect: CGRect) {
        let markRect = rect.insetUniformlyBy(GameBoardView.Thickness.markMargin)
        switch mark {
        case .X: renderX(inRect: markRect)
        case .O: renderO(inRect: markRect)
        }
    }
    
    func renderX(inRect rect: CGRect) {
        context.strokeLineFrom(rect.topLeft, to: rect.bottomRight, color: Color.markX, width: GameBoardView.Thickness.mark, lineCap: .Round)
        context.strokeLineFrom(rect.bottomLeft, to: rect.topRight, color: Color.markX, width: GameBoardView.Thickness.mark, lineCap: .Round)
    }
    
    func renderO(inRect rect: CGRect) {
        context.strokeEllipseInRect(rect, color: Color.markO, width: GameBoardView.Thickness.mark)
    }
    
    func renderWinningLineThroughPositions(positions: [GameBoard.Position]) {
        let (startPoint, endPoint) = layout.pointsForWinningLineThroughPositions(positions)
        context.strokeLineFrom(startPoint, to: endPoint, color: Color.winningLine, width: GameBoardView.Thickness.winningLine, lineCap: .Round)
    }
}