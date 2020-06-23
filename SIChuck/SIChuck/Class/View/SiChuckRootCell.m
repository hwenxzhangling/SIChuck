//
//  SiChuckRootCell.m
//  SIChuck
//
//  Created by sisyphe.cn on 2020/6/22.
//  Copyright © 2020 sisyphe.cn. All rights reserved.
//

#import "SiChuckRootCell.h"
@interface SiChuckRootCell()
@property (nonatomic,strong) UILabel     *dateLable;
@property (nonatomic,strong) UILabel     *resultLable;
@end

@implementation SiChuckRootCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.dateLable = [[UILabel alloc] init];
    self.dateLable.numberOfLines = 0;
    self.dateLable.font = [UIFont systemFontOfSize:15];
    self.dateLable.textColor = [UIColor blackColor];
    self.dateLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.dateLable];
    
    self.resultLable = [[UILabel alloc] init];
    self.resultLable.numberOfLines = 0;
    self.resultLable.font = [UIFont systemFontOfSize:15];
    self.resultLable.textColor = [UIColor blackColor];
    self.resultLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.resultLable];
}

- (void)setResult:(NSString *)result
{
    _result = result;
    self.resultLable.attributedText = [SiChuckRootCell getAttributedStringWithString:_result lineSpace:1];
}

- (void)setDate:(NSString *)date
{
    _date = date;
    if(_date == nil || [_date isEqualToString:@""])
    {
        self.dateLable.text = @"";
    }else
    {
        self.dateLable.text = [NSString stringWithFormat:@"请求时间：%@",_date];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.dateLable.frame = CGRectMake(15, 5, self.frame.size.width-30, 15);
    self.resultLable.frame = CGRectMake(15, 20, self.frame.size.width-30, self.frame.size.height-30);
}

+(CGFloat)cellHeightWithModel:(NSString *)result
{
    CGFloat height = [self dynamicCalculationLabelHightText:[self getAttributedStringWithString:result lineSpace:5] contentAn:YES];
    return 30+height+10;
}

+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    if(string == nil)
        return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    paragraphStyle.alignment = NSTextAlignmentLeft;  //对齐
    paragraphStyle.headIndent = 0.0f;//行首缩进
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName: [[UIColor blackColor] colorWithAlphaComponent:0.6]} range:range];
    return attributedString;
}

#pragma mark -  //计算lableHeight

//计算lableHeight
+ (CGFloat )dynamicCalculationLabelHightText:(NSAttributedString *)attrText contentAn:(BOOL)contentAn;
{
    CGFloat resultWidth = [UIScreen mainScreen].bounds.size.width-30;
    CGSize size = [attrText boundingRectWithSize:CGSizeMake(resultWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  context:nil].size;
    return size.height;
}
@end

