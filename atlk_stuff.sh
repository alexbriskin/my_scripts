#!/bin/bash
export PATH=$PATH:/tools/yocto/sw/bin

atlk_header_create()
{
	[ $# -eq 2 -a -d $2 ] && \
		path="${2}/" || \
		path=""

	cat <<-EOF>> ${path}$1.h
	/* Copyright (C) $(date +'%Y') Autotalks Ltd. */

	#ifndef _${1^^}_H
	#define _${1^^}_H

	#ifdef __cplusplus
	extern "C" {
	#endif

	/**
	   @file
	   File description
	*/

	#ifdef __cplusplus
	}
	#endif

	#endif /* _${1^^}_H */
	EOF
}
