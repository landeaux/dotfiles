#!/usr/bin/env bash

find . -name '*.lua' | xargs -I piped_arguments lua-format piped_arguments -i \
	--column-limit=100 \
	--no-keep-simple-function-one-line \
	--break-after-table-lb \
	--break-before-table-rb \
	--break-after-functiondef-lp \
	--break-before-functiondef-rp \
	--break-after-functioncall-lp \
	--break-before-functioncall-rp \
	--chop-down-parameter \
	--chop-down-table \
	--chop-down-kv-table
