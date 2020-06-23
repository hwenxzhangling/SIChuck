//
//  SIChuckDetailViewController.m
//  Demo01
//
//  Created by sisyphe.cn on 2020/6/19.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import "SIChuckDetailViewController.h"
#import "SIChuckResponseViewController.h"

@interface SIChuckDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)SIHttpModel                    *httpModel;
@property (nonatomic,strong)UIScrollView                   *scrollView;
@property (nonatomic,strong)SIChuckResponseViewController  *responseVC;
@property (nonatomic,strong)SIChuckResponseViewController  *requsetVC;
@property (nonatomic,strong)UIView                         *lineView;
@end

@implementation SIChuckDetailViewController
- (instancetype)initWithHttpModel:(SIHttpModel *)httpModel;
{
    self = [super init];
    if(self)
    {
        self.httpModel = httpModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)setupViews
{
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width/2.f, 5)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.lineView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height-10)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.requsetVC = [[SIChuckResponseViewController alloc] initWithHttpModel:self.httpModel];
    self.requsetVC.type = 1;
    [self addChildViewController:self.requsetVC];
    [self.scrollView addSubview:self.requsetVC.view];
    self.responseVC.view.frame = self.scrollView.bounds;
    
    self.responseVC = [[SIChuckResponseViewController alloc] initWithHttpModel:self.httpModel];
    self.responseVC.type = 2;
    [self addChildViewController:self.responseVC];
    [self.scrollView addSubview:self.responseVC.view];
    self.responseVC.view.frame = CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (int)(self.scrollView.contentOffset.x/self.scrollView.frame.size.width);
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake(index * (self.scrollView.frame.size.width/2.f) , 0, self.scrollView.frame.size.width/2.f, 5);
    }];
}
@end
