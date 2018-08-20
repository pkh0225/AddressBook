//
//  AddressBookViewController.m
//  S.COM
//
//  Created by pkh on 2016. 6. 27..
//  Copyright © 2016년 Hojun Kim. All rights reserved.
//
#import <AddressBook/AddressBook.h>
#import "AddressBookViewController.h"
#import "NSString+Helper.h"
#import "AddressBookCell.h"

typedef enum
{
    kENTERTYPE = '\n',
    kLINETYPE = '-',
    kSPACETYPE = ' ',
    kNONE = 0
}StrDivideType;

#define CELL_ADDRESSBOOK @"AddressBookCell"
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
@interface AddressBookViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *m_indexkey;                                     // 성의 초성 값
    NSArray *m_AdressBooks;                                         //
    NSArray *m_tableData;                                           // 사용자 전화번호부 데이터를 가진 데이터
    NSMutableArray *m_SearchData;                                   // 검색 시 대응하는 데이터를 가진 데이터
    BOOL m_isSearchMode;
}

@property (strong, nonatomic) NSArray *chosung;
@property (strong, nonatomic) NSArray *jungsung;
@property (strong, nonatomic) NSArray *jongsung;
@property (strong, nonatomic) NSArray *chosungENG;
@property (strong, nonatomic) NSArray *jungsungENG;
@property (strong, nonatomic) NSArray *jongsungENG;
@property (strong, nonatomic) NSArray *mobileNumber;
@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self.tView registerNib:[UINib nibWithNibName:CELL_ADDRESSBOOK bundle:nil] forCellReuseIdentifier:CELL_ADDRESSBOOK];
    m_tableData = [self makeAllocTableData];                                       // 주소록 데이터 그룹화해서 가져옴
    [self.tView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    m_SearchData = [[NSMutableArray alloc]init];
    self.chosung = [[NSArray alloc] initWithObjects:@"ㄱ",@"ㄲ",@"ㄴ",@"ㄷ",@"ㄸ",@"ㄹ",@"ㅁ",@"ㅂ",@"ㅃ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅉ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ",nil];
    
    self.jungsung = [[NSArray alloc] initWithObjects:@"ㅏ",@"ㅐ",@"ㅑ",@"ㅒ",@"ㅓ",@"ㅔ",@"ㅕ",@"ㅖ",@"ㅗ",@"ㅘ",@"ㅙ",@"ㅚ",@"ㅛ",@"ㅜ",@"ㅝ",@"ㅞ",@"ㅟ",@"ㅠ",@"ㅡ",@"ㅢ",@"ㅣ",nil];
    self.jongsung = [[NSArray alloc] initWithObjects:@"",@"ㄱ",@"ㄲ",@"ㄳ",@"ㄴ",@"ㄵ",@"ㄶ",@"ㄷ",@"ㄹ",@"ㄺ",@"ㄻ",@"ㄼ",@"ㄽ",@"ㄾ",@"ㄿ",@"ㅀ",@"ㅁ",@"ㅂ",@"ㅄ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ",nil];
    self.chosungENG = [[NSArray alloc] initWithObjects:@"r",@"R",@"s",@"e",@"E",@"f",@"a",@"q",@"Q",@"t",@"T",@"d",@"w",@"W",@"c",@"z",@"x",@"v",@"g",nil];
    self.jungsungENG = [[NSArray alloc] initWithObjects:@"k",@"o",@"i",@"O",@"j",@"p",@"u",@"P",@"h",@"hk",@"ho",@"hl",@"y",@"n",@"nj",@"np",@"nl",@"b",@"m",@"ml",@"l",nil];
    self.jongsungENG = [[NSArray alloc] initWithObjects:@"",@"r",@"R",@"rt",@"s",@"sw",@"sg",@"e",@"f",@"fr",@"fa",@"fq",@"ft",@"fx",@"fv",@"fg",@"a",@"q",@"qt",@"t",@"T",@"d",@"w",@"c",@"z",@"x",@"v",@"g",nil];
    self.mobileNumber = [[NSArray alloc] initWithObjects:@"010", @"011",@"016",@"017",@"018",@"019",nil];
}

- (NSArray*)makeAllocTableData
{
    m_indexkey = [[NSMutableArray alloc] init];                         // 초성으로 그룹화하기위한 키
    NSMutableArray *tabledata = [[NSMutableArray alloc] init];
    NSArray *arrAD = [self getAllocAdressBooks];
    
    NSInteger indexKey = 0;
    
    while (indexKey < [arrAD count])
    {
        //        NSLog(@"indexKey = %d",indexKey);
        NSMutableArray *groupDatas = [[NSMutableArray alloc] init];
        AddressUIData *ChoKey = [arrAD objectAtIndex:indexKey];
        
        for (NSInteger i = indexKey; i < [arrAD count]; i++) {
            AddressUIData *ad = [arrAD objectAtIndex:i];
            if ([ChoKey.m_firstChosung isEqualToString:ad.m_firstChosung])
            {
                [groupDatas addObject:ad];
            }
            else
            {
                break;
            }
            indexKey++;
        }
        if ([groupDatas count] > 0)
        {
            [tabledata addObject:groupDatas];
            [m_indexkey addObject:ChoKey.m_firstChosung];
        }
        
    }
    
    return tabledata;
    
}

-(NSArray*)getAllocAdressBooks
{
    
   
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    __block BOOL accessGranted = YES;
    // 내부 전화번호 LOAD
    ABAddressBookRef addressBook;
    if (SYSTEM_VERSION_LESS_THAN(@"6.0"))
    {
        addressBook = ABAddressBookCreate();
    }
    else
    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus state = ABAddressBookGetAuthorizationStatus();
        NSLog(@"ABAuthorizationStatus = %ld", state);
        
        if (state == kABAuthorizationStatusDenied) {
            accessGranted = NO;
        }
        else if (state != kABAuthorizationStatusAuthorized){
            NSLog(@"ABAuthorizationStatus = %ld", state);
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                accessGranted = granted;
                dispatch_semaphore_signal(sema);
            });
            
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        
        if (addressBook != nil) {
            CFRelease(addressBook);
        }
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        
    }
    
    if (!accessGranted)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"설정 ➟ 개인 정보 보호 ➟ 연락처에서 \n허용으로 하셔야 이용하실 수 있습니다."
                                                    delegate:nil
                                           cancelButtonTitle:@"확인"
                                           otherButtonTitles:nil, nil];
        [av show];
    }
    
    NSMutableArray *adressBooks = [[NSMutableArray alloc] init];
    NSMutableArray *shapGroup = [[NSMutableArray alloc] init];
    //    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    @autoreleasepool {
        CFArrayRef cfArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
        NSMutableArray *allPeople = [[NSMutableArray alloc] initWithArray:(__bridge NSMutableArray *)cfArray];
        [allPeople sortUsingFunction:(NSInteger (*)(id, id, void *))ABPersonComparePeopleByName context:(void *)kABPersonSortByLastName];
        
        for (int i = 0; i < [allPeople count]; i++) {
            
            ABRecordRef person = (__bridge ABRecordRef)([allPeople objectAtIndex:i]);
            
            CFStringRef cfFirstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            CFStringRef cfLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
            CFStringRef cfNickName = ABRecordCopyValue(person, kABPersonNicknameProperty);
            CFStringRef cfOrganization = ABRecordCopyValue(person, kABPersonOrganizationProperty);
            CFStringRef cfDepartment = ABRecordCopyValue(person, kABPersonDepartmentProperty);
            
            NSString *name = @"";
            NSString *firstName = @"";
            NSString *lastName = @"";
            NSString *nickName = @"";
            NSString *organization = @"";
            NSString *department = @"";
            
            if (cfFirstName != nil) {
                firstName = [[NSString alloc]initWithString:(__bridge NSString*)cfFirstName];
            }
            if (cfLastName != nil) {
                lastName = [[NSString alloc]initWithString:(__bridge NSString*)cfLastName];
            }
            if (cfNickName != nil) {
                nickName = [[NSString alloc]initWithString:(__bridge NSString*)cfNickName];
            }
            if (cfOrganization != nil) {
                organization = [[NSString alloc]initWithString:(__bridge NSString*)cfOrganization];
            }
            if (cfDepartment != nil) {
                department = [[NSString alloc]initWithString:(__bridge NSString*)cfDepartment];
            }
            
            if ([lastName isValid] && [firstName isValid])
                name = [[NSString alloc] initWithFormat:@"%@ %@",lastName, firstName];
            else if ([lastName isValid])
                name = lastName;
            else if ([firstName isValid])
                name = firstName;
            else if ([nickName isValid])
                name = nickName;
            else if ([organization isValid])
                name = organization;
            else if ([department isValid])
                name = department;
            
            
            ABMutableMultiValueRef multi = ABRecordCopyValue(person, kABPersonPhoneProperty);
            CFArrayRef cfPhoneNumbers = ABMultiValueCopyArrayOfAllValues(multi);
            NSArray* phoneNumbers = [[NSArray alloc]initWithArray:(__bridge NSArray*)cfPhoneNumbers];
            for (NSString *number in phoneNumbers) {
                NSString *num = [[NSString alloc] initWithString:number];
                
                if ([self checkMobileNumber:number] == NO) {
                    continue;
                }
                
                if ([self checkDuplicateName:adressBooks name:name number:number]||
                    [self checkDuplicateName:shapGroup name:name number:number]) {
                    continue;
                }

                AddressUIData *ad = [[AddressUIData alloc] init];
                ad.m_name = name;
                ad.m_allchosung = [self GetChosungAllString:name];
                ad.m_firstChosung = [self GetChosungString:name];
                ad.m_utf8 = [self GetUTF8String:name];
                ad.m_korToEng = [self GetKorToEng:name];
                ad.m_number = [self setPhoneNumberWithString:num SubType:kNONE];
                ad.m_numberUI = [self setPhoneNumberWithString:num SubType:kLINETYPE];

                if ([name rangeOfString:@"#"].location == 0) {
                    [shapGroup addObject:ad];
                }else {
                    [adressBooks addObject:ad];
                }
                
            }
            
            if (cfDepartment != nil) {
                CFRelease(cfDepartment);
            }
            if (cfOrganization != nil) {
                CFRelease(cfOrganization);
            }
            if (cfNickName != nil) {
                CFRelease(cfNickName);
            }
            if (cfLastName != nil) {
                CFRelease(cfLastName);
            }
            if (cfFirstName != nil) {
                CFRelease(cfFirstName);
            }
            
            if (cfPhoneNumbers != nil) {
                CFRelease(cfPhoneNumbers);
            }
            if (multi != nil) {
                CFRelease(multi);
            }
        }

        
        if (cfArray != nil) {
            CFRelease(cfArray);
        }
        
        if (addressBook != nil) {
            CFRelease(addressBook);
        }
    }
    if (shapGroup.count > 0) {
        [adressBooks addObjectsFromArray:shapGroup];
    }
    return adressBooks;

    
    
#pragma clang diagnostic pop
}

- (NSString*)setPhoneNumberWithString:(NSString*)phoneNum SubType:(StrDivideType)type
{
    NSMutableString *result = [NSMutableString stringWithString:@""];
    
    NSString *str = [phoneNum stringByReplacingOccurrencesOfString:@"+82" withString:@"0"];
    NSMutableString *num = [[NSMutableString alloc] initWithCapacity:[str length]];
    for (NSInteger i=0; i<[str length]; i++)
    {
        NSInteger code = [str characterAtIndex:i];
        if (code >= 48 && code <= 57) {
            [num appendFormat:@"%c",[str characterAtIndex:i]];
        }
    }
    
    NSRange range = [num rangeOfString:@"02"];                            //자를 범위
    
    
    switch ([num length]) {
        case 8:                                //xxxx-xxxx
            range = NSMakeRange(0, 4);
            [result appendFormat:@"%@%c",[num substringWithRange:range], type];
            range = NSMakeRange(4, 4);
            [result appendFormat:@"%@",[num substringWithRange:range]];
            break;
        case 9:                                //02-xxx-xxxx
            range = NSMakeRange(0, 2);
            [result appendFormat:@"%@%c",[num substringWithRange:range], type];
            range = NSMakeRange(2, 3);
            [result appendFormat:@"%@%c",[num substringWithRange:range], type];
            [result appendFormat:@"%@",[num substringFromIndex:5]];
            break;
        case 10:                            //031-xxx-xxxx
            if(range.location == 0)        //02-xxxx-xxxx
            {
                range = NSMakeRange(0, 2);
                [result appendFormat:@"%@%c",[num substringWithRange:range], type];
                range = NSMakeRange(2, 4);
                [result appendFormat:@"%@%c",[num substringWithRange:range], type];
                [result appendFormat:@"%@",[num substringFromIndex:6]];
            }
            else{
                range = NSMakeRange(0, 3);
                [result appendFormat:@"%@%c",[num substringWithRange:range], type];
                range = NSMakeRange(3, 3);
                [result appendFormat:@"%@%c",[num substringWithRange:range], type];
                [result appendFormat:@"%@",[num substringFromIndex:6]];
            }
            break;
        case 11:                            //010-xxxx-xxxx
            range = NSMakeRange(0, 3);
            [result appendFormat:@"%@%c",[num substringWithRange:range], type];
            range = NSMakeRange(3, 4);
            [result appendFormat:@"%@%c",[num substringWithRange:range], type];
            [result appendFormat:@"%@",[num substringFromIndex:7]];
            break;
        default:
            result = (NSMutableString*)phoneNum;
            break;
    }
    
    
    return result;
}

- (BOOL)checkMobileNumber:(NSString*)phoneNumber
{
    if ([phoneNumber isValid] == NO) {
        return NO;
    }
    
    NSString *num = [phoneNumber stringByReplacingOccurrencesOfString:@"+82" withString:@"0"];
    if ([phoneNumber length] >= 10) {
        NSString *frontNumber = [num substringToIndex:3];
        
        for (NSString *number in self.mobileNumber) {
            if ([frontNumber isEqualToString:number]) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)checkDuplicateName:(NSMutableArray*)adressBooks name:(NSString*)name number:(NSString*)number {
    BOOL findName = NO;
    number = [self setPhoneNumberWithString:number SubType:kNONE];
    for (NSInteger i = adressBooks.count -1; i >= 0; i--) {
        AddressUIData *addrUIData = (AddressUIData*)[adressBooks objectAtIndex:i];
        
        if ([addrUIData.m_name isEqualToString:name] && [addrUIData.m_number isEqualToString:number]) {
            findName = YES;
            break;
        }
    }
    return findName;
}

- (NSString *)GetChosungAllString:(NSString *)hanggulString
{
    if ([hanggulString isValid] == NO) {
        return @"";
    }
    //    NSLog(@"%@", hanggulString);
    NSMutableString *textResult = [[NSMutableString alloc] initWithCapacity:[hanggulString length]];
    @autoreleasepool {
        NSString *lowText = [hanggulString lowercaseString];
        
        BOOL check = YES;
        for (int i=0;i<[lowText length];i++)
        {
            NSInteger code = [lowText characterAtIndex:i];
            //            NSLog(@"%C", [lowText characterAtIndex:i]);
            //            NSLog(@"%i", code);
            if (code >= 44032 && code <= 55203) //한글
            {
                check = YES;
                NSInteger uniCode = code - 44032;
                NSInteger chosungIndex = uniCode / 21 / 28;
                [textResult appendString:[self.chosung objectAtIndex:chosungIndex]];
            }
            else if(code >= 97 && code <= 122) //영어
            {
                if(check)
                {
                    check = NO;
                    [textResult appendFormat:@"%C",[lowText characterAtIndex:i]];
                }
            }
            else if(code >= 12593 && code <= 12686) //자음 모음 분리되어 있을때
            {
                check = YES;
                [textResult appendFormat:@"%C",[lowText characterAtIndex:i]];
            }
            else {
                check = YES;
            }
        }
        
        //        NSLog(@"%@", textResult);
        
        //쌍자음
        NSString *ret = [textResult stringByReplacingOccurrencesOfString:@"ㄱㄱ" withString:@"ㄲ"];
        NSString *ret1 = [ret stringByReplacingOccurrencesOfString:@"ㄷㄷ" withString:@"ㄸ"];
        NSString *ret2 = [ret1 stringByReplacingOccurrencesOfString:@"ㅂㅂ" withString:@"ㅃ"];
        NSString *ret3 = [ret2 stringByReplacingOccurrencesOfString:@"ㅅㅅ" withString:@"ㅆ"];
        NSString *ret4 = [ret3 stringByReplacingOccurrencesOfString:@"ㅈㅈ" withString:@"ㅉ"];
        
        if (![textResult isEqualToString:ret4])
        {
            ret4 = (NSMutableString*)[ret4 stringByReplacingOccurrencesOfString:@" " withString:@""];
            [textResult appendFormat:@"   %@", ret4];
        }
    
    
    //        NSLog(@"%@", textResult);
    }
    return textResult;
        
}

- (NSString *)GetChosungString:(NSString *)hanggulString
{
    if ([hanggulString isValid] == NO) {
        return @"";
    }
    NSMutableString *textResult = [[NSMutableString alloc] initWithCapacity:[hanggulString length]];
    
    NSInteger code = [hanggulString characterAtIndex:0];
    if (code >= 44032 && code <= 55203)
    {
        NSInteger uniCode = code - 44032;
        NSInteger chosungIndex = uniCode / 21 / 28;
        [textResult appendString:[self.chosung objectAtIndex:chosungIndex]];
    }
    else
    {
        [textResult appendFormat:@"%C",[hanggulString characterAtIndex:0]];
    }
    
    return textResult;
}

- (NSString *)GetUTF8String:(NSString *)hanggulString {
    if ([hanggulString isValid] == NO) {
        return @"";
    }
    NSMutableString *textResult = [[NSMutableString alloc] init];
    @autoreleasepool {
        for (NSInteger i=0; i<[hanggulString length]; i++)
        {
            NSInteger code = [hanggulString characterAtIndex:i];
            if (code >= 44032 && code <= 55203) {
                NSInteger uniCode = code - 44032;
                NSInteger chosungIndex = uniCode / 21 / 28;
                NSInteger jungsungIndex = uniCode % (21 * 28) / 28;
                NSInteger jongsungIndex = uniCode % 28;
                [textResult appendFormat:@"%@%@%@", [self.chosung objectAtIndex:chosungIndex], [self.jungsung objectAtIndex:jungsungIndex], [self.jongsung objectAtIndex:jongsungIndex]];
            }
            else
            {
                [textResult appendFormat:@"%C",[hanggulString characterAtIndex:i]];
            }
        }
    }
    //    NSLog(@"%@", textResult);
    return textResult;
}

- (NSString *)GetKorToEng:(NSString*)hanggulString
{
    if ([hanggulString isValid] == NO) {
        return @"";
    }
    NSMutableString *textResult = [[NSMutableString alloc] init];
    @autoreleasepool {
        //키보드 한글에 따른 알파벳 순서
        for (NSInteger i=0; i<[hanggulString length]; i++)
        {
            NSInteger code = [hanggulString characterAtIndex:i];
            if (code >= 44032 && code <= 55203) {
                NSInteger uniCode = code - 44032;
                NSInteger chosungIndex = uniCode / 21 / 28;
                NSInteger jungsungIndex = uniCode % (21 * 28) / 28;
                NSInteger jongsungIndex = uniCode % 28;
                [textResult appendFormat:@"%@%@%@", [self.chosungENG objectAtIndex:chosungIndex], [self.jungsungENG objectAtIndex:jungsungIndex], [self.jongsungENG objectAtIndex:jongsungIndex]];
            }
            else
            {
                [textResult appendFormat:@"%C",[hanggulString characterAtIndex:i]];
            }
        }
    }
    return textResult;
}

- (void)searchPhoneBook:(NSString*)searchString
{
    self.searchWord = searchString;
    
    if ([searchString isValid] == NO) {
        self.searchIconView.hidden = NO;
        m_isSearchMode = NO;
    }
    else {
        [m_SearchData removeAllObjects];
        for (NSArray *section in m_tableData) {
            for (AddressUIData *ad in section) {
                
                NSRange rangName = [ad.m_name rangeOfString:searchString];
                NSRange rangChoSung = [ad.m_allchosung rangeOfString:searchString];
                NSRange rangNum = [ad.m_numberUI rangeOfString:searchString];
                NSRange rangEng = [ad.m_korToEng rangeOfString:searchString];
                
                NSString *utf8Search = [self GetUTF8String:searchString];
                NSRange rangUtf8 = [ad.m_utf8 rangeOfString:utf8Search];
                
                
                if (rangName.length > 0) {
                    ad.searchType = AddressSearchTypeName;
                    [m_SearchData addObject:ad];
                }
                else if (rangNum.length > 0) {
                    ad.searchType = AddressSearchTypeNumber;
                    [m_SearchData addObject:ad];
                }
                else if ( rangChoSung.length > 0 ){
                    ad.searchType = AddressSearchTypeChoSung;
                    [m_SearchData addObject:ad];
                }
                else if ( rangUtf8.length > 0 ) {
                    ad.searchType = AddressSearchTypeUTF8;
                    [m_SearchData addObject:ad];
                }
                else if (rangEng.length > 0) {
                    ad.searchType = AddressSearchTypeEnglish;
                    [m_SearchData addObject:ad];
                }
                
            }
        }
    
        m_isSearchMode = YES;
        self.searchIconView.hidden = YES;
    }
    [self.tView reloadData];
}

#pragma mark - IBACtion's
- (IBAction)onCloseButton:(UIButton *)sender {
    if (self.callback != nil) {
        self.callback(nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTextFieldChanged:(UITextField *)sender {
    [self searchPhoneBook:sender.text];
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchPhoneBook:textField.text];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (m_isSearchMode) {
        self.noResultView.hidden = [m_SearchData count] > 0;
        return 1;
    }
    else {
        self.noResultView.hidden = YES;
        return [m_indexkey count];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    NSLog(@"row = %d",section);
    if (m_isSearchMode)
    {
        //        NSLog(@"[m_SearchData count] = %d",[m_SearchData count]);
        return [m_SearchData count];
    }
    else {
        NSArray *arr = [m_tableData objectAtIndex:section];
        //        NSLog(@"[arr count] = %d",[arr count] );
        return [arr count];
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (m_isSearchMode)
    {
        return nil;
    }
    else
    {
        return m_indexkey;
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    NSLog(@"Header = %d",section);
    if (m_isSearchMode)
    {
        return nil;
    }
    else
    {
        return [m_indexkey objectAtIndex:section];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AddressBookCell *cell = (AddressBookCell*)[tableView dequeueReusableCellWithIdentifier:CELL_ADDRESSBOOK];
    
    NSArray *arr;
    AddressUIData *ad;
    
    if (m_isSearchMode)
    {
        ad = [m_SearchData objectAtIndex:indexPath.row];
        [cell compose:ad searchWord:self.searchWord];
    }
    else
    {
        arr = [m_tableData objectAtIndex:indexPath.section];
        ad = [arr objectAtIndex:indexPath.row];
        [cell compose:ad searchWord:@""];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchTextField resignFirstResponder];
    
    NSArray *firstSound = nil;
    __weak AddressUIData *ad = nil;
    
    if (m_isSearchMode)
    {
        ad = [m_SearchData objectAtIndex:indexPath.row];
    }
    else
    {
        firstSound = [m_tableData objectAtIndex:indexPath.section];
        ad = [firstSound objectAtIndex:indexPath.row];
    }
    
    ad.m_selected = !ad.m_selected;
    
    AddressBookCell *cell = (AddressBookCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (ad.m_selected)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.callback) {
            self.callback(ad);
        }
    }];
    
}

- (void)setAddressBookCallback:(AddressBookCallback)callback{
    self.callback = callback;
}

@end
