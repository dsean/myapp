#ifndef __GOOGLE_DOC_LIST_ENTRY_H__
#define __GOOGLE_DOC_LIST_ENTRY_H__

#define GOOGLE_DOC_LIST_LINK_EMBED "http://schemas.google.com/docs/2007#embed"
#define GOOGLE_DOC_LIST_LINK_RESUMABLE_CREATE_MEDIA "http://schemas.google.com/g/2005#resumable-create-media"
#define GOOGLE_DOC_LIST_LINK_RESUMABLE_EDIT_MEDIA "resumable-edit-media"

class GoogleDocListEntry
{
public:
	GoogleDocListEntry();
	~GoogleDocListEntry();

	// parse xml data
	int ParseXML( pj_xml_node *xml_entry_node );

	// for print
	friend std::ostream &operator<<( std::ostream &stream, GoogleDocListEntry entry );

	// entry info
	std::string m_gd_etag;
	std::string m_id;
	std::string m_title;
	std::string m_content_type;
	std::string m_content_src; // this is the download url
	std::string m_resourceId;
	std::string m_link_embed;
	std::string m_link_resumable; // this is the resumable upload url
	std::string m_category_kind;
	std::string m_updated;
	int m_docs_size;
};

void string_replace_all( std::string& str, const std::string& from , const std::string& to );

#endif /* __GOOGLE_DOC_LIST_ENTRY_H__ */