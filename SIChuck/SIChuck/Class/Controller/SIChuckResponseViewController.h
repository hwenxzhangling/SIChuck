//
//  SIChuckResponseViewController.h
//  Demo01
//
//  Created by sisyphe.cn on 2020/6/19.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIHttpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIChuckResponseViewController : UIViewController
@property (nonatomic,assign)NSInteger type;//1:request 2:response
- (instancetype)initWithHttpModel:(SIHttpModel *)httpModel;
@end

NS_ASSUME_NONNULL_END
