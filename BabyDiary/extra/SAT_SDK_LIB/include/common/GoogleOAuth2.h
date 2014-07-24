#ifndef __GOOGLE_OAUTH_2_H__
#define __GOOGLE_OAUTH_2_H__

#define MY_GOOGLE_API_REDIRECT_URI "urn:ietf:wg:oauth:2.0:oob"

class GoogleOAuth2
{
public:
	GoogleOAuth2( const char* client_id, const char* client_secret, const char* refresh_token, const char* authorization_code = NULL );
	~GoogleOAuth2();

	// set authorization code
	void SetAuthorizationCode( const char* authorization_code );

	// get/set refresh token
	std::string GetRefreshToken();
	void SetRefreshToken( const char* refresh_token );

	// get auth url
	std::string GetAuthorizationURL();

	// get access token
	int GetAccessToken( std::string* p_access_token = NULL, std::string* p_token_type = NULL );
	int GetAuthorizationHeader( std::string& authorization_header );

	// get binding email
	std::string GetUserEmail();

	// for print
	friend std::ostream &operator<<( std::ostream &stream, GoogleOAuth2 oauth2 );

	// friend class
	friend class GoogleRelay;

private:
	int GetNewAccessToken( std::string& response_body );
	int GetRefreshAccessToken( std::string& response_body );
	int QueryUserInfo();

	// api properties
	std::string m_client_id;
	std::string m_client_secret;
	std::string m_redirect_uri;

	// token properties
	std::string m_authorization_code;
	std::string m_refresh_token;
	std::string m_access_token;
	std::string m_token_type;
	time_t m_expire_time;

	// user info
	std::string m_user_email;
};

#endif /* __GOOGLE_OAUTH_2_H__ */
