//
//  UIDeviceExtension.swift
//  hzy
//
//  Created by hzy on 2018/1/11.
//  Copyright © 2018年 hzy. All rights reserved.
//

import UIKit

struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

extension CGSize: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let size = NSCoder.cgSize(for: value)
        self.init(width: size.width, height: size.height)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        let size = NSCoder.cgSize(for: value)
        self.init(width: size.width, height: size.height)
    }
    
    public init(unicodeScalarLiteral value: String) {
        let size = NSCoder.cgSize(for: value)
        self.init(width: size.width, height: size.height)
    }
}

extension CGSize {
    static func ==(lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}

extension HzyNamespaceWrapper where T: UIDevice {
    public enum Device {
        case iPhone2g
        case iPhone3g,iPhone3gs
        case iPhone4, iPhone4s
        case iPhone5, iPhone5c, iPhone5s, iPhone5SE
        case iPhone6, iPhone6p, iPhone6s, iPhone6sp
        case iPhone7, iPhone7p
        case iPhone8, iPhone8p
        case iPhoneX, iPhoneXS, iPhoneXSMax, iPhoneXR
        
        case iPad, iPad2, iPad3, iPad4, iPad5
        
        case iPadAir, iPadAir2
        
        case iPadPro_12_9_inch, iPadPro_9_7_inch, iPadPro_12_9_inch2, iPadPro_10_5
        
        case iPadMini, iPadMini2, iPadMini3, iPadMini4
        
        case iTouch, iTouch2, iTouch3, iTouch4, iTouch5, iTouch6
        
        case simulator
        
        case unKnown
        
        public init(nilLiteral: Void) {
            self = .unKnown
        }
        
        var logicDpi: CGSize {
            switch self {
            case .iPhone2g, .iPhone3g, .iPhone3gs, .iPhone4, .iPhone4s,
                 .iTouch, .iTouch2, .iTouch3, .iTouch4:
                return CGSize(width: 320, height: 480)
            case .iPhone5, .iPhone5c, .iPhone5s, .iPhone5SE,
                .iTouch5, .iTouch6:
                return CGSize(width: 320, height: 568)
            case .iPhone6, .iPhone6s, .iPhone7, .iPhone8:
                return CGSize(width: 375, height: 667)
            case .iPhone6p, .iPhone6sp, .iPhone7p, .iPhone8p:
                return CGSize(width: 414, height: 736)
            case .iPhoneX, .iPhoneXS:
                return CGSize(width: 375, height: 812)
            case .iPhoneXR, .iPhoneXSMax:
                return CGSize(width: 414, height: 896)
                
            case .iPad, .iPad2, .iPad3, .iPad4, .iPad5,
                 .iPadAir, .iPadAir2,
                 .iPadPro_9_7_inch,
                 .iPadMini,.iPadMini2,.iPadMini3,.iPadMini4:
                return CGSize(width: 768, height: 1024)
                
            case .iPadPro_10_5:
                return CGSize(width: 834, height: 1112)
                
            case .iPadPro_12_9_inch, .iPadPro_12_9_inch2:
                return CGSize(width: 834, height: 1112)
            case .simulator:
                return UIScreen.size
            case .unKnown:
                return .zero
            }
        }
        
        var scale: CGFloat {
            switch self {
            case .iPhone2g, .iPhone3g, .iPhone3gs, .iPhone4,
                 .iTouch, .iTouch2, .iTouch3,
                 .iPadMini,
                 .iPad, .iPad2:
                return 1
                
            case .iPhone4s,
                 .iPhone5, .iPhone5c, .iPhone5s, .iPhone5SE,
                 .iTouch4, .iTouch5, .iTouch6,
                 .iPhone6, .iPhone6s, .iPhone7, .iPhone8,
                 .iPhoneXR,
                 .iPadMini2,.iPadMini3,.iPadMini4,
                 .iPad3, .iPad4, .iPad5,
                 .iPadAir, .iPadAir2,
                 .iPadPro_9_7_inch, .iPadPro_12_9_inch, .iPadPro_12_9_inch2, .iPadPro_10_5:
                return 2
                
            case .iPhone6p, .iPhone6sp, .iPhone7p, .iPhone8p,
                 .iPhoneX, .iPhoneXS, .iPhoneXSMax:
                return 3
                
            case .simulator:
                return UIScreen.hzy.scale
            case .unKnown:
                return 0
            }
        }
    }
    
    public static var isiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public static var isScreenElongation: Bool {
        guard deviceType != .simulator else {
            return deviceType.logicDpi == Device.iPhoneX.logicDpi || deviceType.logicDpi == Device.iPhoneXS.logicDpi ||
                deviceType.logicDpi == Device.iPhoneXR.logicDpi ||
                deviceType.logicDpi == Device.iPhoneXSMax.logicDpi
        }
        
        return deviceType == .iPhoneX ||
            deviceType == .iPhoneXS ||
            deviceType == .iPhoneXR ||
            deviceType == .iPhoneXSMax
    }
    
    //https://www.theiphonewiki.com/wiki/Models
    static var deviceType: Device {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":                                return .iTouch  //"iPod Touch 1"
        case "iPod2,1":                                return .iTouch2 //"iPod Touch 2"
        case "iPod3,1":                                return .iTouch3 //"iPod Touch 3"
        case "iPod4,1":                                return .iTouch4 //"iPod Touch 4"
        case "iPod5,1":                                return .iTouch5 //"iPod Touch (5 Gen)"
        case "iPod7,1":                                return .iTouch6 //"iPod Touch 6"
            
        case "iPhone1,1":                              return .iPhone2g
        case "iPhone1,2":                              return .iPhone3g
        case "iPhone2,1":                              return .iPhone3gs
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":    return .iPhone4 //"iPhone 4"
        case "iPhone4,1":                              return .iPhone4s //"iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                 return .iPhone5 //"iPhone 5"
        case "iPhone5,3", "iPhone5,4":                 return .iPhone5c//"iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                 return .iPhone5s //"iPhone 5s"
        case "iPhone7,2":                              return .iPhone6//"iPhone 6"
        case "iPhone7,1":                              return .iPhone6p//"iPhone 6 Plus"
        case "iPhone8,1":                              return .iPhone6s//"iPhone 6s"
        case "iPhone8,2":                              return .iPhone6sp//"iPhone 6s Plus"
        case "iPhone8,4":                              return .iPhone5SE//"iPhone SE"
        case "iPhone9,1", "iPhone9,3":                 return .iPhone7  //"国行、日版、港行iPhone 7"
        case "iPhone9,2", "iPhone9,4":                 return .iPhone7p //"港行、国行iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":                return .iPhone8  //"iPhone 8"
        case "iPhone10,2","iPhone10,5":                return .iPhone8p //"iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":                return .iPhoneX //"iPhone X"
        case "iPhone11,8":                             return .iPhoneXR //"iPhone XR"
        case "iPhone11,2":                             return .iPhoneXS //"iPhone XS"
        case "iPhone11,6":                             return .iPhoneXSMax//"iPhone XS Max"
            
        case "iPad1,1", "iPad1,2":                                return .iPad //"iPad"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":          return .iPad2 //"iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":                     return .iPad3 //"iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":                     return .iPad4 //"iPad 4"
        case "iPad6,11", "iPad6,12":                              return .iPad5 //"iPad 4"
            
        case "iPad2,5", "iPad2,6", "iPad2,7":                     return .iPadMini   //"iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":                     return .iPadMini2  //"iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":                     return .iPadMini3  //"iPad Mini 3"
        case "iPad5,1", "iPad5,2":                                return .iPadMini4  //"iPad Mini 4"
            
        case "iPad4,1", "iPad4,2", "iPad4,3":                     return .iPadAir  //"iPad Air"
        case "iPad5,3", "iPad5,4":                                return .iPadAir2 //"iPad Air 2"
            
        case "iPad6,3", "iPad6,4":                                return .iPadPro_9_7_inch //"iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":                                return .iPadPro_12_9_inch//"iPad Pro 12.9"
        case "iPad7,1", "iPad7,2":                                return .iPadPro_12_9_inch2 //"iPad Pro 12.9"
        case "iPad7,3", "iPad7,4":                                return .iPadPro_10_5 //"iPad Pro 12.9"
            
        case "AppleTV2,1":                                        return .unKnown //"Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":                           return .unKnown //"Apple TV 3"
        case "AppleTV5,3":                                        return .unKnown  //"Apple TV 4"
            
        case "i386", "x86_64":                                    return .simulator
        default:  return .unKnown
        }
    }
}

extension HzyNamespaceWrapper where T: UIDevice {
    
    ///cpu频率 int: CPU Frequency
    public static var cpuFrequency: Int {
        var result: Int = 0
        getSysInfo(HW_CPU_FREQ, result: &result)
        return result
    }
    
    //总线频率 int Bus Frequency
    public static var busFrequency: Int {
        var result: Int = 0
        getSysInfo(HW_BUS_FREQ, result: &result)
        return result
    }
    /////current device RAM size; uint64_t: physical ram size
    public static var ramSize: UInt64{
        var result: UInt64 = 0
        getSysInfo(HW_MEMSIZE, result: &result)
        return result
    }
    
    ///Return the current device CPU number; int: number of cpus
    public static var cpuNumber: Int {
        var result: Int = 0
        getSysInfo(HW_NCPU, result: &result)
        return result
    }
    
    ///获取手机内存总量, 返回的是字节数; int: total memory
    public static var totalMemoryBytes: Int {
        var result: Int = 0
        getSysInfo(HW_PHYSMEM, result: &result)
        return result
    }
    ///获取手机可用内存, 返回的是字节数
    public static var freeMemoryBytes: UInt {
        return readFreeMemoryBytes()
    }
    /// 获取iOS系统的版本号
    public static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    /// 获取手机硬盘空闲空间, 返回的是字节数
    public static var freeDiskSpaceBytes: UInt64 {
        func diskSpace()->UInt64{
            var buf: statfs = statfs()
            var freespace: UInt64 = 0
            if statfs("/private/var", &buf) >= 0{
                freespace = UInt64(buf.f_bsize) * buf.f_bfree
            }
            return freespace
        }
        
        return diskSpace()
    }
    
    ///获取手机硬盘总空间, 返回的是字节数
    public static var totalDiskSpaceBytes: UInt64 {
        func diskSpace()->UInt64{
            var buf: statfs = statfs()
            var totalspace: UInt64 = 0
            if statfs("/private/var", &buf) >= 0{
                totalspace = UInt64(buf.f_bsize) * buf.f_blocks
            }
            return totalspace
        }
        return diskSpace()
    }
    
    public static func readMacAddress()->String{
        
        let index = Int32(if_nametoindex("en0"))
        guard index != 0 else {
            DLog("Error: if_nametoindex error\n");
            return "00:00:00:00:00:00"
        }
        
        var mib: [Int32] = [Int32].init(repeating: 0, count: 6)
        var len: Int = 0
        let bsdData = "en0".data(using: .utf8)
        
        mib[0] = CTL_NET
        mib[1] = AF_ROUTE
        mib[2] = 0
        mib[3] = AF_LINK
        mib[4] = NET_RT_IFLIST
        mib[5] = index
        
        guard sysctl(&mib, UInt32(mib.count), nil, &len, nil, 0) >= 0 else {
            print("Error: could not determine length of info data structure ")
            return "00:00:00:00:00:00"
        }
        
        var buffer = [CChar].init(repeating: 0, count: len)
        guard sysctl(&mib, 6, &buffer, &len, nil, 0) >= 0 else {
            DLog("Error: could not read info data structure")
            return "00:00:00:00:00:00"
        }
        
        let infoData = NSData(bytes: buffer, length: len)
        var interfaceMsgStruct = if_msghdr()
        infoData.getBytes(&interfaceMsgStruct, length: MemoryLayout<if_msghdr>.size)
        let socketStructStart = MemoryLayout<if_msghdr>.size + 1
        let socketStructData = infoData.subdata(with: NSMakeRange(socketStructStart, len - socketStructStart)) as NSData
        let rangeOfToken = socketStructData.range(of: bsdData!, options: NSData.SearchOptions(rawValue: 0), in: NSMakeRange(0, socketStructData.length))
        let macAddressData = socketStructData.subdata(with: NSMakeRange(rangeOfToken.location + 3, 6)) as NSData
        var macAddressDataBytes = [UInt8](repeating: 0, count: 6)
        macAddressData.getBytes(&macAddressDataBytes, length: 6)
        
        return macAddressDataBytes.map({ String(format:"%02x", $0) }).joined(separator: ":")
    }
    
    //MARK: - 获取IP
    static public func GetIPAddresses() -> String? {
        var addresses = [String]()
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            // For each interface ...
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first
    }
    
    private static func getSysInfo<T>(_ typeSpecifier: Int32, result: inout T){
        var size: size_t = MemoryLayout<Int>.size
        var mib: [Int32] = [CTL_HW, typeSpecifier]
        sysctl(&mib, 2, &result, &size, nil, 0)
    }
    
    private static func readFreeMemoryBytes()->UInt {
        var page_size: vm_size_t = 0
        let mach_port: mach_port_t = mach_host_self()
        var count: mach_msg_type_number_t =  mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
        var info: integer_t = 0
        host_page_size(mach_port, &page_size)
        
        if host_statistics(mach_port, HOST_VM_INFO, &info, &count) != KERN_SUCCESS {
            return 0
        }
        func pointer(p: host_info_t)-> vm_statistics_data_t{
            return p.withMemoryRebound(to: vm_statistics_data_t.self, capacity: 1, {$0}).pointee
        }
        let vm_stat = pointer(p: &info)
        
        let mem_free = UInt(vm_stat.free_count) * UInt(page_size);
        return mem_free
    }
}
