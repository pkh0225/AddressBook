//
//  AddressData.h
//  NugaWau
//
//  Created by pkh on 12. 7. 4..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum AddressSearchType {
    AddressSearchTypeNone          = 0,
    AddressSearchTypeName          = 1,
    AddressSearchTypeNumber        = 2,
    AddressSearchTypeChoSung       = 3,
    AddressSearchTypeUTF8          = 4,
    AddressSearchTypeEnglish       = 5
} AddressSearchType;

@interface AddressData : NSObject                       //주소록

@property (nonatomic, retain) NSString *m_name;         // 이름
@property (nonatomic, retain) NSString *m_number;       // 전화번호
@end

@interface AddressUIData : AddressData                  //주소록

@property (nonatomic, retain) NSString *m_numberUI;         // 화면에 보여질 전화번호
@property (nonatomic, assign) BOOL m_selected;              // 선택여부
@property (nonatomic, retain) NSString *m_firstChosung;     // 시작초성
@property (nonatomic, retain) NSString *m_allchosung;       // 전체초성
@property (nonatomic, retain) NSString *m_utf8;             // 이름(utp8)
@property (nonatomic, retain) NSString *m_korToEng;         // 자판에 따른 한글을 영문으로
@property (nonatomic, assign) AddressSearchType searchType;


@end
