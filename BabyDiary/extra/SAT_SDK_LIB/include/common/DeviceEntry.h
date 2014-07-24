#ifndef __DEVICE_ENTRY_H__
#define __DEVICE_ENTRY_H__

#include <iostream>
#include <string>

using namespace std;

class DeviceEntry {
public:
	DeviceEntry();
	
	string uid;
	string device_name;
	string purpose;
	string url_prefix;
	string ip;
	unsigned short port;
	string url_path;
	string mac_address;
	string enc;
	string service_type;
	string device_type;
	bool is_signal_online;
	string cloud_provider;
	string cloud_client_id;
	string cloud_secret;
	string cloud_refresh_id;
	string features;
	string default_id;
	string default_pw;
	string manufacturer;
	string model;
	string device_models_version;
	friend ostream &operator<<(ostream &o, DeviceEntry device_entry);
};

#endif
