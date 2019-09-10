//
//  DetailViewController.m
//  Homepwner
//
//  Created by rhino Q on 26/08/2019.
//  Copyright © 2019 rhino Q. All rights reserved.
//

#import "DetailViewController.h"
#import "Model/BNRItem.h"
#import "DatePickerViewController.h"
#import "Model/BNRImageStore.h"

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
    
    NSString *imageKey = [_item imageKey];
    
    if(imageKey) {
        //Get image for image key from image store
        UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
        
        // Use that image to put on the screen in imageView
        [_imageView setImage:imageToDisplay];
    } else {
        // Clear the imageView
        [_imageView setImage:nil];
    }
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
- (IBAction)changeDateButtonAction:(UIButton *)sender {
    DatePickerViewController *datePickerVC = [DatePickerViewController new];
    datePickerVC.item = self.item;
    [[self navigationController] pushViewController:datePickerVC animated:YES];
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // If our device has a camera, we want to take a picture, otherwise,
    // we just pick from photo library
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePicker setAllowsEditing:YES];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    imagePicker.allowsEditing = YES;
    [imagePicker setDelegate:self];
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    NSString *oldKey = [_item imageKey];
    //Did the item already have an image?
    if(oldKey) {
        // Delete the old image
        [[BNRImageStore sharedStore] deleteImageForKey:oldKey];
    }
    
    //Get picked image from info dictionary
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    // Create a CFUUID object  it knows how to create unique identifier strings
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    
    //Create a string from unique identifier
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    
    // Use taht unique ID to set our item's imageKey
    NSString *key = (__bridge NSString*)newUniqueIDString;
    [_item setImageKey:key];
    
    //Store image in the BNRImageStore with this key
    [[BNRImageStore sharedStore] setImage:image forkey:[_item imageKey]];
    
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueId);
    
    
    //Put that iimage onto the screen in our image view
    [_imageView setImage:image];
    
    //Take iamge picker off the screen
    //you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backgoundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
