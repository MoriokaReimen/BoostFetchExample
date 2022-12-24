cmake_minimum_required(VERSION 3.20...3.23)
project(BoostFetchExample CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/ThirdParty.cmake)

file(GLOB SRC ${CMAKE_CURRENT_LIST_DIR}/src/*.cpp)
add_executable(sample ${SRC})
target_link_libraries(sample CGAL::CGAL)
