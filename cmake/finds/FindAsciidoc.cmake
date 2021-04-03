if (DEFINED CMAKE_ASCIIDOC_FOUND)
  return ()
endif ()

find_program (CMAKE_ASCIIDOC_BINARY asciidoc)
find_program (CMAKE_ASCIIDOC_A2X_BINARY a2x)

set (MESSAGE_PREFIX "Status of Asciidoc")

message (STATUS "${MESSAGE_PREFIX} - main binary path is ${CMAKE_ASCIIDOC_BINARY}")
message (STATUS "${MESSAGE_PREFIX} - a2x binary path is ${CMAKE_ASCIIDOC_A2X_BINARY}")

if (CMAKE_ASCIIDOC_BINARY AND CMAKE_ASCIIDOC_A2X_BINARY)
  set (CMAKE_ASCIIDOC_FOUND true)
else ()
  set (CMAKE_ASCIIDOC_FOUND false)
endif ()

set (
  CMAKE_ASCIIDOC_FOUND ${CMAKE_ASCIIDOC_FOUND}
  CACHE BOOL "Asciidoc found"
)

mark_as_advanced (
  CMAKE_ASCIIDOC_FOUND
  CMAKE_ASCIIDOC_BINARY
  CMAKE_ASCIIDOC_A2X_BINARY
)

if (NOT CMAKE_ASCIIDOC_FOUND AND Asciidoc_FIND_REQUIRED)
  message (FATAL_ERROR "${MESSAGE_PREFIX} - is required")
endif ()
