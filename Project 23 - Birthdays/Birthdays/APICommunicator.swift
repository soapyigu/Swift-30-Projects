//
//  APICommunicator.swift
//  Birthdays
//
//  Created by dasdom on 28.03.15.
//  Copyright (c) 2015 Dominik Hauser. All rights reserved.
//

import UIKit

public struct APICommunicator: APICommunicatorProtocol {
  public func getPeople() -> (NSError?, [PersonInfo]?) {
    return (nil, nil)
  }
  
  public func postPerson(personInfo: PersonInfo) -> NSError? {
    return nil
  }
}