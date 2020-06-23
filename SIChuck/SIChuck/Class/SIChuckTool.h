//
//  SIChuckTool.h
//  SIChuck
//
//  Created by sisyphe.cn on 2020/6/19.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIHttpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIChuckTool : NSObject
+(instancetype)shareInterface;
//悬浮按钮是否展示
-(void)buttonEventshow;
//清除所有数据
-(void)cleanAll;
//获取所有数据
-(NSMutableArray *)httpModels;
//保存h数据
-(void)saveHttpModel:(SIHttpModel *)httpModel;
@end

NS_ASSUME_NONNULL_END
