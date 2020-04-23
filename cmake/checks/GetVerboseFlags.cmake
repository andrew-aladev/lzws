function (cmake_get_verbose_flags)
  if (DEFINED CMAKE_GET_VERBOSE_FLAGS_PROCESSED)
    return ()
  endif ()

  set (CMAKE_VERBOSE_C_FLAGS "")

  set (BINARY_DIR "${PROJECT_BINARY_DIR}/CMakeTmp/check_basic")
  set (SOURCE_DIR "${PROJECT_SOURCE_DIR}/cmake/checks/basic")
  set (NAME "cmake_get_verbose_flags")

  # -- Werror --

  set (MESSAGE_PREFIX "Status of -Werror support")

  try_compile (
    CHECK_RESULT ${BINARY_DIR} ${SOURCE_DIR} ${NAME}
    CMAKE_FLAGS
      "-DCMAKE_C_FLAGS=-Werror"
      "-DCMAKE_VERBOSE_MAKEFILE=${CMAKE_VERBOSE_MAKEFILE}"
    OUTPUT_VARIABLE CHECK_OUTPUT
  )
  if (CMAKE_VERBOSE_MAKEFILE)
    message (STATUS ${CHECK_OUTPUT})
  endif ()
  FILE (REMOVE_RECURSE ${BINARY_DIR})

  if (CHECK_RESULT)
    set (CMAKE_WERROR_C_FLAGS "-Werror" CACHE STRING "Werror C flags")
    message (STATUS "${MESSAGE_PREFIX} - yes")
  else ()
    set (CMAKE_WERROR_C_FLAGS "" CACHE STRING "Werror C flags")
    message (STATUS "${MESSAGE_PREFIX} - no")
  endif ()

  # -- pedantic --

  set (MESSAGE_PREFIX "Status of -pedantic support")

  try_compile (
    CHECK_RESULT ${BINARY_DIR} ${SOURCE_DIR} ${NAME}
    CMAKE_FLAGS
      "-DCMAKE_C_FLAGS=${CMAKE_WERROR_C_FLAGS} -pedantic"
      "-DCMAKE_VERBOSE_MAKEFILE=${CMAKE_VERBOSE_MAKEFILE}"
    OUTPUT_VARIABLE CHECK_OUTPUT
  )
  if (CMAKE_VERBOSE_MAKEFILE)
    message (STATUS ${CHECK_OUTPUT})
  endif ()
  FILE (REMOVE_RECURSE ${BINARY_DIR})

  if (CHECK_RESULT)
    set (CMAKE_VERBOSE_C_FLAGS "${CMAKE_VERBOSE_C_FLAGS} -pedantic")
    message (STATUS "${MESSAGE_PREFIX} - yes")
  else ()
    message (STATUS "${MESSAGE_PREFIX} - no")
  endif ()

  # -- Wall --

  set (MESSAGE_PREFIX "Status of -Wall support")

  try_compile (
    CHECK_RESULT ${BINARY_DIR} ${SOURCE_DIR} ${NAME}
    CMAKE_FLAGS
      "-DCMAKE_C_FLAGS=${CMAKE_WERROR_C_FLAGS} -Wall"
      "-DCMAKE_VERBOSE_MAKEFILE=${CMAKE_VERBOSE_MAKEFILE}"
    OUTPUT_VARIABLE CHECK_OUTPUT
  )
  if (CMAKE_VERBOSE_MAKEFILE)
    message (STATUS ${CHECK_OUTPUT})
  endif ()
  FILE (REMOVE_RECURSE ${BINARY_DIR})

  if (CHECK_RESULT)
    set (CMAKE_VERBOSE_C_FLAGS "${CMAKE_VERBOSE_C_FLAGS} -Wall")
    message (STATUS "${MESSAGE_PREFIX} - yes")
  else ()
    message (STATUS "${MESSAGE_PREFIX} - no")
  endif ()

  # -- Wextra --

  set (MESSAGE_PREFIX "Status of -Wextra support")

  try_compile (
    CHECK_RESULT ${BINARY_DIR} ${SOURCE_DIR} ${NAME}
    CMAKE_FLAGS
      "-DCMAKE_C_FLAGS=${CMAKE_WERROR_C_FLAGS} -Wextra"
      "-DCMAKE_VERBOSE_MAKEFILE=${CMAKE_VERBOSE_MAKEFILE}"
    OUTPUT_VARIABLE CHECK_OUTPUT
  )
  if (CMAKE_VERBOSE_MAKEFILE)
    message (STATUS ${CHECK_OUTPUT})
  endif ()
  FILE (REMOVE_RECURSE ${BINARY_DIR})

  if (CHECK_RESULT)
    set (CMAKE_VERBOSE_C_FLAGS "${CMAKE_VERBOSE_C_FLAGS} -Wextra")
    message (STATUS "${MESSAGE_PREFIX} - yes")
  else ()
    message (STATUS "${MESSAGE_PREFIX} - no")
  endif ()

  set (CMAKE_VERBOSE_C_FLAGS ${CMAKE_VERBOSE_C_FLAGS} CACHE STRING "Verbose C flags")
  set (CMAKE_GET_VERBOSE_FLAGS_PROCESSED true CACHE STRING "Verbose flags processed")

  mark_as_advanced (CMAKE_VERBOSE_C_FLAGS CMAKE_GET_VERBOSE_FLAGS_PROCESSED)
endfunction ()
