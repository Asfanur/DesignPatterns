//: Playground - noun: a place where people can play

import UIKit

protocol ElectronicDevice {
    func on();
    func off();
    func volumeUp();
    func volumeDown();
}

protocol Command {
    func execute()
    func undo()
}

class Television:ElectronicDevice {
    var volume:Int = 0
    
    func on() {
        println("TV is on")
    }
    
    func off() {
        println("TV is off")
        
    }
    
    func volumeUp() {
        volume++
        println("TV volume is \(volume)")
        
    }
    
    func volumeDown() {
        volume--
        println("TV volume is \(volume)")
        
    }
}

class TurnTVOn:Command {
    let theDevice:ElectronicDevice
    required init(newDevice:ElectronicDevice) {
        theDevice = newDevice
    }
    
    func execute() {
        theDevice.on()
    }
    
    func undo() {
        theDevice.off()
    }
}

class TurnTVOff: Command {
    let theDevice:ElectronicDevice
    
    required init(newDevice:ElectronicDevice) {
        theDevice = newDevice;
    }
    
    func execute() {
        theDevice.off()
    }
    
    func undo() {
        theDevice.on()
    }
}

class TurnVolumeUP: Command {
    let theDevice:ElectronicDevice
    required init(newDevice:ElectronicDevice) {
        theDevice = newDevice
    }
    
    func execute() {
        theDevice.volumeUp()
    }
    
    func undo() {
        theDevice.volumeDown()
    }
}

class TurnVolumeDown: Command {
    let theDevice:ElectronicDevice
    required init(newDevice:ElectronicDevice) {
        theDevice = newDevice
    }
    
    func execute() {
        theDevice.volumeDown()
    }
    
    func undo() {
        theDevice.volumeUp()
    }
}

class DeviceButton {
    let command:Command
    required init(newCommand:Command) {
        command = newCommand
    }
    
    func pressed() {
        command.execute()
    }
    
    func undoPressed() {
        command.undo()
    }
}



struct CommandList<U:DeviceButton> {
    
    var array:[U] = []
    
    mutating func add(newObject:U) {
        newObject.pressed()
        self.array.append(newObject)
        
        
    }
    
    mutating func undo(){
        if let last = self.array.last {
            last.undoPressed()
            self.array.removeLast()
            
        }
    }
    
    subscript(index:Int) -> U {
        
        get {
            return self.array[index]
        }
    }
}


let electronicDevice:ElectronicDevice = Television()

var list:CommandList = CommandList<DeviceButton>()
var tvOn:Command  = TurnTVOn(newDevice:electronicDevice )
var tvOFF:Command = TurnTVOff(newDevice: electronicDevice)
let turnVolumeUP:Command =  TurnVolumeUP(newDevice: electronicDevice)

list.add(DeviceButton(newCommand: tvOn))
list.add(DeviceButton(newCommand: tvOFF))
list.add(DeviceButton(newCommand: turnVolumeUP))
list.add(DeviceButton(newCommand: turnVolumeUP))
list.add(DeviceButton(newCommand: turnVolumeUP))
list.undo()
list.undo()
list.undo()
list.undo()







