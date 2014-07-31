#ifndef __GOOGLE_DOC_LIST_UPLOADER_H__
#define __GOOGLE_DOC_LIST_UPLOADER_H__

#define GOOGLE_DOC_LIST_512K_LIMIT 524288

#include "GoogleDocListBase.h"
class HTTPWebRequest;
class GoogleDocListEntry;
class GoogleDocListUploader : public GoogleDocListBase
{
public:
	GoogleDocListUploader( GoogleOAuth2* p_oauth2 );
	virtual ~GoogleDocListUploader();

	// set resumable create media link
	int SetLinkResumableCreateMedia( const GoogleDocListEntry* p_goole_doc_list_entry );
	int SetLinkResumableCreateMedia( const char* link_resumable_create_media = NULL );

	// buffer upload function
	int UploadStart( const char* content_name, const char* content_type, const int content_length );
	int UploadContinue( const char* data, int data_len );
	int UploadEnd( GoogleDocListEntry* p_goole_doc_list_entry = NULL );

	// file upload function
	int UploadFile( const char* file_path, GoogleDocListEntry* p_goole_doc_list_entry = NULL, const char* mime_type = NULL );

	// create directory (or named as collection)
	int CreateDirectory( const char* directory_name, GoogleDocListEntry* p_out_entry = NULL, GoogleDocListEntry* p_root_entry = NULL );

	// get mime type from file name
	static std::string GetMIMEType( std::string file_name );

	// flag to check if it's an update
	bool m_is_update;

	// flag to check if need to upload metatdata
	bool m_is_metadata_upload;

	// friend class
	friend class GoogleRelayDataFile;
	friend class LocalGoogleRelayDataFile;
	friend class RemoteGoogleRelayDataFile;
private:
	// google oauth2
	GoogleOAuth2* m_p_oauth2;

	// check if need to get resumable create media url
	int GetLinkResumableCreateMedia();
	void ParseUploadLink();

	// the root create media url (remeber this to reduce time cost)
	std::string m_root_link_resumable_create_media;

	// create media url
	std::string m_link_resumable_create_media;
	std::string m_upload_addr;
	unsigned short m_upload_port;
	std::string m_upload_path;

	// google randomly generated upload path
	std::string m_random_upload_url;
	std::string m_random_upload_addr;
	unsigned short m_random_upload_port;
	std::string m_random_upload_path;

	// content length
	int m_upload_content_length;
	int m_aleady_uploaded_content_length;
	int m_upload_chunk_end_length;
};

#endif /* __GOOGLE_DOC_LIST_UPLOADER_H__ */
