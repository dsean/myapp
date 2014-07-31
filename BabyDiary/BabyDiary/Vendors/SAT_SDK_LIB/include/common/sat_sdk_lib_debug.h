#ifndef __SAT_SDK_LIB_DEBUG_H__
#define __SAT_SDK_LIB_DEBUG_H__

enum DEBUG_LEVEL
{
	DEBUG_LEVEL_PJLOG=1,
	DEBUG_LEVEL_DEBUG,
	DEBUG_LEVEL_INFO,
	DEBUG_LEVEL_NOTICE,
	DEBUG_LEVEL_WARNING,
	DEBUG_LEVEL_ERROR,
	DEBUG_LEVEL_CRITICAL,
	DEBUG_LEVEL_ALERT,
	DEBUG_LEVEL_EMERGENCY,
	DEBUG_LEVEL_PANIC
};

// for debug function management
namespace SAT_SDK_LIB_Debug
{
	// get the current version
	const char* GetVersion();
	void ShowVersion();

	// get the callstack (should be used when crash)
	int GetCallStack( std::string* p_out_str );

	// polarssl debug callback
	void PolarSSLDebugCallback( void *ctx, int level, const char *str );

	// debug string output function
	DEBUG_LEVEL GetDebugLevel();
	void SetDebugLevel( DEBUG_LEVEL debug_level );
	void DebugOutput( enum DEBUG_LEVEL, const char* fmt, ... );
	void SetDebugOutputFile( const char* filename );
	void DebugOutputWithPrefix( enum DEBUG_LEVEL, const char* function_name, const char* fmt, ... );
	void CloseDebugOutputFile();
};

// declare a debugout macro to print function
#if HAVE_DEBUG_MSG
	#define DEBUG_OUTPUT_WITH_FUNCTION_NAME(debug_level, fmt, ...) \
		SAT_SDK_LIB_Debug::DebugOutputWithPrefix(debug_level, __FUNCTION__, fmt, ##__VA_ARGS__ )
#else /* HAVE_DEBUG_MSG */
	#define DEBUG_OUTPUT_WITH_FUNCTION_NAME(debug_level, fmt, ...) 
#endif /* HAVE_DEBUG_MSG */
	
// for debugging mutex
#if HAVE_DEBUG_MUTEX
	#define THREAD_MUTEX_LOCK(MUTEX_PTR, MUTEX_NAME) \
	{\
		SAT_SDK_LIB_Debug::DebugOutput(DEBUG_LEVEL_DEBUG, "%s: lock %s at line %d", __FUNCTION__, MUTEX_NAME, __LINE__); \
		pthread_mutex_lock(MUTEX_PTR); \
	}

	#define THREAD_MUTEX_UNLOCK(MUTEX_PTR, MUTEX_NAME) \
	{\
		SAT_SDK_LIB_Debug::DebugOutput(DEBUG_LEVEL_DEBUG, "%s: unlock %s at line %d", __FUNCTION__, MUTEX_NAME, __LINE__); \
		pthread_mutex_unlock(MUTEX_PTR); \
	}
#else /* HAVE_DEBUG_MUTEX */
	#define THREAD_MUTEX_LOCK(MUTEX_PTR, MUTEX_NAME) pthread_mutex_lock(MUTEX_PTR)
	#define THREAD_MUTEX_UNLOCK(MUTEX_PTR, MUTEX_NAME) pthread_mutex_unlock(MUTEX_PTR)
#endif /* HAVE_DEBUG_MUTEX */

#endif /* __SAT_SDK_LIB_DEBUG_H__ */
