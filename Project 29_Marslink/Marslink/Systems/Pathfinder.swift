/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

protocol PathfinderDelegate: class {
  func pathfinderDidUpdateMessages(pathfinder: Pathfinder)
}

private func delay(time: Double = 1, execute work: @escaping @convention(block) () -> Swift.Void) {
  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
    work()
  }
}

private func lewisMessage(text: String, interval: TimeInterval = 0) -> Message {
  let user = User(id: 2, name: "cpt.lewis")
  return Message(date: Date(timeIntervalSinceNow: interval), text: text, user: user)
}

class Pathfinder {
  
  weak var delegate: PathfinderDelegate?
  
  var messages: [Message] = {
    var arr = [Message]()
    arr.append(lewisMessage(text: "Mark, are you receiving me?", interval: -803200))
    arr.append(lewisMessage(text: "I think I left behind some ABBA, might help with the drive 😜", interval: -259200))
    return arr
    }() {
    didSet {
      delegate?.pathfinderDidUpdateMessages(pathfinder: self)
    }
  }
  
  func connect() {
    delay(time: 2.3) {
      self.messages.append(lewisMessage(text: "Liftoff in 3..."))
      delay {
        self.messages.append(lewisMessage(text: "2..."))
        delay {
          self.messages.append(lewisMessage(text: "1..."))
        }
      }
    }
  }
}
