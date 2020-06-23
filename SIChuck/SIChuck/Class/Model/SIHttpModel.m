//
//  SIHttpModel.m
//  SIChuck
//
//  Created by sisyphe.cn on 2020/6/19.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import "SIHttpModel.h"

@implementation SIHttpModel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if(self)
    {
        self.path =  [coder decodeObjectForKey:@"path"];
        self.date =  [coder decodeObjectForKey:@"date"];
        self.response =  [coder decodeObjectForKey:@"response"];
        self.headers =  [coder decodeObjectForKey:@"headers"];
        self.body =  [coder decodeObjectForKey:@"body"];
        self.method =  [coder decodeObjectForKey:@"method"];
        self.data =  [coder decodeObjectForKey:@"data"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:(self.path ? self.path : @"") forKey:@"path"];
    [coder encodeObject:(self.date ? self.date : @"") forKey:@"date"];
    [coder encodeObject:(self.response ? self.response : @"") forKey:@"response"];
    [coder encodeObject:(self.headers ? self.headers : @"") forKey:@"headers"];
    [coder encodeObject:(self.body ? self.body : @"") forKey:@"body"];
    [coder encodeObject:(self.method ? self.method : @"") forKey:@"method"];
    [coder encodeObject:(self.data ? self.data : @"") forKey:@"data"];
}
@end
