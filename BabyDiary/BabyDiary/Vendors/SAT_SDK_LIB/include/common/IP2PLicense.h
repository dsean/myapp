#ifndef I_P2P_LICENSE_H
#define I_P2P_LICENSE_H

class IP2PLicense {
public:
	virtual ~IP2PLicense() = 0;

	virtual int GetSignalServer(char* signal_server_address, unsigned short* signal_server_ports, const int signal_server_ports_count=1) const = 0;
	virtual int GetSATServer(char* sat_server_address, unsigned short* sat_server_port) const = 0;
	virtual int GetOemId(char* oem_id) const = 0;
	virtual int GetCID(char* cid) const = 0;
	virtual int GetPID(char* pid) const = 0;
	virtual int GetServiceType(char* service_type) const = 0;
	virtual bool IsValid() const = 0;
};

#endif
