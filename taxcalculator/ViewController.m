//
//  ViewController.m
//  taxcalculator
//
//  Created by LiuX on 15/9/6.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "ViewController.h"

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

@property (weak, nonatomic) IBOutlet UILabel *grYangLLB;
@property (weak, nonatomic) IBOutlet UILabel *grYiLLB;
@property (weak, nonatomic) IBOutlet UILabel *grShiYLB;
@property (weak, nonatomic) IBOutlet UILabel *grShengYLB;
@property (weak, nonatomic) IBOutlet UILabel *grGongShLB;
@property (weak, nonatomic) IBOutlet UILabel *grGongJJLB;

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
    [self.bgScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)]];
    
    self.oriSalaryTF.tag = TCInputTypeOriginalSalary;
    self.baseShBTF.tag = TCInputTypeBaseSheBao;
    self.baseGJJTF.tag = TCInputTypeBaseGongJJ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)calculateButtonClicked:(UIButton *)sender
{
    
}

@end
