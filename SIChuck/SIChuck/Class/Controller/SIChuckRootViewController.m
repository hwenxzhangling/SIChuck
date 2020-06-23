//
//  SIChuckRootViewController.m
//  Demo01
//
//  Created by sisyphe.cn on 2020/6/11.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import "SIChuckRootViewController.h"
#import "SIChuckDetailViewController.h"
#import "SIChuckTool.h"
#import "SiChuckRootCell.h"

@interface SIChuckRootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *datas;

@end

@implementation SIChuckRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.datas =  [SIChuckTool shareInterface].httpModels;
    NSSortDescriptor *tempDes = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    self.datas = [self.datas sortedArrayUsingDescriptors:@[tempDes]];
}

#pragma mark - lazy tableView
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-34-49)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[SiChuckRootCell class] forCellReuseIdentifier:NSStringFromClass([SiChuckRootCell class])];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0)
    {
        [[SIChuckTool shareInterface] cleanAll];
        self.datas = [NSArray array];
        [self.tableView reloadData];
    }else
    {
        SIHttpModel *model = self.datas[indexPath.row-1];
        SIChuckDetailViewController *detailVC = [[SIChuckDetailViewController alloc] initWithHttpModel:model];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.datas.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiChuckRootCell *cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SiChuckRootCell class])];
    if(indexPath.row)
    {
        SIHttpModel *model = self.datas[indexPath.row-1];
        cell.result = model.path;
        cell.date = model.date;
    }else
    {
        cell.result = @"点我一下就清除全部";
        cell.date = @"";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > 0)
    {
        SIHttpModel *model = self.datas[indexPath.row-1];
        return [SiChuckRootCell cellHeightWithModel:model.path];
    }
    return 40;
}
@end
