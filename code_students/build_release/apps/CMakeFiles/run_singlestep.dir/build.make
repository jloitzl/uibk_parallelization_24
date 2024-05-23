# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/cb76/cb761160/uibk_parallelization_24/code_students

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release

# Include any dependencies generated for this target.
include apps/CMakeFiles/run_singlestep.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include apps/CMakeFiles/run_singlestep.dir/compiler_depend.make

# Include the progress variables for this target.
include apps/CMakeFiles/run_singlestep.dir/progress.make

# Include the compile flags for this target's objects.
include apps/CMakeFiles/run_singlestep.dir/flags.make

apps/CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o: apps/CMakeFiles/run_singlestep.dir/flags.make
apps/CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o: ../apps/main_test_singlesteps.cpp
apps/CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o: apps/CMakeFiles/run_singlestep.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object apps/CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o"
	cd /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/apps && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT apps/CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o -MF CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o.d -o CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o -c /home/cb76/cb761160/uibk_parallelization_24/code_students/apps/main_test_singlesteps.cpp

apps/CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.i"
	cd /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/apps && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/cb76/cb761160/uibk_parallelization_24/code_students/apps/main_test_singlesteps.cpp > CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.i

apps/CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.s"
	cd /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/apps && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/cb76/cb761160/uibk_parallelization_24/code_students/apps/main_test_singlesteps.cpp -o CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.s

# Object files for target run_singlestep
run_singlestep_OBJECTS = \
"CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o"

# External object files for target run_singlestep
run_singlestep_EXTERNAL_OBJECTS =

apps/run_singlestep: apps/CMakeFiles/run_singlestep.dir/main_test_singlesteps.cpp.o
apps/run_singlestep: apps/CMakeFiles/run_singlestep.dir/build.make
apps/run_singlestep: src/util/libutilities.a
apps/run_singlestep: src/setup/libsim_setup.a
apps/run_singlestep: src/solver/libsolver.a
apps/run_singlestep: src/IO/libIO.a
apps/run_singlestep: src/util/libutilities.a
apps/run_singlestep: src/setup/libsim_setup.a
apps/run_singlestep: /usr/lib64/libhdf5.so
apps/run_singlestep: apps/CMakeFiles/run_singlestep.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable run_singlestep"
	cd /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/apps && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/run_singlestep.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
apps/CMakeFiles/run_singlestep.dir/build: apps/run_singlestep
.PHONY : apps/CMakeFiles/run_singlestep.dir/build

apps/CMakeFiles/run_singlestep.dir/clean:
	cd /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/apps && $(CMAKE_COMMAND) -P CMakeFiles/run_singlestep.dir/cmake_clean.cmake
.PHONY : apps/CMakeFiles/run_singlestep.dir/clean

apps/CMakeFiles/run_singlestep.dir/depend:
	cd /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/cb76/cb761160/uibk_parallelization_24/code_students /home/cb76/cb761160/uibk_parallelization_24/code_students/apps /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/apps /home/cb76/cb761160/uibk_parallelization_24/code_students/build_release/apps/CMakeFiles/run_singlestep.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : apps/CMakeFiles/run_singlestep.dir/depend
