//
//  ViewController.m
//  InputimageExample
//
//  Created by zorro on 15/3/6.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "RichTextViewController.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"


#import "ImageTextAttachment.h"
#import "NSAttributedString+RichText.h"
#import "PictureModel.h"
#import "NSAttributedString+html.h"
#import "NSString+Regular.h"
//Image default max size，图片显示的最大宽度
#define IMAGE_MAX_SIZE (100)

#define DefaultFont (16)
#define MaxLength (2000)

@interface RichTextViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (assign,nonatomic) NSUInteger finishImageNum;//纪录图片下载完成数目
@property (assign,nonatomic) NSUInteger apperImageNum; //纪录图片将要下载数目
//默认提示字
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;


//设置
@property (nonatomic,assign) NSRange newRange;
@property (nonatomic,strong) NSString * newstr;
@property (nonatomic,assign) BOOL isBold;          //是否加粗
@property (nonatomic,strong) UIColor * fontColor;  //字体颜色
@property (nonatomic,assign) CGFloat  font;        //字体大小
@property (nonatomic,assign) NSUInteger location;  //纪录变化的起始位置
@property (nonatomic,strong) NSMutableAttributedString * locationStr;

@property (nonatomic,assign) CGFloat lineSapce;    //行间距
@property (nonatomic,assign) BOOL isDelete;        //是否是回删



@end

@implementation RichTextViewController
+(instancetype)ViewController
{
    RichTextViewController * ctrl=[[UIStoryboard storyboardWithName:@"RichText" bundle:nil]instantiateViewControllerWithIdentifier:@"RichTextViewController"];
    
    return ctrl;
}

-(void)CommomInit
{
    self.textView.delegate=self;
    //显示链接，电话
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.font=DefaultFont;
    self.fontColor=[UIColor blackColor];
    self.location=0;
    self.isBold=NO;
    self.lineSapce=5;
    [self setInitLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //如果无需改变字体 颜色 大小
    if (!self.changText) {
        self.fontBtn.hidden=YES;
        self.colorBtn.hidden=YES;
        self.boldBtn.hidden=YES;

    }
    //Init text font

    [self resetTextStyle];

    //Add keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    
    
    
    if (self.content!=nil) {
        [self setRichTextViewContent:self.content];
    }
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)resetTextStyle {
    //After changing text selection, should reset style.
    [self CommomInit];
    NSRange wholeRange = NSMakeRange(0, _textView.textStorage.length);
    
    
    [_textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [_textView.textStorage removeAttribute:NSForegroundColorAttributeName range:wholeRange];
    
    //字体颜色
    [_textView.textStorage addAttribute:NSForegroundColorAttributeName value:self.fontColor range:wholeRange];
    
    //字体加粗
    if (self.isBold) {
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:self.font] range:wholeRange];
    }
    //字体大小
    else
    {
        
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.font] range:wholeRange];
    }
    
    
    
}
-(void)setInitLocation
{
    
    
    self.locationStr=nil;
    self.locationStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
    if (self.textView.textStorage.length>0) {
        self.placeholderLabel.hidden=YES;
    }
   
    
}
-(void)setStyle
{
    
    
    //把最新的内容进行替换
    [self setInitLocation];
    
    
    if (self.isDelete) {
        return;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.lineSapce;// 字体的行间距
    NSDictionary *attributes=nil;
    if (self.isBold) {
        attributes = @{
                       NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font],
                       NSForegroundColorAttributeName:self.fontColor,
                       NSParagraphStyleAttributeName:paragraphStyle
                       };
        
    }
    else
    {
        attributes = @{
                       NSFontAttributeName:[UIFont systemFontOfSize:self.font],
                       NSForegroundColorAttributeName:self.fontColor,
                       NSParagraphStyleAttributeName:paragraphStyle
                       };
        
    }
    
    NSAttributedString * replaceStr=[[NSAttributedString alloc] initWithString:self.newstr attributes:attributes];
    [self.locationStr replaceCharactersInRange:self.newRange withAttributedString:replaceStr];
   
    _textView.attributedText =self.locationStr;
    
    //这里需要把光标的位置重新设定
    self.textView.selectedRange=NSMakeRange(self.newRange.location+self.newRange.length, 0);
   
}
#pragma mark textViewDelegate
/**
 *  点击图片触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"%@", textAttachment);
    return NO;
}

/**
 *  点击链接，触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    [[UIApplication sharedApplication] openURL:URL];
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //    textview 改变字体的行间距
    
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    if (range.length == 1)     // 回删
    {
       
        return YES;
    }
    else
    {
        
        // 超过长度限制
        if ([textView.text length] >= MaxLength+3)
        {
            
            return NO;
        }
    }

    
    return YES;
}
//- (void)textViewDidChangeSelection:(UITextView *)textView;
//{
//    NSLog(@"焦点改变");
//}
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (self.textView.attributedText.length>0) {
        self.placeholderLabel.hidden=YES;
    }
    else
    {
        self.placeholderLabel.hidden=NO;
    }
    NSInteger len=textView.attributedText.length-self.locationStr.length;
    if (len>0) {
        
        self.isDelete=NO;
        self.newRange=NSMakeRange(self.textView.selectedRange.location-len, len);
        self.newstr=[textView.text substringWithRange:self.newRange];
        
    }
    else
    {
        self.isDelete=YES;
        
    }

    
# warning  如果出现输入问题，检查这里
    bool isChinese;//判断当前输入法是否是中文

    if ([[[textView textInputMode] primaryLanguage]  isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    
    NSString *str = [[ self.textView text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [ self.textView markedTextRange];
        
        //获取高亮部分
        UITextPosition *position = [ self.textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
//            NSLog(@"汉字");
            //              NSLog(@"str=%@; 本次长度=%lu",str,(unsigned long)[str length]);
            
            [self setStyle];
            if ( str.length>=MaxLength) {
                NSString *strNew = [NSString stringWithString:str];
                [ self.textView setText:[strNew substringToIndex:MaxLength]];
            }
        }
        else
        {
//            NSLog(@"没有转化--%@",str);
            if ([str length]>=MaxLength+10) {
                NSString *strNew = [NSString stringWithString:str];
                [ self.textView setText:[strNew substringToIndex:MaxLength+10]];
            }
            
        }
    }else{
//        NSLog(@"英文");
        
        [self setStyle];
        if ([str length]>=MaxLength) {
            NSString *strNew = [NSString stringWithString:str];
            [ self.textView setText:[strNew substringToIndex:MaxLength]];
        }
    }
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    
}
#pragma mark - Action
//完成
- (IBAction)finishClick:(UIButton *)sender {


    if (self.feedbackHtml) {
        if ([self.RTDelegate respondsToSelector:@selector(uploadImageArray:withCompletion:)]) {
            //实现上传图片的代理，用url替换图片标识
            
            __weak typeof(self) weakself=self;
            
            [self.RTDelegate uploadImageArray:[_textView.attributedText getImgaeArray] withCompletion:^NSString *(NSArray *urlArray) {
                 return  [weakself replacetagWithImageArray:urlArray];
            }];
        }
    }
    else
    {

        //注意这下面的三种 数据

        //    NSLog(@"attributedText。getPlainString--%@",[_textView.attributedText getPlainString]);
        //    NSLog(@"attributedText--%@",self.textView.attributedText);
        //这个是返回数组，每个数组装有不同设置的字符串
        if (self.finished!=nil) {

            if (self.changText) {
                self.finished([_textView.attributedText getArrayWithAttributed],[_textView.attributedText getImgaeArray]);
            }
            else
            {
                // *  获取带有图片标示的一个普通字符串
                self.finished([_textView.attributedText getPlainString],[_textView.attributedText getImgaeArray]);
            }
            
            
        }
 
    }
    
}
//颜色设置
- (IBAction)colorClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.fontColor=[UIColor redColor];
        
        
    }
    else
    {
        
        self.fontColor=[UIColor blackColor];
    }
    
    [sender setTintColor:self.fontColor];
    
    
    //设置字的设置
    [self setInitLocation];
 
}
//加粗
- (IBAction)boldClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    self.isBold=sender.selected;
    if (self.isBold) {
        sender.titleLabel.font=[UIFont systemFontOfSize:12];
    }
    else
    {
        
        sender.titleLabel.font=[UIFont boldSystemFontOfSize:12];
    }
    
    //设置字的设置
    [self setInitLocation];
}
//字体设置
- (IBAction)fontClick:(UIButton *)sender {
    
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.font=25.f;
        [sender setTitle:[NSString stringWithFormat:@"字体 %.f",self.font] forState:UIControlStateSelected];
    }
    else
    {
        self.font=DefaultFont;
        [sender setTitle:[NSString stringWithFormat:@"字体 %.f",self.font] forState:UIControlStateNormal];
    }
    
    //设置字的设置
    [self setInitLocation];
}
//选择图片
- (IBAction)imageClick:(UIButton *)sender {
    [self.view endEditing:YES];
    

    __weak typeof(self) weakSelf=self;
    UIAlertController * alertVC=[UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf selectedImage];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];

    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}
-(void)selectedImage
{
    
    NSUInteger sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    //如果没有内容就输入图片，无需换行
    if (self.textView.textStorage.length>0) {
         [self appenReturn];
    }
  
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    //    // 保存图片至本地，方法见下文
    //    NSLog(@"img = %@",image);
    
    //图片添加后 自动换行
    [self setImageText:image withRange:self.textView.selectedRange appenReturn:YES];
    
    [self.textView becomeFirstResponder];
    
}
//设置图片
-(void)setImageText:(UIImage *)img withRange:(NSRange)range appenReturn:(BOOL)appen
{
    
 
    
    
    UIImage * image=img;
    
    if (image == nil)
    {
        return;
    }
    
   
    if (![image isKindOfClass:[UIImage class]])           // UIImage资源
    {
        
        return;
    }
    
    
    CGFloat ImgeHeight=image.size.height*IMAGE_MAX_SIZE/image.size.width;
    if (ImgeHeight>IMAGE_MAX_SIZE*2) {
        ImgeHeight=IMAGE_MAX_SIZE*2;
    }
    
    
    ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];
    
    //Set tag and image
    imageTextAttachment.imageTag = RICHTEXT_IMAGE;
    imageTextAttachment.image =image;
    
    //Set image size
    imageTextAttachment.imageSize = CGSizeMake(IMAGE_MAX_SIZE, ImgeHeight);


    if (appen) {
        //Insert image image
        [_textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]
                                              atIndex:range.location];
    }
    else
    {
        if (_textView.textStorage.length>0) {
           
            //Insert image image
            [_textView.textStorage replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]];
        }

    }

    
    //Move selection location
    _textView.selectedRange = NSMakeRange(range.location + 1, range.length);
    
    //设置locationStr的设置
    [self setInitLocation];
    if(appen)
    {
           [self appenReturn]; 
    }

}



-(void)appenReturn
{
    NSAttributedString * returnStr=[[NSAttributedString alloc]initWithString:@"\n"];
    NSMutableAttributedString * att=[[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];
    [att appendAttributedString:returnStr];
    
    _textView.attributedText=att;
}

#pragma mark - Keyboard notification

- (void)onKeyboardNotification:(NSNotification *)notification {
    //Reset constraint constant by keyboard height
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect keyboardFrame = ((NSValue *) notification.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
        _bottomConstraint.constant = keyboardFrame.size.height;
    } else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        _bottomConstraint.constant = -40;
    }
    
    //Animate change
    [UIView animateWithDuration:0.8f animations:^{
        [self.view layoutIfNeeded];
    }];
}




//这里就开始上传图片，拼接图片地址
-(NSString *)replacetagWithImageArray:(NSArray *)picArr
{

    NSMutableAttributedString * contentStr=[[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];

    [contentStr enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, contentStr.length)
                           options:0
                        usingBlock:^(id value, NSRange range, BOOL *stop) {
                            if (value && [value isKindOfClass:[ImageTextAttachment class]]) {

                                [contentStr replaceCharactersInRange:range withString:RICHTEXT_IMAGE];

                            }
                        }];
    

    NSMutableString * mutableStr=[[NSMutableString alloc]initWithString:[contentStr toHtmlString]];
    
    //这里是把字符串分割成数组，
    NSArray * strArr=[mutableStr  componentsSeparatedByString:RICHTEXT_IMAGE];


    NSString * newContent=@"";
    for (int i=0; i<strArr.count; i++) {
        PictureModel * picture=nil;
        NSString * imgTag=@"";
        if (i<picArr.count) {
            picture=[picArr objectAtIndex:i];
            imgTag=[NSString stringWithFormat:@"<img src=\"%@\" w=\"%lu\" h=\"%lu\"/>",picture.imageurl,(unsigned long)picture.width,(unsigned long)picture.height];
        }

        
        
        //因为cutstr 可能是null
        NSString * cutStr=[strArr objectAtIndex:i];
        newContent=[NSString stringWithFormat:@"%@%@%@",newContent,cutStr,imgTag];
        
    }
    
    return newContent;

}

#pragma mark setter
-(void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText=placeholderText;
    self.placeholderLabel.text=placeholderText;
}

#pragma mark  设置内容
-(void)setRichTextViewContent:(id)content
{
    
    
    if ([content isKindOfClass:[NSString class]]) {
        if (self.content!=nil) {

            NSMutableArray * modelArr=[NSMutableArray array];
            NSArray * imageOfWH=[content RXToArray];
            
            if (modelArr!=nil) {
                [modelArr removeAllObjects];
            }
            //获取字符串中的图片
            for (NSDictionary * dict in imageOfWH) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    
                    PictureModel * model=[[PictureModel alloc]init];
                    model.imageurl=dict[@"src"];
                    model.width=[dict[@"w"] floatValue];;
                    model.height=[dict[@"h"] floatValue];
                    [modelArr addObject:model];
                }
            }
            
            [self setContentStr:[content RXToString] withImageArr:modelArr];
        }
        
 

    }
    else
    {
        [self setContentArr:(NSArray *)content];
    }
}
-(void)setContentStr:(NSString *)contentStr withImageArr:(NSArray *)imageArr
{
    
    if (contentStr.length<=0) {
        self.placeholderLabel.hidden=NO;
        return;
    }
    self.placeholderLabel.hidden=YES;
    

    //1.显示文字内容
    NSMutableString * mutableStr=[[NSMutableString alloc]initWithString:contentStr];
    
    
    NSString * plainStr=[mutableStr stringByReplacingOccurrencesOfString:RICHTEXT_IMAGE withString:@"\n"];
    NSMutableAttributedString * attrubuteStr=[[NSMutableAttributedString alloc]initWithString:plainStr];
    //设置初始内容
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.lineSapce;// 字体的行间距
    
    NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:self.font],NSFontAttributeName,self.fontColor,NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
    [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
    self.textView.attributedText =attrubuteStr;
    
    
    if (imageArr.count==0) {
        return;
    }
    
    self.apperImageNum=imageArr.count;
    self.finishImageNum=0;
    
    
    //2.这里是把字符串分割成数组，
    NSArray * strArr=[contentStr  componentsSeparatedByString:RICHTEXT_IMAGE];
    NSUInteger locLength=0;
    //替换带有图片标签的,设置图片
    for (int i=0; i<imageArr.count; i++) {
        
        NSString * locStr=[strArr objectAtIndex:i];
        locLength+=locStr.length;
        id image=[imageArr objectAtIndex:i];
        if ([image isKindOfClass:[UIImage class]]) {
         
            [self setImageText:image withRange:NSMakeRange(locLength+i, 1) appenReturn:NO];
        }
        else if([image isKindOfClass:[PictureModel class]])
        {
            PictureModel * model=(PictureModel *)image;
            [self downLoadImageWithUrl:model.imageurl                                                                                                                                                    WithRange:NSMakeRange(locLength+i, 1)];
        }
        else if([image isKindOfClass:[NSString class]])
        {
            [self downLoadImageWithUrl:(NSString *)image                                                                                                                                                    WithRange:NSMakeRange(locLength+i, 1)];
        }

    }
    
    //设置光标到末尾
    self.textView.selectedRange=NSMakeRange(self.textView.attributedText.length, 0);
    
    
}

-(void)setContentArr:(NSArray *)content
{
    
    if (content.count<=0) {
        self.placeholderLabel.hidden=NO;
        return;
    }
    self.placeholderLabel.hidden=YES;
    
    //将要下载的图片数目
    self.apperImageNum=0;

    NSMutableArray * imageArr=[NSMutableArray array];
    
    NSMutableAttributedString * mutableAttributedStr=[[NSMutableAttributedString alloc]init];
    for (NSDictionary * dict in content) {
        if (dict[@"image"]!=nil) {
            NSMutableDictionary * imageMutableDict=[NSMutableDictionary dictionaryWithDictionary:[dict[@"image"] RXImageUrl]];

            [imageMutableDict setObject:[NSNumber numberWithInteger:mutableAttributedStr.length] forKey:@"locLenght"];
            [imageArr addObject:imageMutableDict];
            self.apperImageNum++;
            
            //默认图片
            
            UIImage * image=[UIImage imageNamed:@"richtext_image"];
            CGFloat ImgeHeight=image.size.height*IMAGE_MAX_SIZE/image.size.width;
            if (ImgeHeight>IMAGE_MAX_SIZE*2) {
                ImgeHeight=IMAGE_MAX_SIZE*2;
            }
            
            ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];
            imageTextAttachment.image =image;
            
            //Set image size
            imageTextAttachment.imageSize = CGSizeMake(IMAGE_MAX_SIZE, ImgeHeight);
 
                //Insert image image
                [mutableAttributedStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]
                                                      atIndex:mutableAttributedStr.length];
            continue;
        }

        NSString * plainStr=dict[@"title"];
        NSMutableAttributedString * attrubuteStr=[[NSMutableAttributedString alloc]initWithString:plainStr];
        //设置初始内容
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = [dict[@"lineSpace"] floatValue];// 字体的行间距
        
        //是否加粗
        if ([dict[@"bold"] boolValue]) {
            NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:[dict[@"font"] floatValue] ],NSFontAttributeName,[UIColor colorWithHexString:dict[@"color"]],NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
            [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
        }
        else
        {
            NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:[dict[@"font"] floatValue]],NSFontAttributeName,[UIColor colorWithHexString:dict[@"color"]],NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
            [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
        }


        [mutableAttributedStr appendAttributedString:attrubuteStr];
    }
    
    self.textView.attributedText =mutableAttributedStr;


    //没有图片需要下载
    if (self.apperImageNum==0) {
        return;
    }

   
    self.finishImageNum=0;

    NSUInteger locLength=0;
    //替换带有图片标签的,设置图片
    for (int i=0; i<imageArr.count; i++) {
       NSDictionary * imageDict=[imageArr objectAtIndex:i];
       locLength=[imageDict[@"locLenght"]integerValue] ;
        //完成之后，纪录的位置移动1,图片长度为1
//        locLength+=i;
        //只取第一个
        [self downLoadImageWithUrl:(NSString *)imageDict[@"src"]                                                                                                                                                    WithRange:NSMakeRange(locLength, 1)];

    }
    
    //设置光标到末尾
    self.textView.selectedRange=NSMakeRange(self.textView.attributedText.length, 0);
    
    
}

-(void)downLoadImageWithUrl:(NSString *)url WithRange:(NSRange)range
{
    
    __weak typeof(self) weakSelf=self;
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
    
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if(finished)
        {
            self.finishImageNum++;
        
            if (self.finishImageNum==self.apperImageNum) {
                
            }
          
            [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:url]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf setImageText:image withRange:range appenReturn:NO];
            });
            
            
            
        }
        else
        {
           
        }
    }];
    
}


@end
