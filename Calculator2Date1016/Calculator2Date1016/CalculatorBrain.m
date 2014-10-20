//
//  CalculatorBrain.m
//  Calculator2Date1016
//
//  Created by Flying_ICE on 14-10-16.
//
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end


@implementation CalculatorBrain

-(NSMutableArray *)operandStack{
    if (!_operandStack) {
        self.operandStack = [[NSMutableArray alloc]init];
    }
    return _operandStack;
}

-(double)popOperand{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

-(void)pushOperand:(double)operand{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

-(double)performOperation:(NSString *)operation{
    double result = 0;
    
    //deal with the situation that not enough operands
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    }else if ([operation isEqualToString:@"*"]){
        result = [self popOperand] * [self popOperand];
    }else if ([operation isEqualToString:@"-"]){
        double secondOperand = [self popOperand];
        result = [self popOperand] - secondOperand;
    }else if ([operation isEqualToString:@"/"]){
        double secondOperand = [self popOperand];
        if (!secondOperand) {
            result = 0;
        }else
            result = [self popOperand] / secondOperand;
    }else if ([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    }else if ([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    }else if ([operation isEqualToString:@"sqrt"]){
        if ([self.operandStack.lastObject doubleValue] < 0) {
            result = 0;
        }else
            result = sqrt([self popOperand]);
    }else if ([operation isEqualToString:@"π"]){
        result = M_PI;
    }else if ([operation isEqualToString:@"+/-"]){
        result = -[self popOperand];
    }
    [self pushOperand:result];
    return result;
}

-(void)cleanBrain{
    [self.operandStack removeAllObjects];
}

@end
