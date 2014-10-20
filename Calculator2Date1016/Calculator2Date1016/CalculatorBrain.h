//
//  CalculatorBrain.h
//  Calculator2Date1016
//
//  Created by Flying_ICE on 14-10-16.
//
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
//把运算数压栈
-(void)pushOperand:(double)operand;

//对运算符进行相应的运算
-(double)performOperation:(NSString *)operation;

//清除计算器的计算历史信息
-(void)cleanBrain;
@end
