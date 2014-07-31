#ifndef __DEVICE_ENTRY_REQUEST_H__
#define __DEVICE_ENTRY_REQUEST_H__

#include <iostream>
#include <string>
#include <vector>

using namespace std;

class DeviceFunction {
public:
	DeviceFunction();
	DeviceFunction(string set_purpose, string set_url_prefix, unsigned short set_port, string set_url_path);
	string purpose;
	string url_prefix;
	unsigned short port;
	unsigned short internal_port;
	string url_path;
	
	friend ostream &operator<<(ostream &o, DeviceFunction function);
};

class DeviceEntryRequest {
public:
	DeviceEntryRequest();
	
	string device_name;
	string mac_address;
	string enc;
	string internal_ip;
	string manufacturer;
	string model;
	string fw_version;
	string client_version;
	vector<DeviceFunction> functions;
	
	friend ostream &operator<<(ostream &o, DeviceEntryRequest device_entry_request);
};

#endif
