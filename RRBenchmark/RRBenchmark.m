#import "RRBenchmark.h"

@implementation RRBenchmark

+ (void)benchmark:(void (^)())block
{
  [RRBenchmark benchmark:block iterations:100];
}

+ (void)benchmark:(void (^)())block iterations:(NSInteger)iterations
{
  RRBRunner* runner = [[RRBRunner alloc] initWithTimes:iterations];
  block(runner);
}

@end
