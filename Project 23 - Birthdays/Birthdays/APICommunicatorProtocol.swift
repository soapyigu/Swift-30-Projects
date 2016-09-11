//
//  APICommunicatorProtocol.swift
//  Birthdays
//
//  Created by dasdom on 28.03.15.
//  Copyright (c) 2015 Dominik Hauser. All rights reserved.
//

import Foundation

public protocol APICommunicatorProtocol {
  func getPeople() -> (NSError?, [PersonInfo]?)
  func postPerson(personInfo: PersonInfo) -> NSError?
}