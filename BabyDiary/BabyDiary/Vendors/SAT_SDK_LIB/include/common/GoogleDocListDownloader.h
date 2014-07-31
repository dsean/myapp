#ifndef __GOOGLE_DOC_LIST_DOWNLOADER_H__
#define __GOOGLE_DOC_LIST_DOWNLOADER_H__

#include "GoogleDocListBase.h"

class GoogleDocListDownloader : public GoogleDocListBase
{
public:
	GoogleDocListDownloader( GoogleOAuth2* p_oauth2 );
	virtual ~GoogleDocListDownloader();

	// get file/folder list
	int GetEntryListNext( std::vector<GoogleDocListEntry*>& entry_list ); // get next page, should call GetEntryList first
	int GetEntryList( std::vector<GoogleDocListEntry*>& entry_list, GoogleDocListEntry* p_root_entry = NULL,
		const bool show_folders = true, const bool show_files = true, // select show type
		const char* search_title = NULL, const bool exact_search = true, // select search type
		int max_results = 1000 ); // limit the maxmium result (only accept 1~1000)
	static void FreeEntryList( std::vector<GoogleDocListEntry*>& entry_list );
	static void PrintEntryList( const std::vector<GoogleDocListEntry*>& entry_list );

	// delete "one" file/folder entry
	int DeleteEntryByResouceID( const char* resource_id );
	int DeleteEntry( GoogleDocListEntry* p_entry );

	// get "one" file/folder entry
	int GetOneEntry( const char* resource_id, GoogleDocListEntry* p_entry, const char* etag = NULL );

	// download
	// buffer download function
	int DownloadStart( GoogleDocListEntry* p_goole_doc_list_entry );
	int DownloadContinue( char* buf, const int buf_len );
	int DownloadEnd();

	// file download function
	int DownloadFile( GoogleDocListEntry* p_goole_doc_list_entry, const char* out_file_path = NULL );

	// get size
	int GetQuota( pj_uint64_t* p_quota_bytes_total, pj_uint64_t* p_quota_bytes_used, pj_uint64_t* p_quota_bytes_in_trash = NULL );

	// friends
	friend class GoogleRelayDataFile;

private:
	void ParseEntryList( std::vector<GoogleDocListEntry*>& entry_list, const std::string& response_body );

	// store the next url
	std::string m_next_url;
};

#endif /* __GOOGLE_DOC_LIST_DOWNLOADER_H__ */