#ifndef __IP2P_TUNNEL_H__
#define __IP2P_TUNNEL_H__

class IP2PTunnel
{
public:
	// constructor
	IP2PTunnel();

	// destructor
	virtual ~IP2PTunnel() = 0;

	// set signal server
	virtual int SetSignalServer( const char* address, const unsigned short port ) = 0;
	virtual int SetSignalServer( const char* address, const unsigned short* ports, const int ports_count ) = 0;

	// set ssl signal server
	virtual int SetSSL( const char* ca_crt_filename, const char* client_crt_filename, const char* client_key_filename ) = 0;

	// stop everything
	virtual int Stop() = 0;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// deprecated start & authenticate
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// connect to signal server
	virtual int Start() = 0;
	// register to signal server and authenticate.
	// 1. authenticate
	// 2. set uid
	virtual int Authenticate( const char* uid, const char* password = NULL ) = 0;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// new faster StartEx to replace Start & Authenticate
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	virtual int StartEx( const char* uid, const char* password = NULL ) = 0;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// create tunnel link
	virtual int Connect( const char* remote_id, const unsigned short enabled_tunnel_mode = 0x0006 /* default to ice+cloud for backward compatible */ ) = 0;
	// destroy tunnel link
	virtual int DisConnect( const char* remote_id ) = 0;
	// create tunnel session
	virtual int ConnectTunnel( const char* remote_id, unsigned char protocol,
		const char* target_addr, unsigned short target_port,
		unsigned short* p_local_port,
		std::string* p_local_addr = NULL /* default to NULL for backward compatible, but NULL will cause fail for direct mode */ ) = 0;
	// destroy tunnel session
	virtual int DisConnectTunnel( const char* remote_id, unsigned char protocol, const char* target_addr, unsigned short target_port ) = 0;

	// get the status of the connection to signal server
	virtual P2PSignalClientEntryState GetState() = 0;

	// get the status of connection to another p2p peer
	virtual TunnelLinkState GetTunnelLinkState( const char* remote_id ) = 0;

	// get ice negotiation result
	virtual int GetNegotiationResult( const char* remote_id, std::string* p_type, std::string* p_laddr, std::string* p_raddr ) = 0;

	// detect NAT type (this function may block for a while)
	virtual int DetectNATType( std::string* p_nat_type ) = 0;

	// setup google relay refresh token
	virtual int SetGoogleAuthentication( const char* client_id, const char* client_secret, const char* refresh_token ) = 0;

	// enable config cache
	// if timeout_in_sec == 0, disable config cache
	virtual int EnableConfigCache( const char* config_cache_filename, const unsigned short timeout_in_sec ) = 0;

	// setup update ice servers interval
	// default: 600, max: 36000, min: 300, turnoff: 0
	// if set to 0, disable the update function
	// for caller, it's suggested to turnoff this function
	void SetUpdateICEServersInterval( const unsigned short sec );

	// set callee enabled tunnel mode
	// by default, all modes are enabled
	void SetCalleeEnabledTunnelMode( const unsigned short enabled_tunnel_mode );

protected:
	// update ice servers interval
	unsigned short m_update_ice_servers_interval;

	// callee enabled tunnel mode
	unsigned short m_callee_enabled_tunnel_mode;
};

#endif /* __IP2P_TUNNEL_H__ */
