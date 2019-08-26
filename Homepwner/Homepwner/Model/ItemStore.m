//
//  ItemStore.m
//  Homepwner
//
//  Created by rhino Q on 14/08/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "ItemStore.h"
#import "BNRItem.h"

@implementation ItemStore

+ (instancetype)sharedStore {
    static ItemStore *sharedStore = nil;
    if(!sharedStore)
        sharedStore = [[ItemStore alloc] init];
    return sharedStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _allItems = [[NSMutableArray alloc] init];
        _itemsMoreThan = [[NSMutableArray alloc] init];
        _itemsRest = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)removeItem:(BNRItem *)p {
    [_allItems removeObjectIdenticalTo:p];
}

- (BNRItem *)createItem {
    BNRItem *p = [BNRItem randomItem];
    [_allItems addObject:p];
    return p;
}

- (void)divideInValue:(int)value {
    if ( [self allItems].count <= 0 ) { return; }
    for (BNRItem* item in [self allItems]) {
        if(item.valueInDollars > value) {
            [_itemsMoreThan addObject:item];
        } else {
            [_itemsRest addObject:item];
        }
    }
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    if (from == to) {
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    BNRItem *p = [_allItems objectAtIndex:from];
    
    // Remove p from array
    [_allItems removeObjectAtIndex:from];
    
    // Insert p in array at new location
    [_allItems insertObject:p atIndex:to];
}

@end
