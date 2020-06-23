
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIChuckResponseCell : UITableViewCell
@property (nonatomic,strong)NSString *result;

+(CGFloat)cellHeightWithModel:(NSString *)result;
@end

NS_ASSUME_NONNULL_END
