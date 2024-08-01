//
//  Likable.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import Foundation

protocol Likable {}

protocol Commentable {}

protocol Interactable: Likable, Commentable {}
