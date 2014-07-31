#ifndef __IP2P_SAT_REQUEST_H__
#define __IP2P_SAT_REQUEST_H__

#include "DeviceEntry.h"
#include "DeviceEntryRequest.h"

class P2PSATRequest;
class P2PRegisterResponse {
public:
	P2PRegisterResponse() {}
	P2PRegisterResponse(const char* response) { this->parse(response); }

	int error_code;

	string message;
	string password;

	string cloud_provider;
	string cloud_client_id;
	string cloud_secret;
	string cloud_refresh_id;

	friend ostream& operator<<(ostream& o, P2PRegisterResponse response);
	friend class P2PSATRequest;

private:
	int parse(const char* response, const char *ver = NULL);

	string uid;
};

class IP2PSATRequest
{
public:
	// dtor
	virtual ~IP2PSATRequest() = 0;

	// register and update device_entry to sat server
	virtual int Register( const char* sid, DeviceEntryRequest* device_entry_request, const char* activated_code, P2PRegisterResponse& reg_response ) = 0;
	
	// Check activated status
	virtual int CheckActivated(const char *sid, const char* mac_addr, P2PRegisterResponse& reg_response ) = 0;

	// get uid
	virtual int GetUid( char* uid, const char* mac_addr=NULL ) = 0;

	// query device list
	virtual int GetDeviceEntryList( const std::vector<DeviceEntry*>** device_entry_list, const char* service_type = NULL, const char* device_type = NULL, const char* uid = NULL ) = 0;
};

#endif /* __IP2P_SAT_REQUEST_H__ */
