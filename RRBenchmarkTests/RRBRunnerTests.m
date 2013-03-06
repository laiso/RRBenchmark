#import "TestHelper.h"

SpecBegin(RRBRunner)

describe(@"RRBRunner", ^{
  context(@"initWith 10", ^{
    __block RRBRunner* runner;
    before(^{
      runner = [[RRBRunner alloc] initWithTimes:10];
    });
    
    it(@"increased by `initWithTimes` param", ^{
      __block NSInteger counter = 0;
      [runner name:@"test bench" context:^{
        counter++;
      }];
      
      expect(counter).to.equal(10);
    });

  });
});

SpecEnd

