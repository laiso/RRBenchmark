//
//  uuid.mm
//  cocoa
//
//  Created by Kenneth Laskoski on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "uuid.h"

#include "kashmir/uuid.h"
#include "kashmir/devrand.h"

#include <sstream>

@implementation UUID

static kashmir::uuid_t uuid;

+ (NSString *) generateNIL
{
    /* static memory should be zeroed */
    static const kashmir::uuid_t null;
    assert(!null);
    
    uuid = null;
    return [self serialize];
}

+ (NSString *) generateV4
{
    static kashmir::system::DevRand devrandom;

    devrandom >> uuid;

    return [self serialize];
}

+ (NSString *) serialize
{
    std::stringstream buffer;
    buffer << uuid;
    
    return [NSString stringWithUTF8String:buffer.str().c_str()];    
}

@end
