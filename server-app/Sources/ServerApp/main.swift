/*--------------------------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
 *-------------------------------------------------------------------------------------------------------------*/
//stash queue 
import Foundation

actor Simple {

    // mutable state
    private var i: Int = 0
    func add(j: Int) {
         i += j
    }

    func getState() -> Int {
        i
    }
}

class WithRaceConditions {
    private var i: Int = 0

    func add(j: Int) async {
         i += j
    }

    func getState() async -> Int {
        i
    }
}

let s: Simple = Simple()
let race: WithRaceConditions = WithRaceConditions()
Task.detached {
    await withThrowingTaskGroup(of: Void.self) { group in
        for i: Int in 0..<10000 {
            group.addTask {
                    await race.add(j:i)
            }
        }
    }
}
Task.detached {
    await withThrowingTaskGroup(of: Void.self) { group in
        for i: Int in 0..<10000 {
            group.addTask {
                    await s.add(j:i)
            }
        }
    }
}

var j: Int = 0
for i: Int in 0..<10000 {
            j += i
        }
        print(j)

Thread.sleep(forTimeInterval: 15)
Task.detached {
    print("actor: \(await s.getState())")
    print("class: \(await race.getState())")
}

Thread.sleep(forTimeInterval: 2)

print("Dummy way to wait for something ")



