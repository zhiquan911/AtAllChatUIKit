// Generated by Apple Swift version 4.0.2 effective-3.2.2 (swiftlang-900.0.69.2 clang-900.0.38)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_attribute(external_source_symbol)
# define SWIFT_STRINGIFY(str) #str
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name) _Pragma(SWIFT_STRINGIFY(clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in=module_name, generated_declaration))), apply_to=any(function, enum, objc_interface, objc_category, objc_protocol))))
# define SWIFT_MODULE_NAMESPACE_POP _Pragma("clang attribute pop")
#else
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name)
# define SWIFT_MODULE_NAMESPACE_POP
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import ObjectiveC;
@import AIPushKit;
@import CoreData;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

SWIFT_MODULE_NAMESPACE_PUSH("AIChatKit")

SWIFT_CLASS("_TtC9AIChatKit12AIAttachment")
@interface AIAttachment : NSObject
@property (nonatomic, copy) NSString * _Nonnull fileKey;
@property (nonatomic, copy) NSString * _Nonnull format;
@property (nonatomic, copy) NSString * _Nonnull fileName;
@property (nonatomic, copy) NSString * _Nonnull fileUrl;
@property (nonatomic, copy) NSString * _Nonnull thumbnail;
@property (nonatomic, copy) NSString * _Nonnull fileSize;
@property (nonatomic, copy) NSString * _Nonnull duration;
@property (nonatomic, copy) NSString * _Nonnull uploadTime;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// 即时通信SDK配置工具
SWIFT_CLASS("_TtC9AIChatKit6AIChat")
@interface AIChat : NSObject
/// 全局唯一实例
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) AIChat * _Nonnull shared;)
+ (AIChat * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class AIPush;

@interface AIChat (SWIFT_EXTENSION(AIChatKit))
/// 组件的唯一表示名字，用于查找
@property (nonatomic, readonly, copy) NSString * _Nonnull key;
/// 组件支持的方法指令组，用于分发业务
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull method;
/// 网络状态变更回调
/// \param push 触发者
///
- (void)networkDidChangedWithPush:(AIPush * _Nonnull)push;
@end

@class AIUserInfo;
@class AIChatMessage;
@class AIConversation;

@interface AIChat (SWIFT_EXTENSION(AIChatKit))
/// AIPush单例
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) AIPush * _Nonnull push;)
+ (AIPush * _Nonnull)push SWIFT_WARN_UNUSED_RESULT;
/// 启动SDK
/// \param appKey appKey 一个应用必须的,唯一的标识.
///
/// \param channel 发布渠道. 可选.
///
/// \param isProduction isProduction 是否生产环境.
///
+ (void)setupWithOptionWithAppKey:(NSString * _Nonnull)appKey secret:(NSString * _Nonnull)secret channel:(NSString * _Nonnull)channel isProduction:(BOOL)isProduction alertSound:(BOOL)alertSound alertVibration:(BOOL)alertVibration;
+ (void)loginWithUser:(AIUserInfo * _Nonnull)user callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 获取用户好友列表
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getFriendsWithCallback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 查找好友数据
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)searchNewFriendWithUsername:(NSString * _Nonnull)username callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 请求添加好友
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)requestNewFriendWithFriendkey:(NSString * _Nonnull)friendkey addWording:(NSString * _Nullable)addWording friendNote:(NSString * _Nullable)friendNote callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 处理好友申请
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)responseNewFriendWithFriendkey:(NSString * _Nonnull)friendkey relationStatus:(NSString * _Nonnull)relationStatus message:(NSString * _Nullable)message callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 获取好友请求添加记录
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getNewFriendRequestsWithCallback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 获取缓存中离线消息
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)selectChatMessageWithSenderkey:(NSString * _Nonnull)senderkey receiverkey:(NSString * _Nonnull)receiverkey callback:(void (^ _Nullable)(NSArray<AIChatMessage *> * _Nonnull))callback;
/// 插入离线消息
/// <ul>
///   <li>
///     Parameters:
///   </li>
/// </ul>
+ (void)saveChatMessageWithChatMessages:(AIChatMessage * _Nonnull)chatMessages;
/// 发送消息
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)sendMessageWithObjectkey:(NSString * _Nonnull)objectkey objectType:(NSString * _Nonnull)objectType messageType:(NSString * _Nonnull)messageType content:(NSString * _Nullable)content isHTMLEscape:(NSString * _Nullable)isHTMLEscape attachment:(AIAttachment * _Nullable)attachment callback:(void (^ _Nullable)(BOOL, NSString * _Nonnull, NSString * _Nonnull))callback;
/// 上传附件
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)uploadAttachmentWithKey:(NSString * _Nonnull)key mimeType:(NSString * _Nonnull)mimeType the_file:(NSString * _Nonnull)the_file callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 确认会话已阅
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)setReadConversationWithConversationkey:(NSString * _Nonnull)conversationkey callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 获取个人信息
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getUserInfoWithCallback:(void (^ _Nullable)(BOOL, AIUserInfo * _Nonnull))callback;
/// 修改个人信息
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)setUserInfoWithUsername:(NSString * _Nonnull)username nickname:(NSString * _Nonnull)nickname avatarUrl:(NSString * _Nonnull)avatarUrl role:(NSString * _Nonnull)role msgSettings:(NSString * _Nonnull)msgSettings allowType:(NSString * _Nonnull)allowType extAttr:(NSString * _Nonnull)extAttr language:(NSString * _Nullable)language callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 登出用户
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)logoutWithCallback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 获取最近会话
/// 1.先读取本地缓存的会话记录，直接同步返回限定条数
/// 2.异步请求离线的会话记录，更新到本地
/// 3.异步回调给主线程处理最新的会话记录
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getConversationsWithUserkey:(NSString * _Nonnull)userkey count:(NSInteger)count callback:(void (^ _Nullable)(BOOL, NSArray<AIConversation *> * _Nonnull, NSString * _Nonnull))callback;
/// 获取缓存中最近会话
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)selectConversationWithCallback:(void (^ _Nullable)(NSArray<AIConversation *> * _Nonnull))callback;
/// 绑定用户与设备
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)bindUserToDeviceWithUuid:(NSString * _Nullable)uuid callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 结束会话
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)closeConversationWithConversationkey:(NSString * _Nonnull)conversationkey callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 批量获取应用的用户资料
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getUsersInAppWithUserkeys:(NSString * _Nonnull)userkeys role:(NSString * _Nonnull)role online:(NSString * _Nonnull)online count:(NSString * _Nonnull)count callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 群发送消息到指定角色
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)sendMessageToRoleWithRole:(NSString * _Nonnull)role messageType:(NSString * _Nonnull)messageType content:(NSString * _Nullable)content attachment:(NSString * _Nullable)attachment isHTMLEscape:(NSString * _Nullable)isHTMLEscape callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 通过编好获取应用内的会话
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getConversationByKeyWithConversationkey:(NSString * _Nonnull)conversationkey callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 创建群组
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)createGroupWithGroupname:(NSString * _Nonnull)groupname groupkey:(NSString * _Nonnull)groupkey type:(NSString * _Nonnull)type joinOption:(NSString * _Nonnull)joinOption callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 加入群组
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)joinGroupWithGroupkey:(NSString * _Nonnull)groupkey memberName:(NSString * _Nullable)memberName addWording:(NSString * _Nullable)addWording callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 获取用户的所有群
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getGroupsOfUserWithCount:(NSString * _Nonnull)count groupid:(NSString * _Nullable)groupid callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 获取群的所有用户
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getGroupMemebersWithGroupkey:(NSString * _Nonnull)groupkey memberkeys:(NSString * _Nullable)memberkeys callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 修改群成员资料
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)setGroupMemberInfoWithGroupkey:(NSString * _Nonnull)groupkey memberid:(NSString * _Nonnull)memberid memberName:(NSString * _Nonnull)memberName disableSpeak:(NSString * _Nullable)disableSpeak isQuit:(NSString * _Nullable)isQuit callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 修改群资料
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)setGroupInfoWithGroupName:(NSString * _Nullable)groupName groupDesc:(NSString * _Nullable)groupDesc groupNotice:(NSString * _Nullable)groupNotice groupAvatarUrl:(NSString * _Nullable)groupAvatarUrl applyJoinOption:(NSString * _Nullable)applyJoinOption isDissolve:(NSString * _Nullable)isDissolve callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 删除用户发送的聊天记录
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)deleteChatMessageOfSenderWithMsgid:(NSString * _Nullable)msgid msgTag:(NSString * _Nullable)msgTag callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 群组踢人
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)kickGroupMemberWithGroupkey:(NSString * _Nonnull)groupkey memberkey:(NSString * _Nonnull)memberkey reason:(NSString * _Nullable)reason callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 解散群组
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)dissolveGroupWithReason:(NSString * _Nullable)reason callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 禁言群组成员
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)disableSpeakGroupMemberWithGroupkey:(NSString * _Nonnull)groupkey memberkey:(NSString * _Nonnull)memberkey reason:(NSString * _Nullable)reason callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 查询入群申请记录
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getJoinGroupOfferWithGroupkey:(NSString * _Nonnull)groupkey count:(NSString * _Nonnull)count status:(NSString * _Nullable)status lastOfferid:(NSString * _Nullable)lastOfferid callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 处理入群申请记录
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)handleJoinGroupOfferWithGroupkey:(NSString * _Nonnull)groupkey status:(NSString * _Nonnull)status reason:(NSString * _Nullable)reason callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 设置群组消息关键字过滤
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)setGroupMessagesFilterWithGroupkey:(NSString * _Nonnull)groupkey keywords:(NSString * _Nonnull)keywords callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 获取被过滤的群组消息
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)getGroupFilteredMessagesWithGroupkey:(NSString * _Nonnull)groupkey keyword:(NSString * _Nonnull)keyword callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
/// 审核被过滤的群组消息
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
+ (void)handleGroupFilteredMessagesWithGroupkey:(NSString * _Nonnull)groupkey msgids:(NSString * _Nonnull)msgids status:(NSString * _Nonnull)status callback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
+ (void)clearCache;
@end


/// 即时聊天消息对象
SWIFT_CLASS("_TtC9AIChatKit13AIChatMessage")
@interface AIChatMessage : NSObject
@property (nonatomic, copy) NSString * _Nonnull msgid;
@property (nonatomic, copy) NSString * _Nonnull msgType;
@property (nonatomic, copy) NSString * _Nonnull title;
@property (nonatomic, copy) NSString * _Nonnull content;
@property (nonatomic, copy) NSString * _Nonnull senderkey;
@property (nonatomic, copy) NSString * _Nonnull receiverkey;
@property (nonatomic, copy) NSString * _Nonnull receiverType;
@property (nonatomic, copy) NSString * _Nonnull receiver;
@property (nonatomic, strong) AIUserInfo * _Nullable receiverInfo;
@property (nonatomic, strong) AIUserInfo * _Nullable senderInfo;
@property (nonatomic, copy) NSString * _Nonnull sender;
@property (nonatomic, copy) NSString * _Nonnull sendTime;
@property (nonatomic, copy) NSString * _Nonnull receiveTime;
@property (nonatomic, copy) NSString * _Nonnull isAttachment;
@property (nonatomic, copy) NSString * _Nonnull attachment;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class NSEntityDescription;
@class NSManagedObjectContext;

SWIFT_CLASS_NAMED("AIChatMessageEntity")
@interface AIChatMessageEntity : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface AIChatMessageEntity (SWIFT_EXTENSION(AIChatKit))
@property (nonatomic, copy) NSString * _Nullable content;
@property (nonatomic, copy) NSString * _Nullable isAttachment;
@property (nonatomic) int64_t msgid;
@property (nonatomic, copy) NSString * _Nullable msgType;
@property (nonatomic, copy) NSString * _Nullable receiverkey;
@property (nonatomic, copy) NSString * _Nullable receiverType;
@property (nonatomic) int64_t receiveTime;
@property (nonatomic, copy) NSString * _Nullable senderkey;
@property (nonatomic) int64_t sendTime;
@property (nonatomic, copy) NSString * _Nullable title;
@end

@class AIGroup;

/// 即时聊天消息对象
SWIFT_CLASS("_TtC9AIChatKit14AIConversation")
@interface AIConversation : NSObject
@property (nonatomic, copy) NSString * _Nonnull conversationkey;
@property (nonatomic, copy) NSString * _Nonnull userkey;
@property (nonatomic, copy) NSString * _Nonnull objectkey;
@property (nonatomic, copy) NSString * _Nonnull conversationName;
@property (nonatomic, copy) NSString * _Nonnull number;
@property (nonatomic, copy) NSString * _Nonnull lastSendMsgTime;
@property (nonatomic, copy) NSString * _Nonnull lastSendMsgid;
@property (nonatomic, copy) NSString * _Nonnull unreadCount;
@property (nonatomic, strong) AIUserInfo * _Nullable userInfo;
@property (nonatomic, strong) AIGroup * _Nullable groupInfo;
@property (nonatomic, strong) AIChatMessage * _Nullable lastChatMessage;
/// 获取会话的聊天记录
/// \param count 每次加载条数
///
/// \param lastMsgid 最后一条消息的id
///
/// \param callback 网络加载后的回调
///
///
/// returns:
/// 缓存数据查询结果
- (void)getMessagesWithCount:(NSInteger)count lastMsgid:(NSInteger)lastMsgid callback:(void (^ _Nullable)(BOOL, NSArray<AIChatMessage *> * _Nonnull, NSString * _Nonnull))callback;
/// 发送消息
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
- (void)sendMessageWithText:(NSString * _Nonnull)text callback:(void (^ _Nullable)(BOOL, NSString * _Nonnull, NSString * _Nonnull))callback;
/// 确认会话已阅
/// <ul>
///   <li>
///     Parameters:
///   </li>
///   <li>
///     callback: 处理回调
///   </li>
/// </ul>
- (void)setReadWithCallback:(void (^ _Nullable)(BOOL, id _Nullable))callback;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS_NAMED("AIConversationEntity")
@interface AIConversationEntity : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end

@class NSData;

@interface AIConversationEntity (SWIFT_EXTENSION(AIChatKit))
@property (nonatomic, copy) NSString * _Nullable conversationkey;
@property (nonatomic, copy) NSString * _Nullable conversationName;
@property (nonatomic, copy) NSString * _Nullable conversationType;
@property (nonatomic, strong) NSData * _Nullable groupInfo;
@property (nonatomic, copy) NSString * _Nullable isTop;
@property (nonatomic, strong) NSData * _Nullable lastChatMessage;
@property (nonatomic) int64_t lastSendMsgid;
@property (nonatomic) int64_t lastSendMsgTime;
@property (nonatomic) int64_t number;
@property (nonatomic, copy) NSString * _Nullable objectkey;
@property (nonatomic) int64_t toptime;
@property (nonatomic) int64_t unreadCount;
@property (nonatomic, strong) NSData * _Nullable userInfo;
@property (nonatomic, copy) NSString * _Nullable userkey;
@end


/// 好友关系对象
SWIFT_CLASS("_TtC9AIChatKit12AIFriendship")
@interface AIFriendship : NSObject
@property (nonatomic, copy) NSString * _Nonnull relationType;
@property (nonatomic, copy) NSString * _Nonnull addWording;
@property (nonatomic, copy) NSString * _Nonnull addSource;
@property (nonatomic, copy) NSString * _Nonnull friendNote;
@property (nonatomic, copy) NSString * _Nonnull addType;
@property (nonatomic, copy) NSString * _Nonnull relationStatus;
@property (nonatomic, strong) AIUserInfo * _Nullable friendInfo;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class AIGroupMember;

/// 群组对象
SWIFT_CLASS("_TtC9AIChatKit7AIGroup")
@interface AIGroup : NSObject
@property (nonatomic, copy) NSString * _Nonnull groupid;
@property (nonatomic, copy) NSString * _Nonnull groupkey;
@property (nonatomic, copy) NSString * _Nonnull groupType;
@property (nonatomic, copy) NSString * _Nonnull groupName;
@property (nonatomic, copy) NSString * _Nonnull groupDesc;
@property (nonatomic, copy) NSString * _Nonnull groupNotice;
@property (nonatomic, copy) NSString * _Nonnull groupAvatarUrl;
@property (nonatomic, strong) AIGroupMember * _Nullable owner;
@property (nonatomic, copy) NSString * _Nonnull createTime;
@property (nonatomic, copy) NSString * _Nonnull lastInfoTime;
@property (nonatomic, copy) NSString * _Nonnull lastMsgTime;
@property (nonatomic, copy) NSString * _Nonnull memberNum;
@property (nonatomic, copy) NSString * _Nonnull maxMemberNum;
@property (nonatomic, copy) NSString * _Nonnull applyJoinOption;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS_NAMED("AIGroupEntity")
@interface AIGroupEntity : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface AIGroupEntity (SWIFT_EXTENSION(AIChatKit))
@property (nonatomic, copy) NSString * _Nullable applyJoinOption;
@property (nonatomic) int64_t createTime;
@property (nonatomic, copy) NSString * _Nullable groupAvatarUrl;
@property (nonatomic, copy) NSString * _Nullable groupDesc;
@property (nonatomic) int64_t groupid;
@property (nonatomic, copy) NSString * _Nullable groupkey;
@property (nonatomic, copy) NSString * _Nullable groupName;
@property (nonatomic, copy) NSString * _Nullable groupNotice;
@property (nonatomic, copy) NSString * _Nullable groupType;
@property (nonatomic) int64_t lastInfoTime;
@property (nonatomic) int64_t lastMsgTime;
@property (nonatomic) int64_t maxMemberNum;
@property (nonatomic) int64_t memberNum;
@property (nonatomic, strong) NSData * _Nullable owner;
@end


SWIFT_CLASS("_TtC9AIChatKit13AIGroupMember")
@interface AIGroupMember : NSObject
@property (nonatomic, copy) NSString * _Nonnull userkey;
@property (nonatomic, copy) NSString * _Nonnull memberName;
@property (nonatomic, copy) NSString * _Nonnull role;
@property (nonatomic, copy) NSString * _Nonnull joinTime;
@property (nonatomic, copy) NSString * _Nonnull disableSpeak;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC9AIChatKit10AIUserInfo")
@interface AIUserInfo : NSObject
@property (nonatomic, copy) NSString * _Nonnull userkey;
@property (nonatomic, copy) NSString * _Nonnull username;
@property (nonatomic, copy) NSString * _Nonnull nickname;
@property (nonatomic, copy) NSString * _Nonnull avatarUrl;
@property (nonatomic, copy) NSString * _Nonnull role;
@property (nonatomic, copy) NSString * _Nonnull msgSettings;
@property (nonatomic, copy) NSString * _Nonnull allowType;
@property (nonatomic, copy) NSString * _Nonnull extAttr;
@property (nonatomic, copy) NSString * _Nonnull online;
@property (nonatomic, copy) NSString * _Nonnull language;
/// 全局唯一实例
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, strong) AIUserInfo * _Nonnull sharedInstance;)
+ (AIUserInfo * _Nonnull)sharedInstance SWIFT_WARN_UNUSED_RESULT;
+ (void)setSharedInstance:(AIUserInfo * _Nonnull)newValue;
/// 获取用户列表
///
/// returns:
///
+ (NSArray<AIUserInfo *> * _Nonnull)getLists SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS_NAMED("AIUserInfoEntity")
@interface AIUserInfoEntity : NSManagedObject
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface AIUserInfoEntity (SWIFT_EXTENSION(AIChatKit))
@property (nonatomic, copy) NSString * _Nullable allowType;
@property (nonatomic, copy) NSString * _Nullable avatarUrl;
@property (nonatomic, copy) NSString * _Nullable extAttr;
@property (nonatomic, copy) NSString * _Nullable language;
@property (nonatomic, copy) NSString * _Nullable msgSettings;
@property (nonatomic, copy) NSString * _Nullable nickname;
@property (nonatomic, copy) NSString * _Nullable online;
@property (nonatomic, copy) NSString * _Nullable role;
@property (nonatomic) int64_t totalUnreadCount;
@property (nonatomic, copy) NSString * _Nullable userkey;
@property (nonatomic, copy) NSString * _Nullable username;
@end


SWIFT_CLASS("_TtC9AIChatKit5Hello")
@interface Hello : NSObject
- (void)hello;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

SWIFT_MODULE_NAMESPACE_POP
#pragma clang diagnostic pop
