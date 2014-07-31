#ifndef __SAT_SDK_LIB_RETURN_CODE_H__
#define __SAT_SDK_LIB_RETURN_CODE_H__

/////////////////////////////////////////////////////////////////////////////////////
// Error Code Naming Rule
/////////////////////////////////////////////////////////////////////////////////////
// SAT_SDK_LIB_RET_XXX_YYY
// XXX: Facility with Upper Case
// YYY: Code with Upper Case
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
// Error Code Format
/////////////////////////////////////////////////////////////////////////////////////
// Bit    | 31 | 30-27 | 26-16 | 15-0 |
// Field  | S  | R     | F     | C    |
// S: Severity 0->Success, 1->Failure
// R: Reserved
// F: Facility
// C: Code
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
// Facility Definition 0x0(000~7FF)0000
/////////////////////////////////////////////////////////////////////////////////////
#define SAT_SDK_LIB_FACILITY_NULL						0x00000000
#define SAT_SDK_LIB_FACILITY_SIGNAL						0x00010000
#define SAT_SDK_LIB_FACILITY_TUNNEL						0x00020000
#define SAT_SDK_LIB_FACILITY_LICENSE					0x00030000
#define SAT_SDK_LIB_FACILITY_CLOUD_STORAGE				0x00040000
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
// Facility NULL Error Code (for broadly applicable common status code)
/////////////////////////////////////////////////////////////////////////////////////
// commonly used success code
#define SAT_SDK_LIB_RET_NULL_SUCCESS					0x00000000
// the function not failed, but maybe the state is not ready, please try again later
#define SAT_SDK_LIB_RET_NULL_TRY_AGAIN_LATER			0x00000001
// the execution is pending, will be completed later
#define SAT_SDK_LIB_RET_NULL_PENDING					0x00000002
// commonly used fail code
#define SAT_SDK_LIB_RET_NULL_FAIL						0x80000000
// this function is not supported/implemented for this platform
#define SAT_SDK_LIB_RET_NULL_PLATFORM_NOT_SUPPORTED		0x80000001
// this function is not supported/implemented for this object
#define SAT_SDK_LIB_RET_NULL_OBJECT_NOT_SUPPORTED		0x80000002
// the input argument is invalid
#define SAT_SDK_LIB_RET_NULL_INVALID_ARGUMENT			0x80000003
// memory allocation failed
#define SAT_SDK_LIB_RET_NULL_MEM_ALLOC_FAIL				0x80000004
// create thread failed
#define SAT_SDK_LIB_RET_NULL_THREAD_CREATE_FAIL			0x80000005
// create socket failed
#define SAT_SDK_LIB_RET_NULL_SOCKET_CREATE_FAIL			0x80000006
// setsockopt failed
#define SAT_SDK_LIB_RET_NULL_SOCKET_SET_OPT_FAIL		0x80000007
// parse address failed, maybe caused by wrong address or not setting DNS server
#define SAT_SDK_LIB_RET_NULL_ADDRESS_PARSE_FAIL			0x80000008
// tcp port bind failed, maybe the port is used by other process
#define SAT_SDK_LIB_RET_NULL_SOCKET_BIND_FAIL			0x80000009
// tcp connection failed, maybe caused by network error
#define SAT_SDK_LIB_RET_NULL_TCP_CONNECT_FAIL			0x8000000A
// tcp accept failed
#define SAT_SDK_LIB_RET_NULL_TCP_ACCEPT_FAIL			0x8000000B
// tcp send failed
#define SAT_SDK_LIB_RET_NULL_SEND_FAIL					0x8000000C
// tcp recv failed
#define SAT_SDK_LIB_RET_NULL_TCP_RECV_FAIL				0x8000000D
// load ca certificate fail
#define SAT_SDK_LIB_RET_NULL_SSL_CA_CERT_LOAD_FAIL		0x8000000E
// load client certificate fail
#define SAT_SDK_LIB_RET_NULL_SSL_CLIENT_CERT_LOAD_FAIL	0x8000000F
// load client private key fail
#define SAT_SDK_LIB_RET_NULL_SSL_CLIENT_KEY_LOAD_FAIL	0x80000010
// ssl initialize failed, maybe caused by wrong certificate or polarssl bug
#define SAT_SDK_LIB_RET_NULL_SSL_INIT_FAIL				0x80000011
// ssl handshake failed, maybe casued by wrong server settings or polarssl bug
#define SAT_SDK_LIB_RET_NULL_SSL_HANDSHAKE_FAIL			0x80000012
// this function does not allow re-enter
#define SAT_SDK_LIB_RET_NULL_REENTER_NOT_ALLOWED		0x80000013
// open file failed
#define SAT_SDK_LIB_RET_NULL_OPEN_FILE_FAIL				0x80000014
// read file failed
#define SAT_SDK_LIB_RET_NULL_READ_FILE_FAIL				0x80000015
// write file failed
#define SAT_SDK_LIB_RET_NULL_WRITE_FILE_FAIL			0x80000016
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
// Facility Signal Error Code (for signal server communication status code)
/////////////////////////////////////////////////////////////////////////////////////
// invalid state, maybe you call the functions in an incorrect order
#define SAT_SDK_LIB_RET_SIGNAL_INVALID_STATE			0x80010000
// failed to connect to signal server, maybe caused by wrong signal server address or network error
#define SAT_SDK_LIB_RET_SIGNAL_SRV_CONNECT_FAIL			0x80010001
// send request msg to signal server failed, maybe caused by network error
#define SAT_SDK_LIB_RET_SIGNAL_REQ_FAIL					0x80010002
// signal server response failed for unknown reason, maybe caused by network error
#define SAT_SDK_LIB_RET_SIGNAL_RESP_FAIL				0x80010003
// failed to do signal server authentication
#define SAT_SDK_LIB_RET_SIGNAL_RESP_AUTH_FAIL			0x80010004
// the uid is already used by other pere
#define SAT_SDK_LIB_RET_SIGNAL_RESP_ID_DUPLICATE		0x80010005
// signal server can't find the target peer
#define SAT_SDK_LIB_RET_SIGNAL_RESP_ID_NOT_FOUND		0x80010006
// when signal server try to send data to the peer, the connection is gone
#define SAT_SDK_LIB_RET_SIGNAL_RESP_PEER_GONE			0x80010007
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
// Facility Tunnel Error Code (for p2p tunnel communication status code)
/////////////////////////////////////////////////////////////////////////////////////
// you can't call connection with uid point to yourself
#define SAT_SDK_LIB_RET_TUNNEL_LINK_TO_SELF				0x80020000
// tunnel link not established yet
#define SAT_SDK_LIB_RET_TUNNEL_LINK_NOT_EXIST			0x80020001
// tunnel link already established
#define SAT_SDK_LIB_RET_TUNNEL_LINK_EXIST				0x80020002
// tunnel link still negotiating
#define SAT_SDK_LIB_RET_TUNNEL_LINK_NEGOTIATING			0x80020003
// create ice session failed (may be caused by pjlib/stun/turn problem or memory shortage)
#define SAT_SDK_LIB_RET_TUNNEL_LINK_INIT_FAIL			0x80020004
// convert connection info to sdp failed
#define SAT_SDK_LIB_RET_TUNNEL_LINK_SDP_GET_FAIL		0x80020005
// tunnel session not established
#define SAT_SDK_LIB_RET_TUNNEL_SESSION_NOT_EXIST		0x80020006
// concurrent session number > 256
#define SAT_SDK_LIB_RET_TUNNEL_TOO_MANY_SESSIONS		0x80020007
// concurrent connection number > 256
#define SAT_SDK_LIB_RET_TUNNEL_TOO_MANY_CONNECTIONS		0x80020008
/////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////
// Facility License Error Code (for license read/check status code)
/////////////////////////////////////////////////////////////////////////////////////
// invalid license
#define SAT_SDK_LIB_RET_LICENSE_INVALID_LICENSE			0x80030000
// send request to sat fail
#define SAT_SDK_LIB_RET_LICENSE_SAT_REQ_FAIL			0x80030001
// parse response fail
#define SAT_SDK_LIB_RET_LICENSE_SAT_RESP_PARSE_FAIL		0x80030002
// sat return status fail
#define SAT_SDK_LIB_RET_LICENSE_SAT_RESP_RET_FAIL		0x80030003
// sat request register success
#define SAT_SDK_LIB_RET_LICENSE_SAT_REGISTER_SUCCESS	0x00030004
// sat request register fail
#define SAT_SDK_LIB_RET_LICENSE_SAT_REGISTER_FAIL		0x80030004
// load license fail
#define SAT_SDK_LIB_RET_LICENSE_LOAD_LICENSE_FAIL		0x80030005
/////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////
// Facility Cloud Storage Error Code (for google download/upload/relay status code)
/////////////////////////////////////////////////////////////////////////////////////
// entry not modified
#define SAT_SDK_LIB_RET_CLOUD_STORAGE_ENTRY_NOT_MODIFIED	0x00040000
// connection closed by google server (should try again later)
#define SAT_SDK_LIB_RET_CLOUD_STORAGE_CONNECTION_CLOSED		0x80040000
#define SAT_SDK_LIB_RET_CLOUD_STORAGE_NEED_BACKOFF			0x80040001
#define SAT_SDK_LIB_RET_CLOUD_STORAGE_UPLOAD_FAIL			0x80040002
#define SAT_SDK_LIB_RET_CLOUD_STORAGE_AUTH_FAIL				0x80040003
/////////////////////////////////////////////////////////////////////////////////////
#endif