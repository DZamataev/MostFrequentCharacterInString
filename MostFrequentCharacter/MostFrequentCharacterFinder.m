//
//  MostFrequentCharacterFinder.m
//  MostFrequentCharacter
//
//  Created by Denis Zamataev on 06/07/15.
//  Copyright (c) 2015 Mysterious Organization. All rights reserved.
//

#import "MostFrequentCharacterFinder.h"

@implementation MostFrequentCharacterFinder
+ (NSString *)mostFrequentCharacterInString:(NSString *)string {
    if (!string || !string.length) {
        return nil;
    }
    
    NSInteger threadsNum = 2;
    
    NSMutableArray *allCharactersArray = [[NSMutableArray alloc] initWithCapacity:[string length]];
    for (int i=0; i < [string length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        [allCharactersArray addObject:ichar];
    }
    
    NSInteger length = allCharactersArray.count;
    NSInteger subLength = length/threadsNum;
    
    NSMutableArray *chunksArray = [[NSMutableArray alloc] init];
    NSInteger chunkCursor = 0;
    for (NSInteger i = 0; i < threadsNum; i++) {
        NSArray *chunkArray = [allCharactersArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(chunkCursor, subLength)]];
        chunkCursor += subLength;
        [chunksArray addObject:chunkArray];
    }
    
    NSMutableDictionary *resultDictionary = [NSMutableDictionary new];
    
    [chunksArray enumerateObjectsWithOptions: NSEnumerationConcurrent usingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *chunk = obj;
        [chunk enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *character = obj;
            NSNumber *value = resultDictionary[character];
            if (!value) {
                value = @(0);
            }
            else {
                value = @(value.integerValue+1);
            }
            [resultDictionary setObject:value forKey:character];
        }];
    }];
    
    NSArray *sortedResultKeys = [resultDictionary keysSortedByValueUsingComparator:^(id obj1, id obj2) {
        return (NSComparisonResult)[obj1 compare:obj2];
    }];
    
    return sortedResultKeys.lastObject;
}
@end
