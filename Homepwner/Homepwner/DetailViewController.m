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
//    UIToolbar *doneToolbar = [UIToolbar initWith]
}
//func addDoneButtonOnKeyboard()
//{
//    let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
//    doneToolbar.barStyle = UIBarStyle.Default
//
//    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//    let done: UIBarButtonItem = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
//
//    var items = [UIBarButtonItem]()
//    items.append(flexSpace)
//    items.append(done)
//
//    doneToolbar.items = items
//    doneToolbar.sizeToFit()
//
//    self.txtNumber.inputAccessoryView = doneToolbar
//
//}
//
//func doneButtonAction()
//{
//    self.txtNumber.resignFirstResponder()
//}
@end
