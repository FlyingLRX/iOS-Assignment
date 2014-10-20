//
//  CalculatorViewController.m
//  Calculator2Date1016
//
//  Created by Flying_ICE on 14-10-16.
//
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *AllSentToTheBrain;//显示用户输入到Brain的一切信息
@property (nonatomic) BOOL isEnteringNumber;//判断用户是否正在输入运算数
@property (nonatomic, strong) CalculatorBrain *brain;//计算Model的指针
@end

@implementation CalculatorViewController

//Model的Lazy initialization
-(CalculatorBrain *)brain{
    if (_brain == nil) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

//数字按键被按下时触发
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    //如果用户正在输入中，则接驳数字，否则直接修改现有文本
    if (self.isEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.isEnteringNumber = YES;
    }
}

//Enter键被按下时触发
- (IBAction)enterPressed {
    NSString *rightNumberForPush = self.display.text;
    //预防用户输入“.5”这样的有误小数，作纠正
    if ([rightNumberForPush hasPrefix:@"."]) {
        rightNumberForPush = [rightNumberForPush stringByReplacingOccurrencesOfString:@"." withString:@"0."];
    }
    if (self.isEnteringNumber) {
        //只有当前self.display.text是数字时（不包括π）才添加到 (UILabel *)AllSentToTheBrain
        [self appendWithUserEntering:rightNumberForPush];
    }
    [self.brain pushOperand:[rightNumberForPush doubleValue]];
    self.isEnteringNumber = NO;
}

//运算符按下时触发
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.isEnteringNumber && [[sender currentTitle] isEqualToString:@"+/-"]) {
        if ([self.display.text hasPrefix:@"-"]) {
            self.display.text = [self.display.text substringFromIndex:1];
        }else {
            self.display.text = [NSString stringWithFormat:@"-%@", self.display.text];
        }
        return;
    }
    
    if(self.isEnteringNumber) {
        [self enterPressed];
    }
    [self appendWithUserEntering:[[sender currentTitle] stringByAppendingString:@" ="]];
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.isEnteringNumber = NO;
}

//删除键"←"按下触发
- (IBAction)backspacePressed {
    if (self.display.text.length == 1) {
        self.display.text = @"0";
        self.isEnteringNumber = NO;
        return;
    }else
        self.display.text = [self.display.text substringToIndex:self.display.text.length - 1];
}

//改变当前数值正负号
//- (IBAction)changeSignPressed {
//    if (self.isEnteringNumber) {
//        if ([self.display.text hasPrefix:@"-"]) {
//            self.display.text = [self.display.text substringFromIndex:1];
//        } else {
//            self.display.text = [NSString stringWithFormat:@"-%@", self.display.text];
//        }
//    }else{
//        //if self.isEnteringNumber == NO
//    }
//}

//清除键“C”键被按下时触发
- (IBAction)cleanAll {
    //clean the display
    self.display.text = @"0";
    self.isEnteringNumber = NO;
    
    //clean the sentToBrain
    self.AllSentToTheBrain.text = @"";
    
    //clean the Brain
    [self.brain cleanBrain];
    
    self.isEnteringNumber = NO;
}

//显示用户输入的信息的辅助函数
-(void)appendWithUserEntering:(NSString *)userEnter{
    self.AllSentToTheBrain.text = [self.AllSentToTheBrain.text stringByAppendingFormat:@" %@", userEnter];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
