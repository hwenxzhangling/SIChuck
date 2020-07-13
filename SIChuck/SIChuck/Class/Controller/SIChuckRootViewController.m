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
    UIButton *dissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [dissButton setTitle:@"diss" forState:UIControlStateNormal];
    dissButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [dissButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [dissButton addTarget:self action:@selector(dissButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = dissButton;
    
    
    [self.view addSubview:self.tableView];
    self.datas =  [SIChuckTool shareInterface].httpModels;
    NSSortDescriptor *tempDes = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    self.datas = [self.datas sortedArrayUsingDescriptors:@[tempDes]];
}

- (void)dissButtonAction
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
        
        cell.tag = indexPath.row;
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionlongPressGestureRecognizer:)];
        [cell addGestureRecognizer:longPressGestureRecognizer];
    }else
    {
        cell.result = @"点我一下就清除全部,  所以内容长按可拷贝";
        cell.date = @"";
    }
    return cell;
}

- (void)actionlongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    if(longPressGestureRecognizer.view.tag)
    {
        SIHttpModel *model = self.datas[longPressGestureRecognizer.view.tag];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = model.path;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"拷贝成功" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [self presentViewController:alertController animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:alertController afterDelay:1.0];
    }
}

- (void)dismiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
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
