
#import "SIChuckResponseCell.h"
@interface SIChuckResponseCell()
@property (nonatomic,strong) UITextView     *resultLable;
@end

@implementation SIChuckResponseCell

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
    self.resultLable = [[UITextView alloc] init];
    self.resultLable.userInteractionEnabled = NO;
    self.resultLable.font = [UIFont systemFontOfSize:15];
    self.resultLable.textColor = [UIColor blackColor];
    self.resultLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.resultLable];
}

- (void)setResult:(NSString *)result
{
    _result = result;
    NSAttributedString *attText = [SIChuckResponseCell getAttributedStringWithString:_result lineSpace:5];
    self.resultLable.attributedText = attText;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.resultLable.frame = CGRectMake(15, 5, self.frame.size.width-30, self.frame.size.height-10);
}

+(CGFloat)cellHeightWithModel:(NSString *)result
{
    CGFloat height = [self dynamicCalculationLabelHightText:[self getAttributedStringWithString:result lineSpace:5] contentAn:YES];
    return height+10;
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
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:[string rangeOfString:@"Request https:"]];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:[string rangeOfString:@"Request Body:"]];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:[string rangeOfString:@"HTTP Request Method:"]];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:[string rangeOfString:@"Request Headers:"]];
     [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:[string rangeOfString:@"Response:"]];
    
    return attributedString;
}

#pragma mark -  //计算lableHeight

//计算lableHeight
+ (CGFloat )dynamicCalculationLabelHightText:(NSAttributedString *)attrText contentAn:(BOOL)contentAn;
{
    CGFloat resultWidth = [UIScreen mainScreen].bounds.size.width-30;
    CGSize size = [attrText boundingRectWithSize:CGSizeMake(resultWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  context:nil].size;
    return size.height + 150;
}
@end
