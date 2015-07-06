//
//  main.m
//  MostFrequentCharacter
//
//  Created by Denis Zamataev on 06/07/15.
//  Copyright (c) 2015 Mysterious Organization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MostFrequentCharacterFinder.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *inputString = @"ASkjnasdvASvMn<ZVAdsvkjASfaIOAU";
        NSString *mostFrequentCharacter = [MostFrequentCharacterFinder mostFrequentCharacterInString:inputString];
        NSLog(@"Most frequent character in string:\n%@\nis:\n%@", inputString, mostFrequentCharacter);
    }
    return 0;
}
