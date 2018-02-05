
include(vcpkg_common_functions)

set(LIBGTA_VERSION 1.0.8)
set(LIBGTA_HASH 99ec3d6317c9a12cf440a60bb989cc7a3fe35e0a1da3e65206e5cd52b69fb860850e61ea0f819511ef48ddc87c468c0ded710409990627096738886e1b358423)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/libgta-${LIBGTA_VERSION})

vcpkg_download_distfile(ARCHIVE
    URLS "http://download.savannah.nongnu.org/releases/gta/libgta-1.0.8.tar.xz"
    FILENAME "libgta-${LIBGTA_VERSION}.tar.xz"
    SHA512 ${LIBGTA_HASH})

vcpkg_extract_source_archive(${ARCHIVE})

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" ENABLE_SHARED_LIBS)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  ENABLE_STATIC_LIBS)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DGTA_BUILD_SHARED_LIBS=${ENABLE_SHARED_LIBS}
            -DGTA_BUILD_STATIC_LIBS=${ENABLE_STATIC_LIBS}
            -DGTA_BUILD_DOCUMENTATION=OFF
)

vcpkg_build_cmake()
vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(COPY ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/libgta)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/libgta/COPYING ${CURRENT_PACKAGES_DIR}/share/libgta/copyright)
