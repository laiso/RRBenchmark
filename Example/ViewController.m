#import "ViewController.h"

#import <Security/Security.h>
#import "uuid.h"
#import "RRBenchmark.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.row) {
    case 0: [self benchmark]; break;
    case 1: [self benchmark1]; break;
    case 2: [self benchmark2]; break;
  }
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)benchmark
{
  [RRBenchmark benchmark:^(RRBRunner* runner){
    [runner report:@"NSUUID" context:^{
      NSString* uid = [[NSUUID UUID] UUIDString];
      NSAssert(uid, nil);
    }];
    
    [runner report:@"CFUUID" context:^{
      CFUUIDRef uuid = CFUUIDCreate(nil);
      NSString* uid =  (__bridge NSString*)CFUUIDCreateString(nil, uuid);
      CFRelease(uuid);
      NSAssert(uid, nil);
    }];
    
    [runner report:@"ooid" context:^{
      NSString* uid = [UUID generateV4];
      NSAssert(uid, nil);
    }];
    
  } iterations:10000];
}

- (void)benchmark1
{
  int count = 10000;
  [RRBenchmark benchmark:^(RRBRunner* runner){
    NSMutableDictionary* testData = [NSMutableDictionary dictionary];
    for (int i=0; i<count; i++) {
      [testData setObject:[NSNumber numberWithInt:i] forKey:@"key"];
    }
    
    NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"/test.data"];
    
    [runner report:@"NSUserDefaults" context:^{
      NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
      [userDefaults setObject:testData forKey:@"benchmark"];
      BOOL success = [userDefaults synchronize];
      NSAssert(success, nil);
    }];
    
    [runner report:@"NSKeyedArchiver" context:^{
      BOOL success = [NSKeyedArchiver archiveRootObject:testData toFile:path];
      NSAssert(success, nil);
    }];
    
    [runner report:@"Keychain" context:^{
      OSStatus err = SecItemAdd((__bridge CFDictionaryRef)testData, NULL);
      NSAssert(err != noErr, nil);
    }];
    
  } iterations:100];
}

- (void)benchmark2
{
  [RRBenchmark benchmark:^(RRBRunner* runner){
    NSInteger count = 10000;
    
    [runner report:@"[NSMutableArray array]" context:^{
      NSMutableArray* stack = [NSMutableArray array];
      for (int i=0; i<count; i++) {
        [stack addObject:[[NSUUID UUID] UUIDString]];
      }
    }];
    
    [runner report:@"[NSMutableArray arrayWithCapacity:1000]" context:^{
      NSMutableArray* stack = [NSMutableArray arrayWithCapacity:count];
      for (int i=0; i<count; i++) {
        [stack addObject:[[NSUUID UUID] UUIDString]];
      }
    }];
    
    [runner report:@"[NSMutableSet set]" context:^{
      NSMutableSet* stack = [NSMutableSet set];
      for (int i=0; i<count; i++) {
        [stack addObject:[[NSUUID UUID] UUIDString]];
      }
    }];
    
  } iterations:100];
}

@end
