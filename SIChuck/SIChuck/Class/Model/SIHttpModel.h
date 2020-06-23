//
//  SIHttpModel.h
//  SIChuck
//
//  Created by sisyphe.cn on 2020/6/19.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIHttpModel : NSObject<NSCoding>
@property (nonatomic,copy)NSString      *path;//Request: https
@property (nonatomic,copy)NSString      *method;//HTTP Request Method
@property (nonatomic,copy)NSString      *date;//时间
@property (nonatomic,copy)NSString      *headers;// Request Headers
@property (nonatomic,copy)NSString      *response;//Response
@property (nonatomic,copy)NSString      *body;//Request Body
@property (nonatomic,copy)NSString      *data;//Request data

@end

NS_ASSUME_NONNULL_END
