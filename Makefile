export MAJOR  := 2
export MINOR  := 9
export BUGFIX := 0
export API    := 1

export VERSION_STR := "$(MAJOR).$(MINOR).$(BUGFIX)"
#
# Gets the sha-1 hash (hex encoded string) of our build)
#
export GIT_DESCRIPTION := "\"$(shell git describe --dirty)\""

#
# Build types:
#
# * RELEASE_TYPE_DEVEL    - (Default) Build from a dev machine.
# * RELEASE_TYPE_OFFICIAL - Official build from our build server.
#                           Implies a tag is associated with this
#                           release.
# * RELEASE_TYPE_BETA     - A beta release.  One designed for user
#                           testing, but has no official support.
#
RELEASE_TYPE := RELEASE_TYPE_DEVEL
OFFICIAL_TAG := $(if $(shell ./bin/get_official_tag.sh), yes)
ifeq ($(RELEASE),BETA)
    RELEASE_TYPE := RELEASE_TYPE_BETA
endif
ifneq ($(OFFICIAL_TAG),)
    RELEASE_TYPE := RELEASE_TYPE_OFFICIAL
endif
export RELEASE_TYPE

export VERSION_CFLAGS := \
-DAPI_REV=$(API) \
-DMAJOR_REV=$(MAJOR) \
-DMINOR_REV=$(MINOR) \
-DBUGFIX_REV=$(BUGFIX) \
-DRC_BUILD_GIT_DESCRIPTION=$(GIT_DESCRIPTION) \
-DRC_BUILD_RELEASE_TYPE=$(RELEASE_TYPE) \

Q := @
PHONY :=

# Default target is all.
all: package

#
# Testing bits.
#
TEST_DIR := test
PHONY += test-run
test-run: test-build
	$(MAKE) -C $(TEST_DIR) test-run

PHONY += test-build
test-build:
	$(MAKE) -C $(TEST_DIR) all

PHONY += test-clean
test-clean:
	$(MAKE) -C $(TEST_DIR) clean

PHONY += test-pristine
test-pristine: test-clean
	$(MAKE) test-run

PHONY += test
test: test-run


#
# Lua Bits
#
LUA_DIR := lib_lua
PHONY += lua-build
lua-build:
	$(MAKE) -C $(LUA_DIR) PLAT=stm32 generic

PHONY += lua-clean
lua-clean:
	$(MAKE) -C $(LUA_DIR) PLAT=stm32 clean

PHONY += lua-pristine
lua-pristine: lua-clean
	$(MAKE) lua-build


#
# MK2
#
MK2_DIR := stm32_base
PHONY += mk2-build
mk2-build: lua-build
	$(MAKE) -C $(MK2_DIR) all

PHONY += mk2-clean
mk2-clean:
	$(MAKE) -C $(MK2_DIR) clean

PHONY += mk2-pristine
mk2-pristine: lua-pristine mk2-clean
	$(MAKE) mk2-build

PHONY += mk2-package
mk2-package: mk2-pristine
	./bin/package_release.sh MK2 $(VERSION_STR) $(MK2_DIR)


#
# RCT
#
RCT_DIR := RCT
PHONY += rct-build
rct-build: lua-build
	$(MAKE) -C $(RCT_DIR) all

PHONY += rct-clean
rct-clean:
	$(MAKE) -C $(RCT_DIR) clean

PHONY += rct-pristine
rct-pristine: lua-pristine rct-clean
	$(MAKE) rct-build

PHONY += rct-package
rct-package: rct-pristine
# NO-OP just yet.
#	./bin/package_release.sh RCT $(VERSION_STR) $(RCT_DIR)


#
# Common targets.
#
PHONY += clean
clean:
	$(Q)find . -type f \
	-name "*.d"   -o \
	-name "*.lst" -o \
	-name "*.o"      \
	| xargs rm -f

package: test-pristine
	$(MAKE) mk2-package
	$(MAKE) rct-package

PHONY += TAGS
TAGS:
	$(Q)find . -type f -regex '.*\.\(c\|cpp\|h\|hh\)$$' | etags -

.PHONY: $(PHONY)
