#import <Foundation/Foundation.h>

@interface RRBRunner : NSObject
- (id)initWithTimes:(NSInteger)times;
- (void)report:(NSString *)name context:(void (^)())block;
@end
