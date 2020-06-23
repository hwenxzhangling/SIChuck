//
//  SiChuckRootCell.h
//  SIChuck
//
//  Created by sisyphe.cn on 2020/6/22.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SiChuckRootCell : UITableViewCell
@property (nonatomic,strong)NSString *result;
@property (nonatomic,strong)NSString *date;

+(CGFloat)cellHeightWithModel:(NSString *)result;
@end

NS_ASSUME_NONNULL_END
