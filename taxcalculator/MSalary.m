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
    
    double midBaseShB = [self setUpBaseMoney:self.baseShB minMoney:midBJ maxMoney:maxBJ];
    double baseGJJ = [self setUpBaseMoney:self.baseGJJ minMoney:minGJJBJ maxMoney:maxBJ];
    double lowBaseShB = [self setUpBaseMoney:self.baseShB minMoney:minBJ maxMoney:maxBJ];
    
    self.baseShB = midBaseShB;
    self.baseGJJ = baseGJJ;
    
    MRatio *bjRatio = [MRatio bjRatio];
    
    self.personalYangLLB = lowBaseShB * bjRatio.personalYangLLB;
    self.personalYiLLB = midBaseShB * bjRatio.personalYiLLB+3;
    self.personalGongShLB = lowBaseShB * bjRatio.personalGongShLB;
    self.personalShengYLB = midBaseShB * bjRatio.personalShengYLB;
    self.personalShiYLB = lowBaseShB * bjRatio.personalShiYLB;
    self.personalGongJJLB = baseGJJ * bjRatio.personalGongJJLB;
    
    self.corpYangLLB = lowBaseShB * bjRatio.corpYangLLB;
    self.corpYiLLB = midBaseShB * bjRatio.corpYiLLB+3;
    self.corpGongShLB = lowBaseShB * bjRatio.corpGongShLB;
    self.corpShengYLB = midBaseShB * bjRatio.corpShengYLB;
    self.corpShiYLB = lowBaseShB * bjRatio.corpShiYLB;
    self.corpGongJJLB = baseGJJ * bjRatio.corpGongJJLB;
    
//    self.totalShB = self.personalYangLLB + self.personalYiLLB + self.personalShiYLB + self.personalShengYLB + self.personalGongShLB + self.personalGongJJLB;
    self.personalTotal = self.personalYangLLB + self.personalYiLLB + self.personalShiYLB + self.personalShengYLB + self.personalGongShLB + self.personalGongJJLB;
    self.corpTotal = self.corpYangLLB + self.corpYiLLB + self.corpShiYLB + self.corpShengYLB + self.corpGongShLB + self.corpGongJJLB;
    
    self.tax = [self calculateTax:self.originalSalary-self.personalTotal taxBaseMoney:bjRatio.taxBaseMoney taxStepArray:bjRatio.taxStepArray taxRatioArray:bjRatio.taxRatioArray taxMinusArray:bjRatio.taxMinusArray];
    self.finalSalary = self.originalSalary-self.personalTotal-self.tax;
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

- (double)calculateTax:(double)money taxBaseMoney:(double)taxBaseMoney taxStepArray:(NSArray *)taxStepArray taxRatioArray:(NSArray *)taxRatioArray taxMinusArray:(NSArray *)taxMinusArray
{
    // TODO:
    double baseMoney = money-taxBaseMoney;
    if (baseMoney <= 0) {
        return 0.0;
    }
    int i = 0;
    for (i = 0; i < taxStepArray.count; i++) {
        double stepMoney = [taxStepArray[i] doubleValue];
        if (baseMoney <= stepMoney) {
            return baseMoney * [taxRatioArray[i] doubleValue] - [taxMinusArray[i] doubleValue];
        }
    }
    return baseMoney * [taxRatioArray[i] doubleValue] - [taxMinusArray[i] doubleValue];
}

@end

@implementation MRatio

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
                                                     @"corpGongShLB":@"0.008", @"corpGongJJLB":@"0.12",
                                                     @"taxBaseMoney":@"3500.0",
                                                     @"taxStepArray":@[@1500.0, @4500.0, @9000.0, @35000.0, @55000.0, @80000.0],
                                                     @"taxRatioArray":@[@0.03, @0.1, @0.2, @0.25, @0.3, @0.35, @0.45],
                                                     @"taxMinusArray":@[@0.0, @105.0, @555.0, @1005.0, @2755.0, @5505.0, @13505.0]}];
                   
        
    });
    return bjRatio;
}

@end
