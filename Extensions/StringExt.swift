//
//  StringExt.swift
//  ios-base
//
//  Created by Özkan Bölükbaş on 1.03.2022.
//

import Foundation
import UIKit
import Localize_Swift

extension String {
    var asDouble: Double? {
        Double(self) ?? nil
    }
    
    func convertDate() -> String {
        //Base date formatter set local based on language
        let dateFormatter = BaseDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateAsDate = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "d MMM, yyyy"
        LanguageManager.shared.localizeObject(dateFormatter)
        let newDate = dateFormatter.string(from: dateAsDate)
        return newDate
    }
    
    var isEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        if self.digits.trimmingCharacters(in: .whitespacesAndNewlines).count < 8 {
            return false
        } else {
            return true
        }
    }
    
    func grouping(every groupSize: String.IndexDistance, with separator: Character) -> String {
        let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")
        return String(cleanedUpCopy.enumerated().map() {
            $0.offset % groupSize == 0 ? [separator, $0.element] : [$0.element]
        }.joined().dropFirst())
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    var unicode: String {
        guard let code = UInt32(self, radix: 16),
              let scalar = Unicode.Scalar(code) else {
            return ""
        }
        return "\(scalar)"
    }
    
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            paragraphStyle.lineSpacing = 1.5
            
            let attrStr : NSMutableAttributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            attrStr.addAttribute(NSAttributedString.Key.font, value: UIFont.mySystemFont(ofSize: 14), range: NSMakeRange(0, attrStr.length))
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray,range: NSMakeRange(0, attrStr.length))
            attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrStr.length))
            return attrStr
        } catch {
            return nil
        }
    }
    
    var htmlToDetailAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        var versionComponents = self.components(separatedBy: versionDelimiter)
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)
        let zeroDiff = versionComponents.count - otherVersionComponents.count
        if zeroDiff == 0 {
            return self.compare(otherVersion, options: .numeric)
        } else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff))
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros)
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric)
        }
    }
    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
      let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
      let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
      let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
      let range = (self as NSString).range(of: text)
      fullString.addAttributes(boldFontAttribute, range: range)
      return fullString
    }
    
    func separatedText(semiBoldString: String, regularSize: CGFloat, semiboldSize: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [NSAttributedString.Key.font: UIFont(name: AppFontName.regular, size: regularSize) ?? .systemFont(ofSize: regularSize)])
        let semiBoldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: AppFontName.semiBold, size: semiboldSize) ?? .systemFont(ofSize: semiboldSize)]
        let range = (self as NSString).range(of: semiBoldString)
        attributedString.addAttributes(semiBoldFontAttribute, range: range)
        return attributedString
    }
    
    func toJSON() -> Any? {
            guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
            return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        }
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func splitFullName() -> String {
        let splitName = self.split(separator: " ")
        var lastName: String = ""
        
        for i in 0...splitName.count - 1 {
            if i > 0 {
                if let firstCharacter = splitName[i].first {
                    lastName += String(describing: firstCharacter) + ". "
                }
            }
        }
        
        guard let firstName = splitName.first else {return self}
        return firstName + " " + lastName
    }
    
    func initialsName() -> String {
        let formatter = PersonNameComponentsFormatter()
        
        if let components = formatter.personNameComponents(from: self) {
             formatter.style = .abbreviated
             return formatter.string(from: components)
        } else {
            return ""
        }
    }
}
