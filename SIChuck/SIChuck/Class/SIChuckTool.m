//
//  SIChuckTool.m
//  SIChuck
//
//  Created by sisyphe.cn on 2020/6/19.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import "SIChuckTool.h"
#import "SIHttpModel.h"
#import "WSSMoveButton.h"
#import "SIChuckRootViewController.h"

#define kSIChuckToolDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SIChuckTool.json"]
@interface SIChuckTool()
@property (nonatomic,strong)NSMutableArray *dataModels;
@end
@implementation SIChuckTool

+ (instancetype)shareInterface
{
    static SIChuckTool *__tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                  __tool = [SIChuckTool allocWithZone:NULL];
                  __tool.dataModels = [NSMutableArray array];
                  });
    return __tool;
}

//悬浮按钮是否展示
-(void)buttonEventshow;
{
    WSSMoveButton *btn = [WSSMoveButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(5, 300, 30, 30);
    btn.layer.cornerRadius = 15.0f;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2;
    [btn setTitle:@"API" forState:UIControlStateNormal];
    [btn setDragEnable:YES];
    [btn setAdsorbEnable:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:btn];
    [btn addTarget:self action:@selector(didClickedInMoveButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickedInMoveButton
{
    SIChuckRootViewController *rootVC = [[SIChuckRootViewController alloc] init];
    UINavigationController *rootNavVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:rootNavVC animated:YES completion:nil];
}

- (NSMutableArray *)httpModels
{
    NSData *data = [NSKeyedUnarchiver unarchiveObjectWithFile:kSIChuckToolDataPath];
    NSMutableArray *ahttpModels = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(ahttpModels == nil)
    {
        return [NSMutableArray new];
    }
    return ahttpModels;
}

- (void)saveHttpModel:(SIHttpModel *)httpModel
{
    if(httpModel == nil)
    {
        return;
    }
    NSMutableArray *ahttpModels = [self httpModels];
    [ahttpModels addObject:httpModel];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:ahttpModels];
    [NSKeyedArchiver archiveRootObject:data toFile:kSIChuckToolDataPath];
}

- (void)cleanAll;
{
    [NSKeyedArchiver archiveRootObject:nil toFile:kSIChuckToolDataPath];
}
@end

