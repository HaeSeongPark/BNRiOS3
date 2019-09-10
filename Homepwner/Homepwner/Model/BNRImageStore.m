//
//  BNRImageStore.m
//  Homepwner
//
//  Created by rhino Q on 04/09/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "BNRImageStore.h"

@implementation BNRImageStore

+(instancetype)sharedStore {
    static BNRImageStore *defaultImageStore = nil;
    if(!defaultImageStore)
        defaultImageStore = [[BNRImageStore alloc] init];
    return defaultImageStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)i forkey:(NSString *)s {
    [dictionary setObject:i forKey:s];
}

- (UIImage *)imageForKey:(NSString *)s {
    return [dictionary objectForKey:s];
}

- (void)deleteImageForKey:(NSString *)s {
    if(!s)
        return;
    [dictionary removeObjectForKey:s];
}

@end
