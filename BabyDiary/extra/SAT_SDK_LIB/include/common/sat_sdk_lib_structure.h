#ifndef __SAT_SDK_LIB_STRUCTURE_H__
#define __SAT_SDK_LIB_STRUCTURE_H__

// define rx callback function pointer
typedef int (*TunnelLinkCallback)(const char* remote_id, const char* data, int data_len, void* user_info);

#endif /* __SAT_SDK_LIB_STRUCTURE_H__ */