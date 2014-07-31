#ifndef __IHTTP_WEB_REQUEST_H__
#define __IHTTP_WEB_REQUEST_H__

// prefix
#define HTTP_WEB_HTTPS_PREFIX "https://"
#define HTTP_WEB_HTTP_PREFIX "http://"

class IHTTPWebRequest
{
public:
	// dtor
	virtual ~IHTTPWebRequest() = 0;
	
	// set member vars
	// addr can be ip address or hostname
	virtual void SetAddr( const char* addr ) = 0;
	virtual void SetPort( const unsigned short port ) = 0;
	// path with the first char is "/"
	virtual void SetPath( const char* path ) = 0;
	
	// set method
	virtual void SetMethod( const char* method ) = 0;

	// set headers
	virtual void SetHeader( const char* key, const char* value ) = 0;
	virtual void SetHeader( const char* key, const int value ) = 0;
	virtual void ClearHeaders() = 0;

	// set parameters
	virtual void SetParameter( const char* key, const char* value ) = 0;
	virtual void SetParameter( const char* key, const int value ) = 0;
	virtual void ClearParameters() = 0;

	// send request
	virtual int DoRequest() = 0;
	virtual int SendRequestHeader() = 0;
	virtual int SendRequestBody( const char* data = NULL, const int data_len = 0 ) = 0;

	// get response header
	virtual const char* GetResponseHeader() = 0;

	// get response body
	virtual int GetResponseBody( char* buf, int buf_len ) = 0;

	// set socket timeout
	// default: 10000, max: 30000, min: 100
	static void SetSocketTimeout( unsigned short msec );

protected:
	// use a static variable to set timeout in msec
	static unsigned short m_socket_conn_recv_timeout_in_msec;
};

// some utils
std::string FindDataSegment( const std::string& source_str, const std::string start_str, const std::string end_str );
std::string GetJSONVarValue( const std::string& src, const std::string var_name );
std::string GetResponseBodyString( IHTTPWebRequest* req );
void ParseURL( const std::string full_url, std::string& addr, unsigned short& port, std::string& path );
int MinValue( int a, int b );

#endif /* __IHTTP_WEB_REQUEST_H__ */

