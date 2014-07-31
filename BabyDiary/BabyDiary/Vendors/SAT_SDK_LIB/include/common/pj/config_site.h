#include "sat_sdk_lib_module_config.h"
// reference http://sourceforge.net/apps/mediawiki/predef/index.php?title=Operating_Systems
// and http://stackoverflow.com/questions/146986/what-defines-are-set-up-by-xcode-when-compiling-for-iphone
// check for windows
#ifdef _WIN32
	#define PJ_WIN32 1
// check for iphone
#elif defined(__APPLE__)
	#include "TargetConditionals.h"
	#ifdef TARGET_OS_IPHONE
		#define PJ_CONFIG_IPHONE 1
		#define PJ_IS_LITTLE_ENDIAN 1
		#define PJ_IS_BIG_ENDIAN 0
	#endif /* TARGET_OS_IPHONE */
#endif /* __APPLE__ */

#define PJ_OS_HAS_CHECK_STACK	0
#if HAVE_DEBUG_MSG
	#define PJ_LOG_MAX_LEVEL		4
#else /* HAVE_DEBUG_MSG */
	#define PJ_LOG_MAX_LEVEL		0
#endif /* HAVE_DEBUG_MSG */
#define PJ_ENABLE_EXTRA_CHECK	0
#define PJ_DEBUG				0
#define PJ_HAS_STRICMP_ALNUM	0
#define PJ_HASH_USE_OWN_TOLOWER	1
#define PJ_CRC32_HAS_TABLES 	0
#define PJ_HAS_ERROR_STRING 	0
#define PJ_IOQUEUE_MAX_HANDLES 1024

// disable resolve localhost (may take a long time for some network environments)
#define PJ_GETHOSTIP_DISABLE_LOCAL_RESOLUTION 1

#include <pj/config_site_sample.h>
