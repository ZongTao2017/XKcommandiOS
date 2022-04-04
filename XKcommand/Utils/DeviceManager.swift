//
//  BluetoothHelper.swift
//  XKcommand
//
//  Created by Tao Zong on 2/10/22.
//

import Foundation
import CoreBluetooth
import CoreMIDI
import SwiftUI

enum BLEUUID {
    static let CONTROLLER_SERVICE = CBUUID(string: "02A8AF3E-C199-4735-BACE-FA8E9F74803E")
    static let DEVICE_INFO = CBUUID(string: "02A8AF3E-C001-4735-BACE-FA8E9F74803E")
    static let USER_SETTINGS = CBUUID(string: "02A8AF3E-C002-4735-BACE-FA8E9F74803E")
    static let CHANNEL_STATUS = CBUUID(string: "02A8AF3E-C003-4735-BACE-FA8E9F74803E")
    static let BUTTON_1_STATUS = CBUUID(string: "02A8AF3E-C010-4735-BACE-FA8E9F74803E")
    static let BUTTON_2_STATUS = CBUUID(string: "02A8AF3E-C011-4735-BACE-FA8E9F74803E")
    static let BUTTON_3_STATUS = CBUUID(string: "02A8AF3E-C012-4735-BACE-FA8E9F74803E")
    static let BUTTON_4_STATUS = CBUUID(string: "02A8AF3E-C013-4735-BACE-FA8E9F74803E")
    static let BUTTON_5_STATUS = CBUUID(string: "02A8AF3E-C014-4735-BACE-FA8E9F74803E")
    static let BUTTON_6_STATUS = CBUUID(string: "02A8AF3E-C015-4735-BACE-FA8E9F74803E")
    static let BUTTON_7_STATUS = CBUUID(string: "02A8AF3E-C016-4735-BACE-FA8E9F74803E")
    static let BUTTON_8_STATUS = CBUUID(string: "02A8AF3E-C017-4735-BACE-FA8E9F74803E")
    static let SENSOR_1_STATUS = CBUUID(string: "02A8AF3E-C018-4735-BACE-FA8E9F74803E")
    static let SENSOR_2_STATUS = CBUUID(string: "02A8AF3E-C019-4735-BACE-FA8E9F74803E")
    static let SENSOR_3_STATUS = CBUUID(string: "02A8AF3E-C01A-4735-BACE-FA8E9F74803E")
}

// MARK: - Device state enumeration

enum DeviceState: Equatable {
    /// Device is not currently reachable.
    case offline
    /// Device has been discovered in the previous bluetooth scan
    case discovered
    /// Establishing bluetooth connection to the device
    case connecting
    /// Device connected, reading required information
    case initializing
    /// Device is connected and ready to use
    case ready
    /// Disconnecting from the device
    case disconnecting(Error?)
    /// Device is disconnected, a change to another state is imminent.
    case disconnected(Error?)
    
    /// Allowed state transitions.
    func canTransitionTo(_ target: DeviceState) -> Bool {
        switch (self, target) {
        case (.offline, .discovered),
            (.discovered, .offline),
            (.discovered, .connecting),
            (.connecting, .initializing),
            (.connecting, .offline),
            (.connecting, .disconnecting(_)),
            (.connecting, .disconnected(_)),
            (.initializing, .ready),
            (.initializing, .offline),
            (.initializing, .disconnecting(_)),
            (.initializing, .disconnected(_)),
            (.ready, .offline),
            (.ready, .disconnecting(_)),
            (.ready, .disconnected(_)),
            (.disconnecting(_), .offline),
            (.disconnecting(_), .discovered),
            (.disconnecting(_), .disconnected(_)),
            (.disconnected(_), .offline),
            (.disconnected(_), .discovered),
            (.disconnected(_), .connecting):
            return true
        default:
            return false
        }
    }
    
    /// Equality tests that ignores associated values if any.
    static func == (a: DeviceState, b: DeviceState) -> Bool {
        switch (a, b) {
        case (.offline, .offline),
            (.discovered, .discovered),
            (.connecting, .connecting),
            (.initializing, .initializing),
            (.ready, .ready),
            (.disconnecting(_), .disconnecting(_)),
            (.disconnected(_), .disconnected(_)):
            return true
        default:
            return false
        }
    }
    
    var asString: String {
        switch self {
        case .discovered:
            return "ONLINE"
        default:
            return String(describing: self).capitalized
        }
    }
}

/// The mode and parameters for bluetooth scan
enum DeviceScanMode {
    /// normal scan for the given duration in seconds
    case oneshot(TimeInterval)
    
    /// continuously observing RSSI for advertising devices
    case continuous
    
    /// default scan mode when bluetooth powers on
    static let defaultMode: DeviceScanMode = .oneshot(1)
}

/// The state for bluetooth scan
fileprivate enum DeviceScanState {
    /// No scan is in progress
    case off
    
    /// Scan is in progress with the given mode. An optional timer is scheduled to stop the scan
    case scanning(DeviceScanMode, Timer?)
    
    /// Scan in the given mode is schedule when bluetooth is ready to use
    case pending(DeviceScanMode)
    
    /// Whether we're in the "scanning" state
    var isScanning: Bool {
        switch self {
        case .scanning(_, _):
            return true
        default:
            return false
        }
    }
    
    /// Return a pending state with the same scanning mode if the current state is scanning.
    /// Otherwise, return the same state.
    func toPending() -> DeviceScanState {
        switch self {
        case .scanning(let mode, _):
            return .pending(mode)
        default:
            return self
        }
    }
}

// MARK: - Device Manager and device info

class ButtonInfo: NSObject, NSCoding, ObservableObject {
    var buttonId: Int
    var showType: Int = 3 {
        willSet {
            objectWillChange.send()
        }
    }
    var showIcon: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    var showImage: UIImage = UIImage() {
        willSet {
            objectWillChange.send()
        }
    }
    var showName: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    var sensorName: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    var bytes: [UInt8] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    var pressed: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    var illuminated: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    var momentary: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    var sync: Bool = false {
        willSet {
            if newValue {
                for (index, channel) in channels.enumerated() {
                    if channel {
                        actions[index] = 1
                    }
                }
            }
            objectWillChange.send()
        }
    }
    var dim: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    var channels: [Bool] = [false, false, false, false, false, false, false, false] {
        willSet {
            objectWillChange.send()
        }
    }
    var actions: [Int] = [1, 1, 1, 1, 1, 1, 1, 1] {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(_ buttonId: Int) {
        self.buttonId = buttonId
        self.showName = String(format: "Button %d", buttonId)
        self.sensorName = String(format: "Sensor %d", buttonId)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(buttonId, forKey:"buttonId")
        coder.encode(showType, forKey:"showType")
        coder.encode(showIcon, forKey:"showIcon")
        coder.encode(showImage, forKey:"showImage")
        coder.encode(showName, forKey:"showName")
        coder.encode(pressed, forKey:"pressed")
        coder.encode(illuminated, forKey:"illuminated")
        coder.encode(momentary, forKey:"momentary")
        coder.encode(sync, forKey:"sync")
        coder.encode(dim, forKey:"dim")
        coder.encode(channels, forKey:"channels")
        coder.encode(actions, forKey:"actions")
    }
    
    required init (coder aDecoder: NSCoder) {
        self.buttonId = aDecoder.decodeInteger(forKey: "buttonId")
        self.showType = aDecoder.decodeInteger(forKey: "showType")
        self.showIcon = aDecoder.decodeObject(forKey: "showIcon") as! String
        self.showImage = aDecoder.decodeObject(forKey: "showImage") as! UIImage
        self.showName = aDecoder.decodeObject(forKey: "showName") as! String
        self.pressed = aDecoder.decodeBool(forKey: "pressed")
        self.illuminated = aDecoder.decodeBool(forKey: "illuminated")
        self.momentary = aDecoder.decodeBool(forKey: "momentary")
        self.sync = aDecoder.decodeBool(forKey: "sync")
        self.dim = aDecoder.decodeBool(forKey: "dim")
        self.channels = aDecoder.decodeObject(forKey: "channels") as! [Bool]
        self.actions = aDecoder.decodeObject(forKey: "actions") as! [Int]
    }
}

class SystemInfo: NSObject, NSCoding, ObservableObject {
    var bytes: [UInt8] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    var cutoffInputVoltage: Float = 12.0 {
        willSet {
            objectWillChange.send()
        }
    }
    var bluetoothAutoOff: Bool = true {
        willSet {
            objectWillChange.send()
        }
    }
    var bluetoothOffTime: Int = 30 {
        willSet {
            objectWillChange.send()
        }
    }
    var temperatureUnit: Bool = true {
        willSet {
            objectWillChange.send()
        }
    }
    var buttonColor: UIColor = UIColor.blue {
        willSet {
            objectWillChange.send()
        }
    }
    var buttonWarningColor: UIColor = UIColor.red {
        willSet {
            objectWillChange.send()
        }
    }
    var dimPercent: Int = 60 {
        willSet {
            objectWillChange.send()
        }
    }
    var controllerName: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    var shortName: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    var volt: Float = 0.0 {
        willSet {
            objectWillChange.send()
        }
    }
    var amp: Float = 0.0 {
        willSet {
            objectWillChange.send()
        }
    }
    var temperature: Int = Int.min {
        willSet {
            objectWillChange.send()
        }
    }
    
    override init() {}
    
    func encode(with coder: NSCoder) {
        coder.encode(cutoffInputVoltage, forKey:"cutoffInputVoltage")
        coder.encode(bluetoothAutoOff, forKey:"bluetoothAutoOff")
        coder.encode(bluetoothOffTime, forKey:"bluetoothOffTime")
        coder.encode(temperatureUnit, forKey:"temperatureUnit")
        coder.encode(buttonColor, forKey:"buttonColor")
        coder.encode(buttonWarningColor, forKey:"buttonWarningColor")
        coder.encode(dimPercent, forKey:"dimPercent")
        coder.encode(controllerName, forKey:"controllerName")
        coder.encode(shortName, forKey:"shortName")
    }
    
    required init (coder aDecoder: NSCoder) {
        self.cutoffInputVoltage = aDecoder.decodeFloat(forKey: "cutoffInputVoltage")
        self.bluetoothAutoOff = aDecoder.decodeBool(forKey: "bluetoothAutoOff")
        self.bluetoothOffTime = aDecoder.decodeInteger(forKey: "bluetoothOffTime")
        self.temperatureUnit = aDecoder.decodeBool(forKey: "temperatureUnit")
        self.buttonColor = aDecoder.decodeObject(forKey: "buttonColor") as! UIColor
        self.buttonWarningColor = aDecoder.decodeObject(forKey: "buttonWarningColor") as! UIColor
        self.dimPercent = aDecoder.decodeInteger(forKey: "dimPercent")
        self.controllerName = aDecoder.decodeObject(forKey: "controllerName") as! String
        self.shortName = aDecoder.decodeObject(forKey: "shortName") as! String
    }
}

class ChannelInfo : NSObject, NSCoding, ObservableObject {
    var channelId: Int
    var channelName: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    var maxOutputCurrent: Int = 10 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(_ channelId: Int) {
        self.channelId = channelId
        self.channelName = String(format: "Channel %d", channelId)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(channelId, forKey:"channelId")
        aCoder.encode(channelName, forKey:"channelName")
        aCoder.encode(maxOutputCurrent, forKey:"maxOutputCurrent")
    }
    
    required init (coder aDecoder: NSCoder) {
        self.channelId = aDecoder.decodeInteger(forKey: "channelId")
        self.channelName = aDecoder.decodeObject(forKey: "channelName") as! String
        self.maxOutputCurrent = aDecoder.decodeInteger(forKey: "maxOutputCurrent")
    }
}

class DeviceInfo: NSObject, NSCoding, ObservableObject {
    /// The anonymised UUID of the device got from the peripheral
    let uuid: String
    
    /// The current state of the device
    var state: DeviceState = .offline {
        willSet {
            objectWillChange.send()
        }
    }
    var systemInfo: SystemInfo = SystemInfo() {
        willSet {
            objectWillChange.send()
        }
    }
    var channels: [ChannelInfo] = [ChannelInfo(1), ChannelInfo(2), ChannelInfo(3), ChannelInfo(4), ChannelInfo(5), ChannelInfo(6), ChannelInfo(7), ChannelInfo(8)]
    var channelBytes: [UInt8] = []
    var buttons: [ButtonInfo] = [ButtonInfo(1), ButtonInfo(2), ButtonInfo(3), ButtonInfo(4), ButtonInfo(5), ButtonInfo(6), ButtonInfo(7), ButtonInfo(8)]
    var sensors: [ButtonInfo] = [ButtonInfo(1), ButtonInfo(2), ButtonInfo(3)]
    
    var isChanging: Bool = true {
        willSet {
            objectWillChange.send()
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        let device = object as! DeviceInfo
        return self.uuid == device.uuid
    }
    
    /// Update the current state of the device.
    fileprivate func setState(_ newState: DeviceState) {
        DispatchQueue.main.async {
            let prevState = self.state
            if (prevState == newState) {
                return
            }
            
            // Check the state transision graph. For now, we just log the error if the
            // transistion is disallowed and proceed with the transistion.
            if (!prevState.canTransitionTo(newState)) {
                print("Invalid state transition [\(prevState)] -> [\(newState)] for \(self.uuid)")
            }
            
            // Preserve error message when transitioning from disconnecting to disconnected
            switch (prevState, newState) {
            case (.disconnecting(let error), .disconnected(nil)) where error != nil:
                self.state = .disconnected(error)
            default:
                self.state = newState
            }
            
            // clear other runtime states when transitioning into offline state
            if (newState == .offline) {
                self.peripheral = nil
                self.button1StatusChar = nil
                self.button2StatusChar = nil
                self.button3StatusChar = nil
                self.button4StatusChar = nil
                self.button5StatusChar = nil
                self.button6StatusChar = nil
                self.button7StatusChar = nil
                self.button8StatusChar = nil
                self.lastRssiUpdate = nil
                self.rssiSamples.reset()
            }
            
            postNotification(.xkDeviceStatus)
            self.objectWillChange.send()
        }
    }
    
    /// The system bluetooth peripheral device
    fileprivate var peripheral: CBPeripheral?
    
    fileprivate weak var deviceInfoChar: CBCharacteristic?
    fileprivate weak var userSettingChar: CBCharacteristic?
    fileprivate weak var channelStatusChar: CBCharacteristic?
    fileprivate weak var button1StatusChar: CBCharacteristic?
    fileprivate weak var button2StatusChar: CBCharacteristic?
    fileprivate weak var button3StatusChar: CBCharacteristic?
    fileprivate weak var button4StatusChar: CBCharacteristic?
    fileprivate weak var button5StatusChar: CBCharacteristic?
    fileprivate weak var button6StatusChar: CBCharacteristic?
    fileprivate weak var button7StatusChar: CBCharacteristic?
    fileprivate weak var button8StatusChar: CBCharacteristic?
    fileprivate weak var sensor1StatusChar: CBCharacteristic?
    fileprivate weak var sensor2StatusChar: CBCharacteristic?
    fileprivate weak var sensor3StatusChar: CBCharacteristic?
    
    /// The timestamp when the RSSI was updated last time
    private(set) var lastRssiUpdate: Date?
    
    /// Internal RSSI sample buffer
    private var rssiSamples = RunningStatistics<Double>(windowSize: 20)
    
    /// Called when a new RSSI sample arrives. It update the internal statistics and the timestamp.
    /// Also sends notifications to listeners
    fileprivate func updateRssi(_ rssi: NSNumber) {
        rssiSamples.update(rssi.doubleValue)
        lastRssiUpdate = Date()
    }
    
    func getSignal() -> Float {
        let minRssi: Double = -70, maxRssi: Double = -55
        return clamp(Float(rssi - minRssi) / Float(maxRssi - minRssi), 0, 1)
    }
    
    static let minRssiValue: Double = -128
    
    /// Return the RSSI value for the device, or nil if the device is disconnected
    var rssi: Double {
        return state == .offline ? DeviceInfo.minRssiValue : rssiSamples.average
    }
    
    init(uuid: UUID) {
        self.uuid = uuid.uuidString
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(uuid, forKey:"uuid")
        coder.encode(systemInfo, forKey:"systemInfo")
        coder.encode(buttons, forKey:"buttons")
        coder.encode(channels, forKey:"channels")
        coder.encode(sensors, forKey:"sensors")
    }
    
    required init (coder aDecoder: NSCoder) {
        self.uuid = aDecoder.decodeObject(forKey: "uuid") as! String
        self.systemInfo = aDecoder.decodeObject(forKey: "systemInfo") as! SystemInfo
        self.buttons = aDecoder.decodeObject(forKey: "buttons") as! [ButtonInfo]
        self.channels = aDecoder.decodeObject(forKey: "channels") as! [ChannelInfo]
        self.sensors = aDecoder.decodeObject(forKey: "sensors") as! [ButtonInfo]
    }
}

/// Helper function to post device-related notification
func postNotification(_ name: Notification.Name, object: Any? = nil) {
    DispatchQueue.main.async {
        NotificationCenter.default.post(name: name, object: object)
    }
}

/// Device manager that manages the livecycle of all devices.
class DeviceManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    private var cm: CBCentralManager!
    private var queue: DispatchQueue!
    private(set) var pairedDevices: [String: DeviceInfo] = [String: DeviceInfo]()
    private(set) var knownDevices: [String: DeviceInfo] = [String: DeviceInfo]()
    private var activeDevice: DeviceInfo? = DeviceInfo(uuid: UUID())
    private(set) var selectedDeviceId: String? = nil
    private var scanState: DeviceScanState = .off
    private var scanTimer: Timer?
    
    static var `default`: DeviceManager = {
        print("Building the default device manager")
        return DeviceManager()
    }()
    
    var activeDeviceId: String? {
        guard let dev = activeDevice, dev.state == .ready else { return nil }
        return dev.uuid
    }
    
    var isScanning: Bool {
        return scanState.isScanning
    }
    
    var isBluetoothOn: Bool {
        return cm.state == .poweredOn
    }
    
    override init() {
        super.init()
        self.queue = DispatchQueue(label: "DMQueue", qos: .utility)
        self.cm = CBCentralManager(delegate: self, queue: queue)
        loadPairedDevices()
    }
    
    // MARK: - Device discovery and live cycle management
    
    func getDevice(_ identifier: UUID) -> DeviceInfo {
        if let dev = knownDevices[identifier.uuidString] {
            return dev
        } else {
            let newDev = DeviceInfo(uuid: identifier)
            knownDevices[identifier.uuidString] = newDev
            print("Found new device \(identifier)")
            postNotification(.xkDeviceStatus)
            return newDev
        }
    }
    
    func removeDevice(_ device: DeviceInfo) {
        selectedDeviceId = nil
        disconnectDevice(device)
        pairedDevices.removeValue(forKey: device.uuid)
        knownDevices.removeValue(forKey: device.uuid)
        savePairedDevicesToFile()
        postNotification(.xkDeviceStatus)
    }
    
    /// Disconnect the given device and change it to "disconnecting" state
    func disconnectDevice(_ device: DeviceInfo, error: Error? = nil) {
        if let peripheral = device.peripheral,
           peripheral.state == .connected || peripheral.state == .connecting,
           cm.state == .poweredOn {
            cm.cancelPeripheralConnection(peripheral)
            device.setState(.disconnecting(error))
        }
    }
    
    /// Disconnect the current active device
    func unsetActiveDevice() {
        if let dev = activeDevice {
            disconnectDevice(dev)
            activeDevice = nil
        }
    }
    
    /// Set a device as the active one by start connecting to it.
    /// The current active device will be disconnected first.
    func setActiveDevice(_ device: DeviceInfo) {
        // if another device is currently connected, disconnect it first
        if let currDev = activeDevice, currDev.uuid != device.uuid {
            unsetActiveDevice()
        }
        
        // update active device and connect to it if necessary
        activeDevice = device
        DispatchQueue.main.async {
            self.activeDevice?.isChanging.toggle()
        }
        
        if let peripheral = device.peripheral, peripheral.state != .connected && peripheral.state != .connecting, cm.state == .poweredOn {
            device.setState(.connecting)
            cm.connect(peripheral, options: nil)
        }
    }
    
    /// Move a device to "disconnected" state and try to reconnect if there's an error
    private func tryReconnect(device dev: DeviceInfo, onError error: Error?) {
        dev.setState(.disconnected(error))
        if let e = error {
            print(dev.uuid, e)
            if (dev.uuid == selectedDeviceId) {
                setActiveDevice(dev)
            }
        }
    }
    
    func getActiveDevice() -> DeviceInfo {
        return activeDevice ?? DeviceInfo(uuid: UUID())
    }
    
    func getChannelInfo(_ channelId: Int) -> ChannelInfo {
        return activeDevice!.channels[channelId - 1]
    }
    
    func getButtonInfo(_ buttonId: Int) -> ButtonInfo {
        return activeDevice!.buttons[buttonId - 1]
    }
    
    func getSensorInfo(_ buttonId: Int) -> ButtonInfo {
        return activeDevice!.sensors[buttonId - 1]
    }
    
    func getSystemInfo() -> SystemInfo {
        return activeDevice!.systemInfo
    }
    
    func checkIfHasDim() -> Bool {
        for sensor in activeDevice!.sensors {
            if sensor.dim {
                return true
            }
        }
        return false
    }
    
    /// Set the UUID of the device to connect to
    func setSelectedDevice(newId: String?) {
        let changed = selectedDeviceId != newId
        
        // update selected device id
        selectedDeviceId = newId
        guard let uuid = newId else {
            unsetActiveDevice()
            return
        }
        
        if (changed) {
            DispatchQueue.main.async {
                self.activeDevice?.isChanging.toggle()
                self.setActiveDevice(self.pairedDevices[uuid]!)
            }
        }
    }
    
    /// Start scanning for devices using the given scan mode.
    func startScan(mode: DeviceScanMode) {
        // Postpond scanning if the device is not ready
        if (cm.state != .poweredOn) {
            scanState = .pending(mode)
            return
        }
        
        // Stop current scan if necessary
        if (scanState.isScanning) {
            stopScan()
        }
        
        // Setup stop timers and options
        var stopTimer: Timer? = nil
        var scanOptions: [String: Any]? = nil
        switch mode {
        case .oneshot(let duration):
            // oneshot mode, schedule stop timer
            stopTimer = Timer(timeInterval: duration, repeats: false) { _ in
                self.stopScan()
            }
            RunLoop.main.add(stopTimer!, forMode: .default)
        case .continuous:
            // continuous mode, set corresponding option to true
            scanOptions = [CBCentralManagerScanOptionAllowDuplicatesKey: NSNumber(booleanLiteral: true)]
        }
        
        // Start scanning
        scanState = .scanning(mode, stopTimer)
        cm.scanForPeripherals(withServices: [BLEUUID.CONTROLLER_SERVICE], options: scanOptions)
        print("Start scanning with mode \(mode)")
    }
    
    /// Stop the previous device scanning, if any
    func stopScan() {
        switch scanState {
        case .scanning(_, let timer):
            if let timer = timer {
                timer.invalidate()
            }
            if (cm.state == .poweredOn) {
                cm.stopScan()
            }
        default:
            break
        }
        scanState = .off
    }
    
    /// Start updating the RSSI for connected devices at the given interval
    private var rssiUpdateTimer: Timer? = nil
    func startRssiUpdate(withInterval interval: TimeInterval = 0.2) {
        rssiUpdateTimer = Timer(timeInterval: interval, repeats: true) { _ in
            self.queue.async {
                for dev in self.knownDevices {
                    if let peripheral = dev.value.peripheral, peripheral.state == .connected {
                        peripheral.readRSSI()
                    }
                }
            }
        }
        RunLoop.main.add(rssiUpdateTimer!, forMode: .default)
    }
    
    /// Stop updating the RSSI for connected devices
    func stopRssiUpdate() {
        if let timer = rssiUpdateTimer {
            timer.invalidate()
            rssiUpdateTimer = nil
        }
    }
    
    /// Clear all known states for unconnected devices and then start scanning
    /// This method will move disconnected devices that has not been detected
    /// for "expiry" seconds to "offline" state first (defined by the last
    /// RSSI update). Connected devices are not affected.
    func rediscover(scanMode: DeviceScanMode, expiry: TimeInterval) {
        for (_, dev) in self.knownDevices {
            if (dev.state == .initializing || dev.state == .ready) {
                // connected device: ignore
                continue
            }
//            if (dev.state == .connecting) {
//                // connecting device: cancel request first -- device might have gone away
//                disconnectDevice(dev)
//            }
            if dev.lastRssiUpdate == nil || dev.lastRssiUpdate!.timeIntervalSinceNow < -expiry {
                dev.setState(.offline)
            }
        }
        print("rediscover")
        self.startScan(mode: scanMode)
    }
    
    func startScanTimer() {
        rediscover(scanMode: .oneshot(0.5), expiry: 8)
        startRssiUpdate(withInterval: 0.1)
        scanTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            DeviceManager.default.rediscover(scanMode: .oneshot(0.5), expiry: 8)
            DeviceManager.default.startRssiUpdate(withInterval: 0.1)
        }
    }
    
    func stopScanTimer() {
        if let timer = scanTimer {
            timer.invalidate()
        }
        stopScan()
        stopRssiUpdate()
    }
    
    func sendCommand(_ data: Data, withChar commandChar: CBCharacteristic) {
        let peripheral = self.activeDevice?.peripheral
        peripheral?.writeValue(data, for: commandChar, type: CBCharacteristicWriteType.withResponse)
    }
    
    func readInfo(_ readChar: CBCharacteristic) {
        let peripheral = self.activeDevice?.peripheral
        peripheral?.readValue(for: readChar)
    }
    
    func updateInfo(_ updateChar: CBCharacteristic) {
        let peripheral = self.activeDevice?.peripheral
        peripheral?.setNotifyValue(true, for: updateChar)
    }
    
    func sendCommandAllOff() {
        for buttonInfo in activeDevice!.buttons {
            if buttonInfo.illuminated {
                buttonInfo.illuminated = false
                if buttonInfo.bytes.isEmpty {
                    break
                }
                buttonInfo.bytes[0] = setBit(false, index: 0, of: buttonInfo.bytes[0])
                buttonInfo.bytes[0] = setBit(true, index: 3, of: buttonInfo.bytes[0])
                buttonInfo.bytes[0] = setBit(false, index: 7, of: buttonInfo.bytes[0])
                DeviceManager.default.sendCommandButton(buttonInfo)
            }
        }
    }
    
    func sendCommandButton(_ buttonInfo: ButtonInfo) {
        if buttonInfo.bytes.isEmpty || self.activeDevice!.state != DeviceState.ready {
            return
        }
        switch (buttonInfo.buttonId) {
        case 1:
            sendCommand((Data)(buttonInfo.bytes), withChar: self.activeDevice!.button1StatusChar!)
        case 2:
            sendCommand((Data)(buttonInfo.bytes), withChar: self.activeDevice!.button2StatusChar!)
        case 3:
            sendCommand((Data)(buttonInfo.bytes), withChar: self.activeDevice!.button3StatusChar!)
        case 4:
            sendCommand((Data)(buttonInfo.bytes), withChar: self.activeDevice!.button4StatusChar!)
        case 5:
            sendCommand((Data)(buttonInfo.bytes), withChar: self.activeDevice!.button5StatusChar!)
        case 6:
            sendCommand((Data)(buttonInfo.bytes), withChar: self.activeDevice!.button6StatusChar!)
        case 7:
            sendCommand((Data)(buttonInfo.bytes), withChar: self.activeDevice!.button7StatusChar!)
        case 8:
            sendCommand((Data)(buttonInfo.bytes), withChar: self.activeDevice!.button8StatusChar!)
        default:
            return
        }
    }
    
    func sendCommandSensor(_ sensorInfo: ButtonInfo) {
        if sensorInfo.bytes.isEmpty || self.activeDevice!.state != DeviceState.ready {
            return
        }
        switch (sensorInfo.buttonId) {
        case 1:
            sendCommand((Data)(sensorInfo.bytes), withChar: self.activeDevice!.sensor1StatusChar!)
        case 2:
            sendCommand((Data)(sensorInfo.bytes), withChar: self.activeDevice!.sensor2StatusChar!)
        case 3:
            sendCommand((Data)(sensorInfo.bytes), withChar: self.activeDevice!.sensor3StatusChar!)
        default:
            return
        }
    }
    
    func sendCommandUserSetting(_ systemInfo: SystemInfo) {
        if systemInfo.bytes.isEmpty || self.activeDevice!.state != DeviceState.ready {
            return
        }
        sendCommand((Data)(systemInfo.bytes), withChar: self.activeDevice!.userSettingChar!)
    }
    
    func sendCommandChannels(_ channelInfo: ChannelInfo) {
        if self.activeDevice!.channelBytes.isEmpty || self.activeDevice!.state != DeviceState.ready {
            return
        }
        self.activeDevice!.channelBytes[channelInfo.channelId * 2 + 1] = UInt8(channelInfo.maxOutputCurrent * 10)
        sendCommand((Data)(self.activeDevice!.channelBytes), withChar: self.activeDevice!.channelStatusChar!)
    }
    
    
    // MARK: - CBCentralManagerDelegate members
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state changed to \(central.state.rawValue)")
        switch (central.state) {
        case .poweredOn:
            switch scanState {
            case .pending(let mode):
                // resume scanning
                startScan(mode: mode)
            case .off:
                // start default scanning
                startScan(mode: .defaultMode)
            default:
                break
            }
        default:
            // stop scanning and record pending state if necessary
            let newState = scanState.toPending()
            stopScan()
            scanState = newState
            unsetActiveDevice()
            
            // invalidate all device states
            for (_, dev) in knownDevices {
                dev.setState(.offline)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Assign peripheral and update RSSI
        let dev = getDevice(peripheral.identifier)
        if pairedDevices.keys.contains(dev.uuid) {
            pairedDevices[dev.uuid] = dev
        }
        if dev.systemInfo.shortName.isEmpty {
            dev.systemInfo.shortName = advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? ""
        }
        dev.peripheral = peripheral
        dev.updateRssi(RSSI)
        postNotification(.xkDeviceRSSI)
        
        
        // Move device to discovered state
        if (peripheral.state == .disconnected) {
            dev.setState(.discovered)
        }
        
        // connect automatically if the device is selected
        if (dev.uuid == selectedDeviceId || (pairedDevices.keys.contains(dev.uuid) &&
                                             (selectedDeviceId == nil || activeDevice!.state == DeviceState.offline))) {
            setSelectedDevice(newId: dev.uuid)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        let dev = getDevice(peripheral.identifier)
        tryReconnect(device: dev, onError: error)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        let dev = getDevice(peripheral.identifier)
        tryReconnect(device: dev, onError: error)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        // Move device to initializing state
        getDevice(peripheral.identifier).setState(.initializing)
        peripheral.delegate = self
        // If services has been discovered for the peripheral, call the callback directly
        if let _ = peripheral.services {
            self.peripheral(peripheral, didDiscoverServices: nil)
            return
        }
        // start service discovery
        peripheral.discoverServices([BLEUUID.CONTROLLER_SERVICE])
    }
    
    
    // MARK: - CBPeripheralDelegate members
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let e = error {
            print(peripheral.identifier, e);
            disconnectDevice(getDevice(peripheral.identifier), error: e)
            return
        }
        
        for svc in peripheral.services ?? [] {
            // If characteristics have been discovered for the service, call the callback directly
            if let _ = svc.characteristics {
                self.peripheral(peripheral, didDiscoverCharacteristicsFor: svc, error: nil)
                continue
            }
            // start characteristics discovery
            if (svc.uuid == BLEUUID.CONTROLLER_SERVICE) {
                print("discovering characteristics")
                peripheral.discoverCharacteristics([], for: svc)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        let device = getDevice(peripheral.identifier)
        if !pairedDevices.keys.contains(device.uuid) {
            pairedDevices[device.uuid] = device
            savePairedDevicesToFile()
            postNotification(.xkDeviceStatus)
        }
        if let e = error {
            print(peripheral.identifier, e);
            disconnectDevice(device, error: e)
            return
        }
        
        // Keep discovered characteristics objects in device info
        for char in service.characteristics ?? [] {
            switch char.uuid {
            case BLEUUID.DEVICE_INFO:
                device.deviceInfoChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.USER_SETTINGS:
                device.userSettingChar = char
                readInfo(char)
            case BLEUUID.CHANNEL_STATUS:
                device.channelStatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.BUTTON_1_STATUS:
                device.button1StatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.BUTTON_2_STATUS:
                device.button2StatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.BUTTON_3_STATUS:
                device.button3StatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.BUTTON_4_STATUS:
                device.button4StatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.BUTTON_5_STATUS:
                device.button5StatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.BUTTON_6_STATUS:
                device.button6StatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.BUTTON_7_STATUS:
                device.button7StatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.BUTTON_8_STATUS:
                device.button8StatusChar = char
                readInfo(char)
                updateInfo(char)
            case BLEUUID.SENSOR_1_STATUS:
                device.sensor1StatusChar = char
                readInfo(char)
            case BLEUUID.SENSOR_2_STATUS:
                device.sensor2StatusChar = char
                readInfo(char)
            case BLEUUID.SENSOR_3_STATUS:
                device.sensor3StatusChar = char
                readInfo(char)
            default:
                break
            }
        }
        
        // Move to ready state if all characteristics has been discovered
        device.setState(.ready)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        if let e = error {
            print(peripheral.identifier, e)
            return
        }
        // Update RSSI for a connected device
        let device = getDevice(peripheral.identifier)
        device.updateRssi(RSSI)
        postNotification(.xkCurrentRSSI)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let dev = getDevice(peripheral.identifier)
        let valueString = characteristic.value?.hexString()
        let bytes = [UInt8](characteristic.value!)
        var shouldSave: Bool = true
        DispatchQueue.main.async {
            switch characteristic.uuid {
            case BLEUUID.DEVICE_INFO:
                dev.systemInfo.volt = Float(bytes[4]) * 0.1
                dev.systemInfo.amp = (Float(bytes[6]) + Float(bytes[7]) * 0xff) * 0.1
                dev.systemInfo.temperature = Int(bytes[5])
                postNotification(.xkSystemInfo)
                print("device info")
            case BLEUUID.USER_SETTINGS:
                dev.systemInfo.bytes = bytes
                dev.systemInfo.cutoffInputVoltage = Float(bytes[0]) * 0.1
                if dev.systemInfo.cutoffInputVoltage > 13 || dev.systemInfo.cutoffInputVoltage < 11 {
                    dev.systemInfo.cutoffInputVoltage = 12
                }
                dev.systemInfo.dimPercent = Int(Int(bytes[2]) * 100 / 255) / 5 * 5
                dev.systemInfo.bluetoothOffTime = Int(bytes[3])
                if dev.systemInfo.bluetoothOffTime == 0 {
                    dev.systemInfo.bluetoothAutoOff = false
                }
                dev.systemInfo.buttonColor = UIColor(red: Double(bytes[4]) / 255, green: Double(bytes[5]) / 255, blue: Double(bytes[6]) / 255, alpha: 1.0)
                dev.systemInfo.buttonWarningColor = UIColor(red: Double(bytes[7]) / 255, green: Double(bytes[8]) / 255, blue: Double(bytes[9]) / 255, alpha: 1.0)
                print("system info")
            case BLEUUID.CHANNEL_STATUS:
                dev.channelBytes = bytes
                for index in 0...7 {
                    if dev.channels[index].maxOutputCurrent == 0 {
                        dev.channels[index].maxOutputCurrent = Int(Double(bytes[1 + index * 2]) * 0.1)
                    }
                }
                print("channel info")
            case BLEUUID.BUTTON_1_STATUS:
                let buttonInfo = dev.buttons[0]
                self.setButtonInfo(buttonInfo, fromBytes: bytes)
                postNotification(.xkButton1Status, object: buttonInfo)
                print("button 1: \(valueString ?? "")")
            case BLEUUID.BUTTON_2_STATUS:
                let buttonInfo = dev.buttons[1]
                self.setButtonInfo(buttonInfo, fromBytes: bytes)
                postNotification(.xkButton2Status, object: buttonInfo)
                print("button 2: \(valueString ?? "")")
            case BLEUUID.BUTTON_3_STATUS:
                let buttonInfo = dev.buttons[2]
                self.setButtonInfo(buttonInfo, fromBytes: bytes)
                postNotification(.xkButton3Status, object: buttonInfo)
                print("button 3: \(valueString ?? "")")
            case BLEUUID.BUTTON_4_STATUS:
                let buttonInfo = dev.buttons[3]
                self.setButtonInfo(buttonInfo, fromBytes: bytes)
                postNotification(.xkButton4Status, object: buttonInfo)
                print("button 4: \(valueString ?? "")")
            case BLEUUID.BUTTON_5_STATUS:
                let buttonInfo = dev.buttons[4]
                buttonInfo.bytes = bytes
                self.setButtonInfo(buttonInfo, fromBytes: bytes)
                postNotification(.xkButton5Status, object: buttonInfo)
                print("button 5: \(valueString ?? "")")
            case BLEUUID.BUTTON_6_STATUS:
                let buttonInfo = dev.buttons[5]
                self.setButtonInfo(buttonInfo, fromBytes: bytes)
                postNotification(.xkButton6Status, object: buttonInfo)
                print("button 6: \(valueString ?? "")")
            case BLEUUID.BUTTON_7_STATUS:
                let buttonInfo = dev.buttons[6]
                self.setButtonInfo(buttonInfo, fromBytes: bytes)
                postNotification(.xkButton7Status, object: buttonInfo)
                print("button 7: \(valueString ?? "")")
            case BLEUUID.BUTTON_8_STATUS:
                let buttonInfo = dev.buttons[7]
                self.setButtonInfo(buttonInfo, fromBytes: bytes)
                postNotification(.xkButton8Status, object: buttonInfo)
                print("button 8: \(valueString ?? "")")
            case BLEUUID.SENSOR_1_STATUS:
                let sensorInfo = dev.sensors[0]
                sensorInfo.bytes = bytes
                self.setSensorInfo(sensorInfo, fromBytes: bytes)
                print("sensor 1: \(valueString ?? "")")
            case BLEUUID.SENSOR_2_STATUS:
                let sensorInfo = dev.sensors[1]
                sensorInfo.bytes = bytes
                self.setSensorInfo(sensorInfo, fromBytes: bytes)
                print("sensor 2: \(valueString ?? "")")
            case BLEUUID.SENSOR_3_STATUS:
                let sensorInfo = dev.sensors[2]
                sensorInfo.bytes = bytes
                self.setSensorInfo(sensorInfo, fromBytes: bytes)
                print("sensor 3: \(valueString ?? "")")
            default:
                print("other")
                shouldSave = false
            }
            if shouldSave {
//                self.savePairedDevicesToFile()
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let e = error {
            print(peripheral.identifier, e)
            return
        }
    }
    
    func setButtonInfo(_ buttonInfo: ButtonInfo, fromBytes bytes: [UInt8]) {
        buttonInfo.bytes = bytes
        buttonInfo.illuminated = getBit(0, of: bytes[0]) == Bit.one
        buttonInfo.pressed = getBit(1, of: bytes[0]) == Bit.one
        buttonInfo.momentary = getBit(4, of: bytes[0]) == Bit.one
        for index in 0...7 {
            buttonInfo.channels[index] = bytes[index + 1] != 0
            if buttonInfo.channels[index] {
                buttonInfo.actions[index] = Int(bytes[index + 1])
            }
        }
    }
    
    func setSensorInfo(_ sensorInfo: ButtonInfo, fromBytes bytes: [UInt8]) {
        sensorInfo.bytes = bytes
        sensorInfo.dim = getBit(6, of: bytes[0]) == Bit.one
        for index in 0...2 {
            sensorInfo.channels[index] = bytes[index + 1] != 0
            if sensorInfo.channels[index] {
                sensorInfo.actions[index] = Int(bytes[index + 1])
            }
        }
    }
    
    func loadPairedDevices() {
        let devices = loadFromFile()
        for device in devices {
            pairedDevices[device.uuid] = device
            knownDevices[device.uuid] = device
        }
    }
    
    func getPairedDevices() -> [DeviceInfo] {
        return [DeviceInfo](pairedDevices.values)
    }
    
    func getUnpairedDevices() -> [DeviceInfo] {
        var devices: [DeviceInfo] = []
        for device in knownDevices.values {
            if !pairedDevices.keys.contains(device.uuid) {
                devices.append(device)
            }
        }
        return devices
    }
    
    func updateSystemSetting() {
        let systemInfo = activeDevice!.systemInfo
        if systemInfo.bytes.isEmpty {
            return
        }
        systemInfo.bytes[0] = UInt8(systemInfo.cutoffInputVoltage * 10)
        systemInfo.bytes[3] = systemInfo.bluetoothAutoOff ? UInt8(systemInfo.bluetoothOffTime) : 0
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        systemInfo.buttonColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        systemInfo.bytes[4] = UInt8(red * 255)
        systemInfo.bytes[5] = UInt8(green * 255)
        systemInfo.bytes[6] = UInt8(blue * 255)
        systemInfo.buttonWarningColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        systemInfo.bytes[7] = UInt8(red * 255)
        systemInfo.bytes[8] = UInt8(green * 255)
        systemInfo.bytes[9] = UInt8(blue * 255)
        sendCommandUserSetting(systemInfo)
    }
    
    func savePairedDevicesToFile() {
        saveToFile([DeviceInfo](pairedDevices.values))
    }
}
