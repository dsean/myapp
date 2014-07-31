#ifndef __P2P_FACTORY_H__
#define __P2P_FACTORY_H__

class IP2PLicense;
class IP2PTunnel;
class IHTTPWebRequest;
class IP2PSATRequest;
namespace P2PFactory {
	IP2PLicense* CreateLicense(const char* license_path);
	IP2PTunnel* CreateTunnelCaller();
	IP2PTunnel* CreateTunnelCallee();
	IP2PSATRequest* CreateSATRequest( const char* username, const char* password, IP2PLicense* p2p_license, const char* ca_certificate_filepath=NULL );
	IHTTPWebRequest* CreateHTTPWebRequest( const char* addr, const unsigned short port, const char* path, const char* method );
	IHTTPWebRequest* CreateHTTPSWebRequest( const char* addr, const unsigned short port, const char* path, const char* method, const char* ca_crt_filename );
};

#endif /* __P2P_FACTORY_H__ */
