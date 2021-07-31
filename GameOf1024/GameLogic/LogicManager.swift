//
//  LogicManager.swift
//  GameOf1024
//
//  Created by Kartik Kanungo on 31/07/21.
//

import Foundation

/*
 DRAFT(In Progress)
 
 Init: Provide a 4 X 4 matrix at any state of the game
 
 Input: Direction and the matrix with the current state of the game
 OutPut: Matrix after executing the direction move
 
 Responsibilites of logic manager
 1. On getting direction as an input
    1. remove spaces (spaces means matrix value = 0)
    2. Check the neighbours value
        1. if same merge and add
            1. while merging source to destination:
                Destination = source + destination
                source = 0
        2. else do not do anything
    3. Remove spaces and Continue till the time when merge is not needed
 
 */

