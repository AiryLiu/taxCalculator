//
//  MSalary.m
//  taxcalculator
//
//  Created by LiuX on 15/9/6.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "MSalary.h"



@implementation MSalary

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)doCalculate
{
    if (self.originalSalary <= 0) {
        return;
    }
    if (self.baseShB <= 0) {
        self.baseShB = self.originalSalary;
    }
    if (self.baseGJJ <= 0) {
        self.baseGJJ = self.originalSalary;
    }
    
    
}

@end
