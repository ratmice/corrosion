set(CORROSION_DIR ${CMAKE_ARGV3})
set(TEST_SOURCE_DIR ${CMAKE_ARGV4})
set(TEST_SCRIPT_DIR ${CMAKE_ARGV5})
set(CORROSION_INSTALL ${CMAKE_ARGV6})

# Remove stale test directory
file(REMOVE_RECURSE ${TEST_SCRIPT_DIR})

# Make fresh directory
file(MAKE_DIRECTORY ${TEST_SCRIPT_DIR})

if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
    set(CE COMMAND_ECHO STDOUT)
endif()

execute_process(
    COMMAND
        ${CMAKE_COMMAND} -E env CMAKE_PREFIX_PATH=${CORROSION_INSTALL}
        ${CMAKE_COMMAND} -P ${TEST_SOURCE_DIR}/${TEST_SCRIPT_DIR}/Test.cmake
            ${CORROSION_DIR} ${CORROSION_INSTALL}
    ${CE}
    WORKING_DIRECTORY ${TEST_SCRIPT_DIR}
    RESULT_VARIABLE SUCCESS
)

if (NOT SUCCESS EQUAL "0")
    message(FATAL_ERROR)
endif()