function(init_lfs_s3 bucket repo branch)
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${repo}")
        message(STATUS "Repository ${repo} already exists; skipping git-lfs-s3 initialization")
    else()
        message(STATUS "Repository ${repo} does not exist; initializing git-lfs-s3")
        execute_process(
            COMMAND git clone s3://${bucket}
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
            ERROR_QUIET
        )
        execute_process(
            COMMAND git-lfs-s3 install
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/${repo}"
        )
        execute_process(
            COMMAND git reset --hard ${branch}
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/${repo}"
        )
    endif()
endfunction()