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

class JournalEntryLoader {
  
  var entries = [JournalEntry]()
  
  func loadLatest() {
    let user = User(id: 1, name: "Mark Watney")
    let entries = [
      JournalEntry(
        date: Date(timeIntervalSinceNow: -1727283),
        text: "Ok I think I have this potato thing figured out. I'm using some of the leftover fuel from the landing thruster and basically lighting it on fire. The hydrogen and oxygen combine to make water. If I throttle the reaction I can let this run all day and generate enough water in the air to hydrate my potatos.\n\nThough, I'm basically igniting jet fuel in my living room.",
        user: user
      ),
      JournalEntry(
        date: Date(timeIntervalSinceNow: -1382400),
        text: "I blew up.\n\nMy potato hydration system was working perfectly, but I forgot to account for excess oxygen from the reaction. I ended up with 30% pure oxygen in the HAB. Where I'm making mini explosions. Oh did I mention I live here?\n\nI survived but the HAB is basically gone, along with all my potatos. The cold air instantly froze the ones I have, so there's that at least.",
        user: user
      ),
      JournalEntry(
        date: Date(timeIntervalSinceNow: -823200),
        text: "I figured out how to communicate with NASA! Years ago we sent a small probe called Pathfinder to Mars to poke at the sand a bit. The little rover only lasted a couple months, but I found it! All I had to do was swap the batteries and its as good as new.\n\nWith all this in place I can send pictures to NASA, maybe Johansen can tell me how to hack this thing?",
        user: user
      ),
      JournalEntry(
        date: Date(timeIntervalSinceNow: -259200),
        text: "Alright, its time for me to leave the HAB and make the several-thousand kilometer trek to the next landing site. The MAV is already there, so I'm going to try to launch this thing and intercept with Hermes. Sounds crazy, right?\n\nBut it's the last chance I've got.",
        user: user
      )
    ]
    self.entries = entries
  }
  
}
