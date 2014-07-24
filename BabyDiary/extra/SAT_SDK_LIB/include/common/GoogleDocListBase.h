#ifndef __GOOGLE_DOC_LIST_BASE_H__
#define __GOOGLE_DOC_LIST_BASE_H__

class HTTPWebRequest;
class GoogleDocListEntry;
class GoogleDocListBase
{
public:
	GoogleDocListBase( GoogleOAuth2* p_oauth2 );
	virtual ~GoogleDocListBase();

protected:
	// parse doc list entry
	int ParseOneEntry( const char* xml_str, GoogleDocListEntry* p_entry );

	// process http web request function
	HTTPWebRequest* GetWebRequest( const char* addr, unsigned short port, const char* path, const char* method );
	void RemoveWebRequest( const char* addr );

	// oauth2
	GoogleOAuth2* m_p_oauth2;

	// http request map
	HTTPWebRequest* m_p_web_request;
	std::map<std::string, HTTPWebRequest*> m_p_web_request_map;
};

#endif /* __GOOGLE_DOC_LIST_BASE_H__ */