//
//  QLTextMessageCell.m
//  QLTextMessage
//
//  Created by MQL-IT on 2017/5/21.
//  Copyright © 2017年 MQL-IT. All rights reserved.
//

#import "QLTextMessageCell.h"
#import <Masonry.h>
#import "MessageModel.h"


@interface QLTextMessageCell ()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *bubbleView;
@property (nonatomic, strong) UILabel *detailLabel;

@end
@implementation QLTextMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setMessageModel:(MessageModel *)messageModel {
    _messageModel = messageModel;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:messageModel.textContent];
    
    _detailLabel.attributedText = str;
}
- (void)configCell {
    _detailLabel.text = @"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国";
}

- (void)setupSubViews {
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.bubbleView];
    [self.contentView addSubview:self.detailLabel];
    [self setupLyaout];
}


- (void)setupLyaout {
    _avatarView.layer.masksToBounds = YES;
    _avatarView.layer.cornerRadius = 20;
    CGFloat headToBubble  = 3;
    CGFloat arrowWidth    = 7;
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.top.equalTo(_dateLabel.mas_bottom).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    
    [_bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_right).offset(headToBubble);
        make.top.equalTo(_dateLabel.mas_bottom).offset(15);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(30);
        make.left.equalTo(_bubbleView.mas_left).offset(2 * arrowWidth);
        make.top.equalTo(_bubbleView.mas_top).offset(5);
        make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    /**
     Hugging priority 确定view有多大的优先级阻止自己变大。
     
     Compression Resistance priority确定有多大的优先级阻止自己变小。
     
     可以注释下面两行代码来理解:
        ---注释后,消息长度(不满一行, 重点)时,展示消息的label会变长来适应背景图片;
        ---取消注释, 把lable的HuggingPriority设置的比背景视图的大,相当于label阻止自己变大的能力大于背景视图,此时背景视图会变短来适应label
     */
    
    [_bubbleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_detailLabel.mas_right).offset(5);
        make.bottom.equalTo(_detailLabel.mas_bottom).offset(5);
    }];
    //detailLabel的HuggingPriority要设置为最高的优先级, 不然cell重用的时候有问题
    [_detailLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_bubbleView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}


- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.backgroundColor = [UIColor whiteColor];
        _dateLabel.layer.masksToBounds = YES;
        _dateLabel.layer.cornerRadius = 4;
        [_dateLabel sizeToFit];
        _dateLabel.font = [UIFont systemFontOfSize:11];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = @"2014年10月23日";
    }
    return _dateLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [UIImageView new];
        _avatarView.backgroundColor = [UIColor purpleColor];
    }
    return _avatarView;
}

- (UIImageView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [UIImageView new];
        
        _bubbleView.image = [self resizImageWithName:@"bubble_gray" isSender:NO];
    }
    return _bubbleView;
}

- (UIImage *)resizImageWithName:(NSString *)imageName isSender:(BOOL )isSender {
    // 1. 实例化image对象, 是为了获得真实大小
    UIImage *image = [UIImage imageNamed:imageName];
    // 2. 获取图片拉伸宽高点
    CGFloat stretchWidth = image.size.width / 1.0 / 5.0;
    CGFloat stretchHeight = image.size.height * 1.0 / 5.0;
    // 3. 拉伸图片
    UIImage *resizImage = nil;
    if (isSender) {
        resizImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(stretchHeight, stretchWidth, image.size.height - stretchHeight, stretchWidth) resizingMode:UIImageResizingModeStretch];
    } else {
        
        resizImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height - stretchHeight, stretchWidth,stretchHeight, stretchWidth) resizingMode:UIImageResizingModeStretch];
    }
    // 4. 返回被拉伸的图片
    return resizImage;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
