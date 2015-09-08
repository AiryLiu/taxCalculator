//
//  MSalary.m
//  taxcalculator
//
//  Created by LiuX on 15/9/6.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "MSalary.h"

static double const averageBJ = 6463;
static double const maxBJ = 19389;// 300%
static double const midBJ = 3878;// 60%
static double const minBJ = 2585;// 40%
static double const minGJJBJ = 1720;

@implementation MSalary

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        // set up
        [self setUpWithDictionary:dictionary];
    }
    return self;
}

- (void)setUpWithDictionary:(NSDictionary *)dictionary
{
    NSArray *allKeys = [dictionary allKeys];
    for (NSString *key in allKeys) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:dictionary[key] forKey:key];
        }
    }
}

- (void)doCalculate
{
    if (self.originalSalary <= 0) {
        return;
    }
    
    MRatio *bjRatio = [MRatio bjRatio];
    
    self.personalYangLLB = self.baseShB * bjRatio.personalYangLLB;
    self.personalYiLLB = self.baseShB * bjRatio.personalYiLLB;
    self.personalGongShLB = self.baseShB * bjRatio.personalGongShLB;
    self.personalShengYLB = self.baseShB * bjRatio.personalShengYLB;
    self.personalShiYLB = self.baseShB * bjRatio.personalShiYLB;
    self.personalGongJJLB = self.baseGJJ * bjRatio.personalGongJJLB;
    
    self.corpYangLLB = self.baseShB * bjRatio.corpYangLLB;
    self.corpYiLLB = self.baseShB * bjRatio.corpYiLLB;
    self.corpGongShLB = self.baseShB * bjRatio.corpGongShLB;
    self.corpShengYLB = self.baseShB * bjRatio.corpShengYLB;
    self.corpShiYLB = self.baseShB * bjRatio.corpShiYLB;
    self.corpGongJJLB = self.baseGJJ * bjRatio.corpGongJJLB;
    
    self.totalShB = self.personalYangLLB + self.personalYiLLB + self.personalShiYLB + self.personalShengYLB + self.personalGongShLB + self.personalGongJJLB;
    self.tax = [self calculateTax:self.originalSalary-self.totalShB];
    self.finalSalary = self.originalSalary-self.totalShB-self.tax;
}

- (double)calculateMoney:(double)money ratio:(double)ratio minMoney:(double)minMoney maxMoney:(double)maxMoney
{
    double baseMoney = [self setUpBaseMoney:money minMoney:minMoney maxMoney:maxMoney];
    return baseMoney * ratio;
}

- (double)setUpBaseMoney:(double)money minMoney:(double)minMoney maxMoney:(double)maxMoney
{
    if (money < minMoney) {
        return minMoney;
    }
    if (money > maxMoney) {
        return maxMoney;
    }
    return money;
}

- (double)calculateTax:(double)money
{
    // TODO:
    return 0.0;
}

@end

@implementation MRatio
/*
 @property (nonatomic, assign) double personalYangLLB;
 @property (nonatomic, assign) double personalYiLLB;
 @property (nonatomic, assign) double personalShiYLB;
 @property (nonatomic, assign) double personalShengYLB;
 @property (nonatomic, assign) double personalGongShLB;
 @property (nonatomic, assign) double personalGongJJLB;
 
 @property (nonatomic, assign) double corpYangLLB;
 @property (nonatomic, assign) double corpYiLLB;
 @property (nonatomic, assign) double corpShiYLB;
 @property (nonatomic, assign) double corpShengYLB;
 @property (nonatomic, assign) double corpGongShLB;
 @property (nonatomic, assign) double corpGongJJLB;
 */

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        // set up
        [self setUpWithDictionary:dictionary];
    }
    return self;
}

- (void)setUpWithDictionary:(NSDictionary *)dictionary
{
    NSArray *allKeys = [dictionary allKeys];
    for (NSString *key in allKeys) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:dictionary[key] forKey:key];
        }
    }
}

+ (instancetype)bjRatio
{
    static id bjRatio = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bjRatio = [[self alloc] initWithDictionary:@{@"personalYangLLB":@"0.08", @"personalYiLLB":@"0.02",
                                                     @"personalShiYLB":@"0.002", @"personalShengYLB":@"0",
                                                     @"personalGongShLB":@"0", @"personalGongJJLB":@"0.12",
                                                     @"corpYangLLB":@"0.2", @"corpYiLLB":@"0.1",
                                                     @"corpShiYLB":@"0.01", @"corpShengYLB":@"0.008",
                                                     @"corpGongShLB":@"0.008", @"corpGongJJLB":@"0.12"}];
        
    });
    return bjRatio;
}

@end
