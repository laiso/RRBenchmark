//
//  RRBenchmark.h
//  RRBenchmark
//

//
//

#import <Foundation/Foundation.h>

#import "RRBRunner.h"

@interface RRBenchmark : NSObject
+ (void)benchmark:(void (^)())block;
+ (void)benchmark:(void (^)())block iterations:(NSInteger)iterations;
@end
