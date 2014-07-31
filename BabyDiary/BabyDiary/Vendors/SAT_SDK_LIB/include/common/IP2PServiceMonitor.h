#ifndef __IP2P_SERVICE_MONITOR_H__
#define __IP2P_SERVICE_MONITOR_H__

// only for caller
// arguments: 0->uid, 1->target_port, 2->local_ip, 3->local_port, 4->user_data
typedef void (*OnP2PTunnelSessionStateChangeFunc)( const char*, unsigned short, const char*, unsigned short, void* );
// arguments: 0->uid, 1->old state, 2->new state, 3->negotiation type, 4->laddr, 5->raddr, 6->user_data
typedef void (*OnP2PTunnelLinkStateChangeFunc)( const char*, enum TunnelLinkState, enum TunnelLinkState, const char*, const char*, const char*, void* );
// arguments: 0->old state, 1->new state, 2->user_data
typedef void (*OnSignalStateChangeFunc)( enum P2PSignalClientEntryState, enum P2PSignalClientEntryState, void* );

class IP2PServiceMonitor
{
public:
	// constructor
	IP2PServiceMonitor();

	// destructor
	virtual ~IP2PServiceMonitor() = 0;

	// set callbacks
	virtual void SetTunnelSessionStateCallback( OnP2PTunnelSessionStateChangeFunc callback, void* user_data ) = 0;
	virtual void SetTunnelLinkStateCallback( OnP2PTunnelLinkStateChangeFunc callback, void* user_data ) = 0;
	virtual void SetSignalStateCallback( OnSignalStateChangeFunc callback, void* user_data ) = 0;

	// set re-try interval & max count
	// interval default to 5 seconds
	// max_count <=0 means never stop
	virtual void SetRetry( const unsigned int interval_in_ms, const int signal_retry_max_count,
		const int tunnel_retry_max_count ) = 0;

	// set signal server
	virtual void SetSignalServer( const char* signal_srv_addr, const unsigned short* signal_srv_ports,
		const int signal_srv_ports_count ) = 0;

	// set config cache
	virtual void SetConfigCache( const char* config_cache_filename, const unsigned short timeout_in_sec ) = 0;

	// set google authentication
	virtual void SetGoogleAuthentication( const char* client_id, const char* client_secret, const char* refresh_token ) = 0;

	// set enabled tunnel mode
	virtual void SetEnabledTunnelMode( const unsigned short enabled_tunnel_mode ) = 0;

	// start/stop
	virtual int Start() = 0;
	virtual void Stop() = 0;

	// tunnel manage
	virtual int AddTunnelLink( const char* remote_uid ) = 0;
	virtual int AddTunnelSession( const char* remote_uid, const unsigned short port ) = 0;
	virtual void RemoveTunnelLink( const char* remote_uid ) = 0;
	virtual void RemoveTunnelSession( const char* remote_uid, const unsigned short port ) = 0;

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// manually get state when unable to use callback function
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// get the status of the connection to signal server
	virtual P2PSignalClientEntryState GetSignalState() = 0;
	// get the status of connection to another p2p peer
	virtual TunnelLinkState GetTunnelLinkState( const char* remote_uid ) = 0;
	// get session state
	virtual int GetTunnelSessionState( const char* remote_uid, const unsigned short target_port, std::string* p_local_addr, unsigned short* p_local_port ) = 0;
	// get negotiation result
	virtual int GetNegotiationResult( const char* remote_uid, std::string* p_type, std::string* p_laddr, std::string* p_raddr ) = 0;
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
};

namespace P2PFactory {
	IP2PServiceMonitor* CreateP2PServiceMonitor( const char* local_uid );
};

#endif /* __IP2P_SERVICE_MONITOR_H__ */
