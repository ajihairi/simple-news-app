//
//  BaseViewController.swift
//  simple-news-app
//
//  Created by Hamzhya Salsatinnov Hairy on 01/04/20.
//  Copyright © 2020 Hamzhya Salsatinnov Hairy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}


//@available(iOS 10.0, *)
class BaseView: UIViewController, UIGestureRecognizerDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SGSnackBarView.appearance().actionButtonBackgroundColor = UIColor(hexString: "#5E5E5E")
        SGSnackBarView.appearance().descLabelTextColor = UIColor.white
        SGSnackBarView.appearance().snackBarBgColor = UIColor(hexString: "#FD4456")
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    
    func createGradientBar() {
        guard
            let navigationController = navigationController,
            let flareGradientImage = CAGradientLayer.primaryGradient(on: navigationController.navigationBar)
            else {
                print("Error creating gradient color!")
                return
        }
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: flareGradientImage)
    }
    
    func barTintColorWithShadow() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
    }
    
    func replaceBorderNavbar() {
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.0
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 0
        
//        for parent in self.navigationController!.navigationBar.subviews {
//            for childView in parent.subviews {
//                if(childView is UIImageView) {
//                    childView.removeFromSuperview()
//                }
//            }
//        }
    }
    
    func setTitleBar(title:String) -> UIStackView {
        
        let one = UILabel()
        one.text = title
        one.font = .systemFont(ofSize: 20, weight: .bold)// R.font.markBold(size: 18)
        one.textColor = .black
        one.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [one])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        
        let width = one.frame.size.width
        stackView.frame = CGRect(x: 0, y: -10, width: width, height: 82)
        
        one.sizeToFit()
        return stackView
        
    }
    
    func setTitleBar() -> UIStackView {
        
        let mainLogo = UIImageView.init(image: .checkmark)// UIImageView(image: R.image.mainlogo())
        mainLogo.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [mainLogo])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        
        let width = mainLogo.frame.size.width
        stackView.frame = CGRect(x: 0, y: -10, width: width, height: 35)
        
        return stackView
        
    }
    
    func setTitleBarWithColor(title:String, titleColor: UIColor, subtitle:String, subtitleColor: UIColor) -> UIStackView {
        
        let one = UILabel()
        one.text = title
        one.font = .systemFont(ofSize: 20, weight: .bold)//R.font.focoBold(size: 16)
        one.textColor = titleColor
        one.textAlignment = .center
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = .systemFont(ofSize: 16)//R.font.focoRegular(size: 12)
        two.textAlignment = .center
        two.textColor = subtitleColor
        two.sizeToFit()
        
        
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: -10, width: width, height: 54)
        
        one.sizeToFit()
        two.sizeToFit()
        
        self.replaceBorderNavbar()
        
        
        return stackView
        
    }
    
    func transparentBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setArrowBack(imageArrow: UIImage) {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(imageArrow, for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.popviewController), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.leftBarButtonItem = item1
        self.navigationItem.leftBarButtonItem?.tintColor = .red
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setDismissBack(imageArrow: UIImage) {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(imageArrow, for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.dismissController), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.leftBarButtonItem = item1
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func popviewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showNoConnectionView(completion: @escaping() -> ()) {
        /**
         let noInternet = NoConnectionView()
         noInternet.onRefresh = {
             completion()
         }
         self.present(noInternet, animated: true, completion: nil)
         */
        print("noConnection")
        completion()
        
    }
    
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var kmFormatted: String {
        
        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%.0f", locale: Locale.current,self)
    }
    
    func toCurrencyFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "id_ID")
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        let result = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        return result.replacingOccurrences(of: "Rp", with: " ")
    }
    
}

extension BXButton {
    
    func setDisabled(_ bool: Bool) {
        if bool {
            self.isEnabled = false
            self.startColor = UIColor.lightGray
            self.endColor = UIColor.lightGray
        } else {
            self.isEnabled = true
            self.startColor = UIColor.hexStringToUIColor(hex: "#19DB53")
            self.endColor = UIColor.hexStringToUIColor(hex: "#19DB53")
        }
    }
    
}

extension UIView {
    
    
    func addConstraintsWithFormat(withFormat format: String, forViews views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            
            let key = "v\(index)"
            
            viewsDictionary[key] = view
            
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    
    
    static func rgb(ofRed red: CGFloat, ofGreen green: CGFloat, ofBlue blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}


extension UIViewController {
    
    
    func showAlert(_ message: String, completion: @escaping() -> Void) {
        let alertController = UIAlertController(title: "Pasar Udang", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            completion()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showConfirmation(_ title: String, message: String, completion: @escaping() -> ()) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            completion()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

    
}

extension String{
    
    func toCurrencyFormat() -> String {
        if let intValue = Int(self){
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale(identifier: "id_ID")
            numberFormatter.numberStyle = NumberFormatter.Style.currency
            let result = numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
            return result.replacingOccurrences(of: "Rp", with: " ")
        }
        return ""
    }
    
    func kmFormatted() -> String {
        if let doubleValue = Double(self) {
            let value = doubleValue.kmFormatted
            return value
        }
        return ""
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
        
        
}


struct Screen {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    static var statusBarHeight: CGFloat {
        
        return 40
    }
    
}

extension UIColor {
    var hexString:String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}

extension String {
    
    /*
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     - Parameter length: Desired maximum lengths of a string
     - Parameter trailing: A 'String' that will be appended after the truncation.
     
     - Returns: 'String' object.
     */
    func trunc(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func stringByReplacing(replaceStrings set: [String], with: String) -> String {
        var stringObject = self
        for string in set {
            stringObject = self.replacingOccurrences(of: string, with: with)
        }
        return stringObject
    }
    
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var htmlAttributed: (NSAttributedString?, NSDictionary?) {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return (nil, nil)
            }
            
            var dict:NSDictionary?
            dict = NSMutableDictionary()
            
            return try (NSAttributedString(data: data,
                                           options: [.documentType: NSAttributedString.DocumentType.html,
                                                     .characterEncoding: String.Encoding.utf8.rawValue],
                                           documentAttributes: &dict), dict)
        } catch {
            print("error: ", error)
            return (nil, nil)
        }
    }
    
    func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: 13px !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(font.familyName), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
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
}


extension Date {
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func backToDate(milliseconds: Int64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toString(milliseconds:Int64, withFormat: String = "MMMM dd") -> String {
        let millisDate = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
        return millisDate.toString(dateFormat: withFormat)
    }
    
    func toDateString(milliseconds: Int64) -> String {
        let millisDate = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
        return millisDate.toString(dateFormat: "dd-mm-yyyy HH:mm:ss")
    }
    
    func toCycleDate(milliseconds: Int64) -> String {
        let millisDate = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
        return millisDate.toString(dateFormat: "dd/mm/yyyy")
    }
    
    func lastUpdateHour(milliseconds: Int64) -> String {
        let millisDate = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
        return millisDate.toString(dateFormat: "HH:mm")
    }
    
    func isDateInToday(_ date: Int64) -> String {
        let dateNow = self.backToDate(milliseconds: date)
        if Calendar.current.isDateInToday(dateNow) {
            return self.lastUpdateHour(milliseconds: date)
        } else {
            return self.toString(milliseconds: date)
        }
    }
    
    func daysBetweenDates(startDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: self)
        return components.day!
    }
    
    
}
