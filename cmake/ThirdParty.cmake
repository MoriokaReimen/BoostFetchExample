include_guard(DIRECTORY)
# include cmake modules
include(FetchContent)
include(${CMAKE_CURRENT_LIST_DIR}/Utility.cmake)

###########################################################################
# Fetch Boost
###########################################################################
set(BOOST_ENABLE_CMAKE ON)
FetchContent_Declare(Boost
  GIT_REPOSITORY https://github.com/boostorg/boost.git
  GIT_TAG        boost-1.81.0
  GIT_SHALLOW    ON
  QUIET          OFF
  GIT_PROGRESS   ON
  OVERRIDE_FIND_PACKAGE
)
FetchContent_MakeAvailable(Boost)
search_target(${boost_SOURCE_DIR} all_boost)
search_interface(${boost_SOURCE_DIR} all_boost_interface)

# remove libraries which is not builadable by default
list(REMOVE_ITEM all_boost "boost_accumulators")
list(REMOVE_ITEM all_boost "boost_python")
list(REMOVE_ITEM all_boost_interface "boost_accumulators")
list(REMOVE_ITEM all_boost_interface "boost_python")
list(REMOVE_ITEM all_boost_interface "boost_parameter_python")
list(REMOVE_ITEM all_boost_interface "boost_parameter_python")
list(REMOVE_ITEM all_boost_interface "boost_property_map_parallel")
list(REMOVE_ITEM all_boost_interface "boost_property_map_parallel")
list(REMOVE_ITEM all_boost_interface "boost_numpy")
list(REMOVE_ITEM all_boost_interface "boost_numpy")

# add Boost::Boost
add_library(boost INTERFACE)
add_library(Boost::Boost ALIAS boost)
target_link_libraries(boost INTERFACE ${all_boost})

# add Boost::Headers
add_library(boost_headers INTERFACE)
add_library(Boost::Headers ALIAS boost_headers)
target_link_libraries(boost_headers INTERFACE ${all_boost_interface})

###########################################################################
# Fetch CGAL
###########################################################################
FetchContent_Declare(CGAL
  URL https://github.com/CGAL/cgal/releases/download/v5.5.1/CGAL-5.5.1-library.zip 
  DOWNLOAD_EXTRACT_TIMESTAMP  ON
  OVERRIDE_FIND_PACKAGE
)
FetchContent_Populate(CGAL)
add_library(cgal INTERFACE)
add_library(CGAL::CGAL ALIAS cgal)
target_include_directories(cgal 
    INTERFACE ${cgal_SOURCE_DIR}/include)
target_link_libraries(cgal INTERFACE Boost::Boost Boost::Headers)
