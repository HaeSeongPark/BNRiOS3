//
//  DetailViewController.m
//  Homepwner
//
//  Created by rhino Q on 26/08/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "DetailViewController.h"
#import "Model/BNRItem.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [nameField setText:_item.itemName];
    [serialNumberField setText:[_item serialNumber]];
    valueField.text = [NSString stringWithFormat:@"%d", [_item valueInDollars]];
    
    // Create a NSDateFormatter that will turn a date into a simple date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Use filetered NSDate object to set dateLabel contents
    [dateLabel setText:[dateFormatter stringFromDate:[_item dateCreated]]];
    
    [self addDoneButtonOnKeyboard];
}

- (void)setItem:(BNRItem *)i {
    _item = i;
    [[self navigationItem] setTitle:[_item itemName]];
}
//https://stackoverflow.com/questions/38133853/how-to-add-a-return-key-on-a-decimal-pad-in-swift
-(void) addDoneButtonOnKeyboard {
    UIToolbar *doneToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    doneToolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *flexSapce = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction)];
    
    NSArray *items = [NSArray arrayWithObjects:flexSapce,done, nil];
    doneToolbar.items = items;
    [doneToolbar sizeToFit];
    self.valueTextField.inputAccessoryView = doneToolbar;
}

-(void)doneButtonAction {
    [self.valueTextField resignFirstResponder];
}
@end
