//
//  EncryptionManager.swift
//  ChainTechDemo
//
//  Created by JJMac on 17/09/24.
//

import Foundation
import CommonCrypto

class EncryptionManager {
    private let key: Data
    private let iv: Data
    
    init(key: String, iv: String) {
        self.key = key.data(using: .utf8)!
        self.iv = iv.data(using: .utf8)!
    }

    // Encrypt the string
    func encrypt(_ string: String) -> String? {
        let dataToEncrypt = string.data(using: .utf8)!
        var buffer = [UInt8](repeating: 0, count: dataToEncrypt.count + kCCBlockSizeAES128)
        var numberOfBytesEncrypted = 0
        
        let cryptStatus = CCCrypt(
            CCOperation(kCCEncrypt),
            CCAlgorithm(kCCAlgorithmAES),
            CCOptions(kCCOptionPKCS7Padding),
            key.bytes, kCCKeySizeAES128,
            iv.bytes,
            dataToEncrypt.bytes, dataToEncrypt.count,
            &buffer, buffer.count,
            &numberOfBytesEncrypted
        )

        if cryptStatus == kCCSuccess {
            let encryptedData = Data(bytes: buffer, count: numberOfBytesEncrypted)
            return encryptedData.base64EncodedString()
        }
        return nil
    }

    // Decrypt the string
    func decrypt(_ string: String) -> String? {
        guard let dataToDecrypt = Data(base64Encoded: string) else { return nil }
        var buffer = [UInt8](repeating: 0, count: dataToDecrypt.count + kCCBlockSizeAES128)
        var numberOfBytesDecrypted = 0
        
        let cryptStatus = CCCrypt(
            CCOperation(kCCDecrypt),
            CCAlgorithm(kCCAlgorithmAES),
            CCOptions(kCCOptionPKCS7Padding),
            key.bytes, kCCKeySizeAES128,
            iv.bytes,
            dataToDecrypt.bytes, dataToDecrypt.count,
            &buffer, buffer.count,
            &numberOfBytesDecrypted
        )
        
        if cryptStatus == kCCSuccess {
            let decryptedData = Data(bytes: buffer, count: numberOfBytesDecrypted)
            return String(data: decryptedData, encoding: .utf8)
        }
        return nil
    }
}

private extension Data {
    var bytes: UnsafeRawPointer {
        return (self as NSData).bytes
    }
}

