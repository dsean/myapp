#ifndef __SAT_SDK_LIB_ENUM_H__
#define __SAT_SDK_LIB_ENUM_H__

// define tunnel link mode
#define TUNNEL_LINK_DIRECT_MODE	0x0001
#define TUNNEL_LINK_ICE_MODE	0x0002
#define TUNNEL_LINK_CLOUD_MODE	0x0004

// client state
enum P2PSignalClientEntryState
{
	P2PSignalClientEntryState_Disconnected = 0,
	P2PSignalClientEntryState_Connected,
	P2PSignalClientEntryState_Authenticated,
	P2PSignalClientEntryState_Valid
};

// tunnel link state
enum TunnelLinkState
{
	TunnelLinkState_Disconnected = 0,
	TunnelLinkState_Negotiating,
	TunnelLinkState_Connected
};

#endif /* __SAT_SDK_LIB_ENUM_H__ */

