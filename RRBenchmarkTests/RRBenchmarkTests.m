#import "TestHelper.h"

SpecBegin(RRBenchmark)

describe(@"RRBenchmark", ^{
  context(@"class methods", ^{
    __block NSInteger counter;
    before(^{
      counter = 0;
    });
    
    it(@"increased by iterations param", ^{
      [RRBenchmark benchmark:^(RRBRunner* runner){
        [runner name:@"test bench" context:^{
          counter++;
        }];
      } iterations:10];
      
      expect(counter).to.equal(10);
    });
    
    it(@"increased by iterations param * run block", ^{
      [RRBenchmark benchmark:^(RRBRunner* runner){
        [runner name:@"test bench" context:^{
          counter++;
        }];
        
        [runner name:@"test bench" context:^{
          counter++;
        }];
      } iterations:10];
      
      expect(counter).to.equal(20);
    });
  });
});

SpecEnd