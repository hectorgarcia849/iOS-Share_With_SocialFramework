//
//  ViewController.m
//  networkassignment1
//
//  Created by Hector Garcia on 2016-11-30.
//  Copyright © 2016 Hector Garcia. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *twitterTextView;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreTextView;

- (void) configureTextView: (UITextView *) textView color: (UIColor *) myColor;
- (void) showAlertMessage: (NSString *) network message: (NSString *) myMessage;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *green = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:.2];
    UIColor *blue = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:.2];
    UIColor *red = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:.2];
    [self configureTextView: self.twitterTextView color:green];
    [self configureTextView: self.facebookTextView color:blue];
    [self configureTextView: self.moreTextView color:red];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureTextView: (UITextView *) textView color: (UIColor *) myColor {//programmatically stylizing the textview
    textView.layer.backgroundColor = myColor.CGColor;
    textView.layer.cornerRadius = 10.0;
    textView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    textView.layer.borderWidth = 2.0;
}

- (void) showAlertMessage: (NSString*) network message:(NSString *) myMessage {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle: network message: myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    //add action
    [alertController addAction: [UIAlertAction actionWithTitle:@"Okay" style: UIAlertActionStyleDefault handler:nil]];
    
    //display UIAlertController
    [self presentViewController:alertController animated: YES completion: nil];
    
}

- (IBAction)shareTwitterOption:(id)sender {
    if(self.twitterTextView.isFirstResponder){
        [self.twitterTextView resignFirstResponder];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
    
        SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
        if([self.twitterTextView.text length] < 140) {
            [twitterVC setInitialText: self.twitterTextView.text];
        }
        else{
            NSString *shortText = [self.twitterTextView.text substringToIndex:140];
            [twitterVC setInitialText:shortText];
        }
    
        [self presentViewController:twitterVC animated: YES completion: nil];
    }
    else {
        //raise some sort of object if something wrong. Uses method showAlertMessage which creates another UIAlertController
        [self showAlertMessage: @"Twitter" message: @"Please sign in to Twitter before you tweet"];
}


}

- (IBAction)shareFacebookOption:(id)sender {
    if(self.facebookTextView.isFirstResponder){
        [self.facebookTextView resignFirstResponder];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
       
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebookVC setInitialText:self.facebookTextView.text];
        [self presentViewController:facebookVC animated: YES completion: nil];
    }
    
    else {
        [self showAlertMessage:@"Facebook" message:@"Please sign in to Facebook before you post"];
    }

}

- (IBAction)shareMoreOption:(id)sender {
    UIActivityViewController *moreVC = [[UIActivityViewController alloc]
                                        initWithActivityItems:@[self.moreTextView.text]applicationActivities:nil];
    
    [self presentViewController:moreVC animated: YES completion:nil];
}

- (IBAction)noFunctionOption:(id)sender {
    UIAlertController *noFunc = [UIAlertController alertControllerWithTitle: @"Oops!" message: @"Sorry no function here." preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *noFuncAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [noFunc addAction:noFuncAction];
    [self presentViewController:noFunc animated:YES completion:nil];
    
}


@end
