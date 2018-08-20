//
//  AddressData.m
//  NugaWau
//
//  Created by pkh on 12. 7. 4..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "AddressData.h"
//회원 정보
@implementation AddressData

@synthesize m_name, m_number;                                           // 이름, 전화번호

-(id)init
{
    self = [super init];
    if (self)
    {
        m_name = nil;
        m_number = nil;
    }
    return self;
}

@end

//회원 UI데이터
@implementation AddressUIData

@synthesize m_firstChosung, m_allchosung, m_utf8;          // 레코드 id, 초성, 전체 초성, 유니코드 값
@synthesize m_selected; // 선택 여부     
//@synthesize m_rangeName;
//@synthesize m_rangeNum;
//@synthesize m_rangelableName;
//@synthesize m_rangelableNum;
@synthesize m_korToEng;
@synthesize m_numberUI;


-(id)init
{
    self = [super init];
    if (self)
    {
        m_allchosung = nil;
        m_selected = NO;
        m_firstChosung = nil;
        m_utf8 = nil;
        m_numberUI = nil;
    }
    return self;
}

@end
