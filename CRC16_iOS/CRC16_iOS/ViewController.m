//
//  ViewController.m
//  CRC16_iOS
//
//  Created by Echo on 16/3/21.
//  Copyright © 2016年 Liu Xuanyi. All rights reserved.
//

#import "ViewController.h"
#import "NSData+CRC16.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Byte sendInfo[16];
    sendInfo[0] = 57;
    sendInfo[1] = 101;
    sendInfo[2] = 102;
    sendInfo[3] = 98;
    
    sendInfo[4] = 100;
    sendInfo[5] = 101;
    sendInfo[6] = 55;
    sendInfo[7] = 49;
    
    sendInfo[8] = 53;
    sendInfo[9] = 99;
    sendInfo[10] = 54;
    sendInfo[11] = 49;
    
    sendInfo[12] = 52;
    sendInfo[13] = 51;
    sendInfo[14] = 101;
    sendInfo[15] = 100;
    
    NSMutableData *sendData = [[NSMutableData alloc] initWithBytes:sendInfo length:sizeof(sendInfo)];
    
    unsigned short checksum = [sendData crc16];
    unsigned short swapped = CFSwapInt16LittleToHost(checksum);
    char *a = (char*) &swapped;
    [sendData appendBytes:a length:sizeof(4)];
    
    //检验
    Byte *b1 = (Byte *)[sendData bytes];
    NSLog(@"===============================================");
    for (int i = 0; i < sendData.length; i++) {
        NSLog(@"b1[%d] == %d",i,b1[i]);
    }
    NSLog(@"b1:%@",[sendData base64EncodedStringWithOptions:0]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
