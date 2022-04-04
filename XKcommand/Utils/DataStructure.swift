//
//  DataStructure.swift
//  XKcommand
//
//  Created by Tao Zong on 2/10/22.
//

import Foundation

public struct RingBuffer<T> {
    private var array: [T?]
    private var frontIndex: Int = 0
    private var backIndex: Int = 0
    
    public init(capacity: Int) {
        self.array = [T?](repeating: nil, count: capacity)
    }
    
    public mutating func clear() {
        for i in 0..<self.array.count {
            self.array[i] = nil
        }
        self.frontIndex = 0
        self.backIndex = 0
    }
    
    @discardableResult
    public mutating func push_back(_ element: T) -> Bool {
        if (isFull) {
            return false
        }
        array[(backIndex + array.count) % array.count] = element
        backIndex += 1
        return true
    }
    
    @discardableResult
    public mutating func push_front(_ element: T) -> Bool {
        if (isFull) {
            return false
        }
        frontIndex -= 1
        array[(frontIndex + array.count) % array.count] = element
        return true
    }
    
    @discardableResult
    public mutating func pop_front() -> T? {
        if (isEmpty) {
            return nil
        }
        let element = array[(frontIndex + array.count) % array.count]
        frontIndex += 1
        return element
    }
    
    @discardableResult
    public mutating func pop_back() -> T? {
        if (isEmpty) {
            return nil
        }
        backIndex -= 1
        return array[(backIndex + array.count) % array.count]
    }
    
    public var front: T? {
        return isEmpty ? nil : array[(frontIndex + array.count) % array.count]
    }
    
    public var back: T? {
        return isEmpty ? nil : array[(backIndex - 1 + array.count) % array.count]
    }
    
    public var count: Int {
        return backIndex - frontIndex
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var isFull: Bool {
        return array.count - count == 0
    }
}


public protocol DoubleConvertible: Comparable {
    var doubleValue: Double { get }
}

public extension BinaryInteger where Self: DoubleConvertible {
    var doubleValue: Double {
        return Double(self)
    }
}

public extension BinaryFloatingPoint where Self: DoubleConvertible {
    var doubleValue: Double {
        return Double(self)
    }
}

extension Int: DoubleConvertible { }
extension Double: DoubleConvertible { }
extension Float: DoubleConvertible { }

public struct RunningStatistics<T: Numeric> where T: DoubleConvertible {
    let windowSize: Int
    private var window: RingBuffer<T>
    private var maxWindow: RingBuffer<(Int, T)>
    private var minWindow: RingBuffer<(Int, T)>
    public private(set) var count: Int = 0
    public private(set) var average: Double = 0
    public private(set) var variance: Double = 0
    public private(set) var min: T = 0
    public private(set) var max: T = 0
    public var deviation: Double {
        return sqrt(variance)
    }
    
    init(windowSize: Int) {
        self.windowSize = windowSize
        self.window = RingBuffer(capacity: windowSize)
        self.maxWindow = RingBuffer(capacity: windowSize)
        self.minWindow = RingBuffer(capacity: windowSize)
    }
    
    var isWarmedUp: Bool {
        return count >= windowSize
    }
    
    mutating public func reset() {
        count = 0
        average = 0
        variance = 0
        min = 0
        max = 0
        window.clear()
        maxWindow.clear()
        minWindow.clear()
    }
    
    mutating public func update(_ newValue: T) {
        var oldValue: T = 0
        if window.isFull {
            oldValue = window.pop_front()!
        }
        window.push_back(newValue)
        let oldAvg = self.average
        let delta = isWarmedUp ? oldValue.doubleValue : oldAvg
        let newAvg = oldAvg + (newValue.doubleValue - delta).doubleValue / window.count.doubleValue
        self.average = newAvg
        self.variance += (newValue.doubleValue - delta) *
        (newValue.doubleValue - newAvg + delta - oldAvg) / Double(windowSize - 1)
        while let (idx, _) = maxWindow.front, idx <= count - windowSize {
            maxWindow.pop_front()
        }
        while let (_, val) = maxWindow.back, newValue >= val {
            maxWindow.pop_back()
        }
        maxWindow.push_back((count, newValue))
        max = maxWindow.front!.1
        while let (idx, _) = minWindow.front, idx <= count - windowSize {
            minWindow.pop_front()
        }
        while let (_, val) = minWindow.back, newValue <= val {
            minWindow.pop_back()
        }
        minWindow.push_back((count, newValue))
        min = minWindow.front!.1
        count += 1
    }
}

enum Bit { case zero, one }

func getBit(_ i: Int, of uint8: UInt8) -> Bit {
      let first8PowersOf2 = (0...7).map { return UInt8(1) << $0 }
      return (uint8 & first8PowersOf2[i] != 0) ? Bit.one : Bit.zero
}

func setBitToOne(_ i: Int, of uint8: UInt8) -> UInt8 {
    return uint8 | (1 << i)
}

func setBitToZero(_ i: Int, of uint8: UInt8) -> UInt8 {
    return uint8 & ~(1 << i)
}

func setBit(_ b: Bool, index i: Int, of uinit8: UInt8) -> UInt8 {
    if b {
        return setBitToOne(i, of: uinit8)
    } else {
        return setBitToZero(i, of: uinit8)
    }
}
