//
//  SIChuck.h
//  SIChuck
//
//  Created by sisyphe.cn on 2020/6/19.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for SIChuck.
FOUNDATION_EXPORT double SIChuckVersionNumber;

//! Project version string for SIChuck.
FOUNDATION_EXPORT const unsigned char SIChuckVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SIChuck/PublicHeader.h>
#import "SIChuckTool.h"
#import "SIChuckRootViewController.h"


//MARK：app启动时候初始化
//#if DEBUG
//SIChuckTool.shareInterface().buttonEventshow()
//#endif

//MARK：网络请求保存数据
//#if DEBUG
//let dateFormatString = "yyyy/MM/dd/ HH:mm:ss"
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = dateFormatString
//dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//
//let siModel = SIHttpModel()
//siModel.path = result.request?.url?.description ?? ""
//siModel.method = result.request?.httpMethod?.description ?? ""
//siModel.headers = result.request?.allHTTPHeaderFields?.description ?? ""
//siModel.body = String(data: result.request?.httpBody ?? Data(), encoding: .utf8) ?? ""
//siModel.response = result.response?.description ?? ""
//siModel.data = String(data: result.data , encoding: String.Encoding.utf8) ?? ""
//siModel.date = dateFormatter.string(from: Date())
//SIChuckTool.shareInterface().saveHttpModel(siModel)
//#endif
