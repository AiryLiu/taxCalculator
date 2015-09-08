//
//  ViewController.m
//  taxcalculator
//
//  Created by LiuX on 15/9/6.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "ViewController.h"

#import "MSalary.h"

typedef enum {
    TCInputTypeOriginalSalary = 1001,
    TCInputTypeBaseSheBao = 1002,
    TCInputTypeBaseGongJJ = 1003,
} TCInputType;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@property (weak, nonatomic) IBOutlet UITextField *oriSalaryTF;
@property (weak, nonatomic) IBOutlet UITextField *baseShBTF;
@property (weak, nonatomic) IBOutlet UITextField *baseGJJTF;

@property (weak, nonatomic) IBOutlet UILabel *finalSalaryLB;
@property (weak, nonatomic) IBOutlet UILabel *taxLB;
@property (weak, nonatomic) IBOutlet UILabel *sheBaoLB;

@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UILabel *personalYangLLB;
@property (weak, nonatomic) IBOutlet UILabel *personalYiLLB;
@property (weak, nonatomic) IBOutlet UILabel *personalShiYLB;
@property (weak, nonatomic) IBOutlet UILabel *personalShengYLB;
@property (weak, nonatomic) IBOutlet UILabel *personalGongShLB;
@property (weak, nonatomic) IBOutlet UILabel *personalGongJJLB;

@property (weak, nonatomic) IBOutlet UILabel *corpYangLLB;
@property (weak, nonatomic) IBOutlet UILabel *corpYiLLB;
@property (weak, nonatomic) IBOutlet UILabel *corpShiYLB;
@property (weak, nonatomic) IBOutlet UILabel *corpShengYLB;
@property (weak, nonatomic) IBOutlet UILabel *corpGongShLB;
@property (weak, nonatomic) IBOutlet UILabel *corpGongJJLB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.bgScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backpersonaloundTapped:)]];
    
    self.oriSalaryTF.tag = TCInputTypeOriginalSalary;
    self.baseShBTF.tag = TCInputTypeBaseSheBao;
    self.baseGJJTF.tag = TCInputTypeBaseGongJJ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backpersonaloundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)calculateButtonClicked:(UIButton *)sender
{
    CGFloat oriSalary = [self.oriSalaryTF.text doubleValue];
    CGFloat baseShB = [self.baseShBTF.text doubleValue];
    CGFloat baseGJJ = [self.baseGJJTF.text doubleValue];
    
    [self doCalculateWithBaseSalary:oriSalary baseShB:baseShB baseGJJ:baseGJJ];
}

- (void)doCalculateWithBaseSalary:(CGFloat)baseSalary baseShB:(CGFloat)baseShB baseGJJ:(CGFloat)baseGJJ
{
    MSalary *salary = [[MSalary alloc] init];
    
    salary.originalSalary = baseSalary;
    salary.baseShB = baseShB;
    salary.baseGJJ = baseGJJ;
    
    [salary doCalculate];
    
    [self updateViewsWithSalary:salary];
}

- (void)updateViewsWithSalary:(MSalary *)salary
{
    self.finalSalaryLB.text = [NSString stringWithFormat:@"%.2f", salary.finalSalary];
    self.taxLB.text = [NSString stringWithFormat:@"%.2f", salary.tax];
    self.sheBaoLB.text = [NSString stringWithFormat:@"%.2f", salary.totalShB];
    
    self.personalYangLLB.text = [NSString stringWithFormat:@"%.2f", salary.personalYangLLB];
    self.personalYiLLB.text = [NSString stringWithFormat:@"%.2f", salary.personalYiLLB];
    self.personalShiYLB.text = [NSString stringWithFormat:@"%.2f", salary.personalShiYLB];
    self.personalShengYLB.text = [NSString stringWithFormat:@"%.2f", salary.personalShengYLB];
    self.personalGongShLB.text = [NSString stringWithFormat:@"%.2f", salary.personalGongShLB];
    self.personalGongJJLB.text = [NSString stringWithFormat:@"%.2f", salary.personalGongJJLB];
    
    self.corpYangLLB.text = [NSString stringWithFormat:@"%.2f", salary.corpYangLLB];
    self.corpYiLLB.text = [NSString stringWithFormat:@"%.2f", salary.corpYiLLB];
    self.corpShiYLB.text = [NSString stringWithFormat:@"%.2f", salary.corpShiYLB];
    self.corpShengYLB.text = [NSString stringWithFormat:@"%.2f", salary.corpShengYLB];
    self.corpGongShLB.text = [NSString stringWithFormat:@"%.2f", salary.corpGongShLB];
    self.corpGongJJLB.text = [NSString stringWithFormat:@"%.2f", salary.corpGongJJLB];
}

@end
