//
//  NSData+CRC16.m
//  CRC16_iOS
//
//  Created by Echo on 16/3/21.
//  Copyright © 2016年 Liu Xuanyi. All rights reserved.
//

#import "NSData+CRC16.h"

@implementation NSData (CRC16)

-(unsigned short)crc16
{
    const uint8_t *bytes = (const uint8_t *)[self bytes];
    uint16_t length = (uint16_t)[self length];
    return (unsigned short)gen_crc16(bytes, length);
}

#define CRC16 0x8005

uint16_t gen_crc16(const uint8_t *data, uint16_t size)
{
    uint16_t out = 0;
    int bits_read = 0, bit_flag;
    
    if(data == NULL)
        return 0;
    
    while(size > 0)
    {
        bit_flag = out >> 15;
        
        out <<= 1;
        out |= (*data >> bits_read) & 1;
        
        bits_read++;
        if(bits_read > 7)
        {
            bits_read = 0;
            data++;
            size--;
        }
        
        if(bit_flag)
            out ^= CRC16;
        
    }
    
    int i;
    for (i = 0; i < 16; ++i) {
        bit_flag = out >> 15;
        out <<= 1;
        if(bit_flag)
            out ^= CRC16;
    }
    
    uint16_t crc = 0;
    i = 0x8000;
    int j = 0x0001;
    for (; i != 0; i >>=1, j <<= 1) {
        if (i & out) crc |= j;
    }
    
    return crc;
}

@end
