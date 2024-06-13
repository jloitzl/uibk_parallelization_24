cmake_minimum_required(VERSION 3.10)

add_subdirectory(util)
add_subdirectory(setup)
add_subdirectory(solver)
add_subdirectory(IO)

add_library(mpi_stuff
    setup/mpi_handler.cpp
)

target_include_directories(mpi_stuff
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
    PUBLIC ${PROJECT_SOURCE_DIR}/include
    PUBLIC ${MPI_CXX_INCLUDE_PATH}
)

target_compile_definitions(mpi_stuff
    PUBLIC OMPI_SKIP_MPICXX
)

target_compile_options(mpi_stuff PRIVATE ${MPI_CXX_COMPILE_FLAGS})
