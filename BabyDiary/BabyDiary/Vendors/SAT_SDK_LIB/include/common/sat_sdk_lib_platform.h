#ifndef __SAT_SDK_LIB_PLATFORM_H__
#define __SAT_SDK_LIB_PLATFORM_H__

#ifdef _WIN32

#include <winsock2.h>
typedef int socklen_t;

#define ERASE_MAP_ITERATOR(map_to_process, it) \
{\
	delete (it)->second; \
	(it) = (map_to_process).erase( (it) ); \
}

// disable warning C4290
#pragma warning( disable : 4290 )

#else

#include <arpa/inet.h>
#include <errno.h>
#include <netdb.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <unistd.h>
#include <netinet/tcp.h>
#include <netinet/in.h>
#include <libgen.h>

typedef int SOCKET;
#define INVALID_SOCKET (SOCKET)(~0)
#define SOCKET_ERROR (-1)

#define closesocket(sock) close(sock)
#define Sleep(x) usleep(x*1000)

#define ERASE_MAP_ITERATOR(map_to_process, it) \
{\
	delete (it)->second; \
	(map_to_process).erase( (it)++ ); \
}

#endif /* _WIN32 */

#endif /* __SAT_SDK_LIB_PLATFORM_H__ */
