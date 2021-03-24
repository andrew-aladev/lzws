set (CURRENT_LIST_DIR ${CMAKE_CURRENT_LIST_DIR})

function (cmake_test_ipo)
  set (NAME "cmake_test_ipo")
  set (SOURCE_DIR "${CURRENT_LIST_DIR}/IPO")
  set (BINARY_DIR "${PROJECT_BINARY_DIR}/test_ipo")

  include (GetVerboseFlags)
  cmake_get_verbose_flags ()

  include (CheckC17)
  cmake_check_c17 ()

  include (CheckRunnable)
  cmake_check_runnable ()

  try_compile (
    TEST_RESULT ${BINARY_DIR} ${SOURCE_DIR} ${NAME}
    CMAKE_FLAGS
      "-DCMAKE_C_FLAGS=${CMAKE_VERBOSE_C_FLAGS} ${CMAKE_C17_C_FLAGS}"
      "-DCMAKE_VERBOSE_MAKEFILE=${CMAKE_VERBOSE_MAKEFILE}"
      "-DCMAKE_TRY_RUN=${CMAKE_CAN_RUN_EXE}"
    OUTPUT_VARIABLE TEST_OUTPUT
  )
  file (REMOVE_RECURSE ${BINARY_DIR})

  if (CMAKE_VERBOSE_MAKEFILE)
    message (STATUS ${TEST_OUTPUT})
  endif ()

  set (TEST_RESULT ${TEST_RESULT} PARENT_SCOPE)
endfunction ()

function (cmake_check_ipo)
  if (DEFINED CMAKE_INTERPROCEDURAL_OPTIMIZATION)
    return ()
  endif ()

  include (CheckIPOSupported)
  check_ipo_supported (RESULT CHECK_RESULT OUTPUT CHECK_OUTPUT)

  if (CMAKE_VERBOSE_MAKEFILE)
    message (STATUS ${CHECK_OUTPUT})
  endif ()

  set (MESSAGE_PREFIX "Status of IPO support")

  if (CHECK_RESULT)
    cmake_test_ipo ()

    if (TEST_RESULT)
      set (CMAKE_INTERPROCEDURAL_OPTIMIZATION true)
      message (STATUS "${MESSAGE_PREFIX} - working")
    else ()
      set (CMAKE_INTERPROCEDURAL_OPTIMIZATION false)
      message (STATUS "${MESSAGE_PREFIX} - not working")
    endif ()

  else ()
    set (CMAKE_INTERPROCEDURAL_OPTIMIZATION false)
    message (STATUS "${MESSAGE_PREFIX} - not working")
  endif ()

  set (
    CMAKE_INTERPROCEDURAL_OPTIMIZATION
    ${CMAKE_INTERPROCEDURAL_OPTIMIZATION}
    CACHE BOOL "Status of IPO"
  )

  mark_as_advanced (CMAKE_INTERPROCEDURAL_OPTIMIZATION)
endfunction ()
