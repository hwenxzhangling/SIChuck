//
//  SIChuckResponseViewController.m
//  Demo01
//
//  Created by sisyphe.cn on 2020/6/19.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import "SIChuckResponseViewController.h"
#import "SIChuckResponseCell.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface SIChuckResponseViewController ()<UITableViewDelegate,UITableViewDataSource,JSExport>
@property (nonatomic,strong)UITableView   *tableView;
@property (nonatomic,strong)SIHttpModel   *httpModel;
@property (nonatomic,strong)JSContext     *context;
@property (nonatomic,strong)NSString      *responseResult;

@end

@implementation SIChuckResponseViewController
#define SIChuckJS @"function parseJson(string) {\
try {\
return JSON.parse(string);\
} catch (error) {\
return null;\
}\
}\
function renderJson(json) {\
return JSON.stringify(json, null, 2);\
};"

- (instancetype)initWithHttpModel:(SIHttpModel *)httpModel;
{
    self = [super init];
    if(self)
    {
        self.httpModel = httpModel;
        self.context = [[JSContext alloc] init];
        [self jsonParse];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)jsonParse
{
    self.responseResult = (self.httpModel.data ? self.httpModel.data : @"");
    [self.context evaluateScript:SIChuckJS withSourceURL:nil];
    JSValue *parseJsonResultValue = [self.context[@"parseJson"] callWithArguments:@[self.responseResult]];
    JSValue *renderJsonResultValue = [self.context[@"renderJson"] callWithArguments:@[[parseJsonResultValue toObject] ? [parseJsonResultValue toObject] : @""]];
    NSString *renderJson = [renderJsonResultValue toString];
    self.responseResult = renderJson;
}

#pragma mark - lazy tableView
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView =  [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-34-69)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[SIChuckResponseCell class] forCellReuseIdentifier:NSStringFromClass([SIChuckResponseCell class])];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SIChuckResponseCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SIChuckResponseCell class])];
    if(self.type == 2)
    {
        cell.result = self.responseResult;
    }else if(self.type == 1)
    {
        NSString *result = [NSString stringWithFormat:@"Request https:%@\n\n\nHTTP Request Method:%@\n\n\nRequest Headers:%@\n\n\nRequest Body:%@\n\n\n Response:%@\n\n\n",self.httpModel.path,self.httpModel.method,self.httpModel.headers,self.httpModel.body,self.httpModel.response];
        cell.result = result;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.type == 2)
    {
        return [SIChuckResponseCell cellHeightWithModel:self.responseResult];
    }else if(self.type == 1)
    {
        NSString *result = [NSString stringWithFormat:@"Request https:%@\n\n\nHTTP Request Method:%@\n\n\nRequest Headers:%@\n\n\nRequest Body:%@\n\n\n Response:%@\n\n\n",self.httpModel.path,self.httpModel.method,self.httpModel.headers,self.httpModel.body,self.httpModel.response];
        return [SIChuckResponseCell cellHeightWithModel:result];
    }
    return 0;
}
@end

