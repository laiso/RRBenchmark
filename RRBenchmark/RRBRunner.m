#import "RRBRunner.h"

@interface RRBRunner()
@property(assign, nonatomic) NSInteger times;
@end

@implementation RRBRunner

@synthesize times = _times;

- (id)initWithTimes:(NSInteger)times
{
  self = [super init];
  if(self){
    self.times = times;
  }
  return self;
}

- (void)report:(NSString *)name context:(void (^)())block
{
  NSMutableArray* results = [NSMutableArray array];
  
  for (int i=0; i<self.times; i++) {
    NSDate* start = [NSDate date];
    block();
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:start];
    [results addObject:[NSNumber numberWithFloat:time]];
  }
  
  float min = -1;
  float max = -1;
  float total = 0;
  for (NSNumber* num in results) {
    float f = [num floatValue];
    if(min == -1 || min > f) min = f;
    if(max < f) max = f;
    total += f;
  }
  
  NSLog(@"| total:%.3f min:%.3f max:%.3f average:%.3f | %@ ", total, min, max, total/self.times, name);
}

@end
