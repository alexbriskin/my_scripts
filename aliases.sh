export ALIASES=$(readlink -f ${BASH_SOURCE[0]})
export MYSCRIPTS=$(dirname ${ALIASES})
export NETDIR=/mnt/cernd/_Users/AlexBr
alias lt='ls -l -t'
alias asu='sudo su'
alias tfx='tar xavf'
alias ggrep="grep -Irs --exclude={cscope.out,tags,*.svn*,*.o,*.o.cmd,*.ko} \
	--exclude={*.vtg,*.vpw,*.vpj,*.vpwhistu,*.tar,*.tar.*,*.siginfo} \
	--exclude={*.cproject,*cscope.files,*.js,*.html,*.svg,*.git,*.d} \
	--exclude-dir={/.svn/,git-svn,.svn,.git} \
	--exclude={*.objdump,*.dis,*.map}"
alias ngrep='ggrep -n'
alias igrep='ngrep -i'
alias slick='~developer/slickedit/bin/vs'
alias afind='find . -not -name "*.ko" -not -name "*.o" -not -iwholename "*.svn*" -not -iwholename "*.git*"'
alias cv='cp -v'


alias cd1='cd ..'
alias cd2='cd ../../'
alias cd3='cd ../../../'
alias cd4='cd ../../../../'
alias arm='rm -rvf'
alias touchall='find . -exec touch {} \;'
alias touchold='touch -a -m -t 201001010000.00'
alias arefresh="source $ALIASES"

#aliases for compilation
alias gc="gcc -std=c89 -pedantic -Wall -Werror"
alias ggc="gcc -std=c89 -pedantic -Wall" #gentle gc
alias g+="g++ -std=c++98 -pedantic -Wall -Werror"
alias gg+="g++ -std=c++98 -pedantic -Wall" #gentle g+

# related aliases
alias svmeld="svn diff --diff-cmd='meld'"
alias svrevert="svn revert --depth=infinity"
alias svst="svn st | grep -E '^.?[MAD]\s+'"
alias svls="svn ls"
#alias asvndiff='svn diff --diff-cmd diff --extensions \"-u -p\"'

svlog()
{
while read -r line ; do
	if echo "$line" | grep -q '^[-]\+$'; then
		read -r head
		read -r blank
		read -r subject

		if [ -n "$blank" -o -z "$head" -o -z "$head" ];then
			return 1
		fi

		sed 's#\(.*\) | \(.*\) | \([-0-9 :]\{16\}\).* % \(.*\)#\1 \2 (\3) \4#' \
			<<< "$head % $subject"
	else
		continue;
	fi
done< <(svn log "$@")
}

is_number()
{
	case $1 in
	''|*[!0-9]*) return 1 ;;
	    *) return 0 ;;
	esac
}

aprefix()
{
	if [ $# -lt 2 ]; then
		cat <<-EOF
		invalid namber of params [$@] please give:
			1. Prefix
			2. File to add a prefix to
		EOF
		return 1
	fi

	if [ ! -f ${2} -a ! -d ${2} ]; then
		echo file does not exist
		return 2
	fi

	local dir=$(realpath $(dirname $2))
	local file_name=$(basename $2)
	local prefix=$1

	mv ${dir}/{,$prefix}${file_name}
}

g_exclude_untracked()
{
	while read -r file ; do echo $file >> .git/info/exclude ;done < <(git ls-files --others --exclude-standard)
}

s2g_rev()
{
    if [ $# -lt 1 ]; then
		echo "invalid namber of params [$@] please give one valid SVN revision number"
		return 1
	fi
	git svn log --show-commit -r $1 --oneline | awk '{print $3}' 
}

g2s_rev()
{
    if [ $# -lt 1 ]; then
		echo "invalid namber of params [$@] please give one valid GIT revision number"
		return 1
	fi
    git svn log --show-commit --oneline | grep "$1" | awk '{print $1}' | sed -e s/^r//
}

gs_diff()
{
	if [ $# -lt 2 ]; then
		echo "invalid namber of params [$@] please give two valid revision numbers"
		return 1
	fi
	
	if ! is_number "$1" -o ! is_number "$2"; then
		return 2
	fi

	git diff $(s2g_rev "$1") $(s2g_rev "$2")
}

gs_foreach()
{
    COMMAND=${@-echo}
	for dir in $(gs_externals); do
        ([ -d $dir ] && (cd $dir && $COMMAND $dir))
	done
	return 0
}

gs_clone()
{
	[ $# -ge '1' ] && is_number ${1-NOT_numner} && revision=$1 || revision=28755
	while read -r line; do
		read directory url name <<< $line
		pushd $directory
		git svn clone ${url} $name -r$revision || return 2
		popd
	done< <(git svn show-externals | grep -vE '#|^$' | \
				sed 's/http:/ http:/g ; s/^\///g')
}

gs_checkout()
{
	local revision
	if [ $# -ge '1' ]; then
		if is_number ${1-NOT_numner}; then
			revision=$1
		else
			if [ ${1-NOT_master} = "master" ];then
				revision="master"

			else
				return 1
			fi
		fi
	else
		return 1
	fi

	while read -r line; do
		read directory url name <<< $line
		pushd $directory

		if [ $revision = "master" ];then
			git checkout master
			popd
			continue;
		fi

		while read -r LINE; do
			read current_revision <<< $LINE;
			if [ $current_revision -le $revision ];then
				local git_sha1=$(s2g_rev $current_revision)
				if git branch | grep -q $git_sha1;then
					git checkout $git_sha1
				else
					git checkout -b $git_sha1 $git_sha1
				fi
				break
			fi
		done < <(git svn log --show-commit --oneline  | awk '{print $1}' | sed -e s/^r//)
		popd
	done< <(git svn show-externals | grep -vE '#|^$' | \
		sed 's/http:/ http:/g ; s/^\///g')
}

gs_update()
{
	while read -r line; do 
		read directory url name <<< $line
		pushd ${directory}${name}
		git svn fetch && git svn rebase -l
		popd
	done< <(git svn show-externals | grep -vE '#|^$' | \
				sed 's/http:/ http:/g ; s/^\///g')
}

gs_set_excludes()
{
	while read -r line; do
		read directory url name <<< $line
		local full_dir=${directory}${name}/
		[ ! -d ./$full_dir ] && return 2
		if ! grep -q $full_dir ./.git/info/exclude ; then
			echo Adding $full_dir to exclude
			echo $full_dir >> ./.git/info/exclude
		else
			echo  $full_dir NOT added to excludes
		fi
	done< <(git svn show-externals | grep -vE '#|^$' | \
			sed 's/http:/ http:/g ; s/^\///g')
	return 0
}

a2400_svn_up_rev()
{
	if ! is_number "$1"; then
		return 1
	fi
	revision="$1"

	for dir in ${PWD}/*/; do 
		(cd $dir && a2400_svn_up_rev "$revision" && svn up -r $revision);
	done
}

ascan()
{
	DIR=${1-$PWD}
	INC_DIR=${2-$PWD}
	FILES="./.cscope.files"
	find $DIR -type f -name '*.c'> $FILES
	find $INC_DIR -type f -name '*.h' >> $FILES
	cscope -bqk -i $FILES
#	ctags -L $FILES
}


asr()
{
	if [ $# -lt 2 ]; then
		echo "invalid namber of params [$@] please give old_expression new_expression and where to search(optional)"
		return 666
	fi
	local where=${3-$PWD}
	igrep -lZ "$1" $where . | xargs -0 -l sed -i "s|$1|$2|g"
}

puma_load()
{
	IP=${IP-10.0.0.77}
	DEV=${DEV-/dev/ttyUSB0}   
	
	echo "tftp get $IP 0x900000 bzImage" | sudo tee $DEV
	echo "emmc wr_up 0x240000 0x900000 0x400000" | sudo tee $DEV
	sleep 2
	echo "tftp get $IP 0x900000 appcpuRootfs.img" | sudo tee $DEV
	echo "emmc wr_up 0xa40000 0x900000 0x1100000" | sudo tee $DEV
	sleep 2
	echo "settings" | sudo tee $DEV
}

ablame(){
if [ $# -ne 2 ] 
  then
	echo "Two Parameters required: 1. File (svn) path 2. Pattern for search"
  else
	svn blame "$1" | grep -n "$2"
fi
}

auth(){
	if [ $# -eq 0 ]
	  then
		echo "No argument supplied"
	fi
#make sure only root can run our script
	if [[ $EUID -ne 0 ]]; then
		echo "Need to be root"
	fi

	chmod 777 -R $1 && chown -R developer:users $1
}

tfc()
{
	if [ -z "$1" ]; then
		echo "No archive filename supplied"
	fi
	if [ -z "$2" ]; then
		echo "No destination Path supplied"
	fi
	if [ $# -eq 2 ]; then
		chown developer:users $1
		tfx $1 -C $2
	fi
}

addsuffix()
{
	if [ $# -ne 2 ]; then
		echo "Two Parameters required: 1. Directory Name 2. Required Suffix"
	else
		for filename in "$1"/*; do
			mv -v "$filename" "${filename}$2";
		done;
	fi
}

svdiff()
{
	if [ $# -lt 1 ]; then
		echo "Two Parameters required: 1. Old revision number 2. New revision number"
	else
		if [ $# -eq 1 ]; then
			svn diff --diff-cmd='meld' -r $1
		fi
		if [ $# -eq 2 ]; then
			svn diff --diff-cmd='meld' -r $1:$2
		fi
	fi
}

a2400_revert()
{
	for dir in . kernel/ce_atm_classifier kernel/ce_atm kernel/bp/net/mac80211/ce_wrs kernel/bp/net/mac80211/celeno_cb ; do
		(cd $dir && svn up -r $1)
	done
}

a2400_hp_create()
{
	SDK=${1-/puma6_sdk}
    PLATFORM=${2-PUMA6}
	IFS=":" ; set -- $(svn info | grep "Revision" | sed 's/ //g')
	REVISION=$2
	POSTFIX=_revision_${REVISION}_ver_0
	CELENO_HP_NAME=${REVISION}_${PLATFORM}_HP
	rm -rvf SOURCE_CODE_celeno_clr_package* && ./make_CL2400_release.sh $PLATFORM

	mkdir -p $CELENO_HP_NAME && tar xfz SOURCE_CODE_celeno_clr_package* --strip-components=1 -C $CELENO_HP_NAME && \
	mv {,${REVISION}_${PLATFORM}_}SOURCE_CODE_celeno_clr_package*  && \
	cd $CELENO_HP_NAME
	IFS='=' && \
	set -- $(grep "export CONFIG_HOST_CL_VER" src/celeno.mk) && \
	sed -i "s/export CONFIG_HOST_CL_VER = .*/export CONFIG_HOST_CL_VER = $2$POSTFIX/g" src/celeno.mk
	sed -i "s|DEF_SDK_PATH =.*|DEF_SDK_PATH = $SDK|g" src/celeno.mk
#VERS=AAAA ; IFS='='; set -- $(grep CONFIG_HOST_CL_VER src/celeno.mk) ; grep CONFIG_HOST_CL_VER src/celeno.mk | sed "s/export CONFIG_HOST_CL_VER = .*/export CONFIG_HOST_CL_VER = $2_$VERS/g"
}

a2400_image()
{
	[ -L ./build ] && (echo symbolic link && rm ./build) || echo real directory
	rm ./build/* -rvf
	FILE=src/celeno.mk

	if [ ! -f ${FILE} ];then
		echo check celeno.mk location
		exit 1
	fi

	str=$(grep   "DEF_SDK_PATH = " src/celeno.mk)
	SDK=$(echo ${str##*=})

	sudo make && sudo chown -R developer:developer . &&\
		pushd ${SDK} && ./build-atom.sh && \
		cp -v binaries/IntelCE/bzImage /tftpboot/ && \
		cp -v binaries/IntelCE/appcpuRootfs.img /tftpboot/ && popd && echo FINISHED
}

a2400_nfs()
{
	DEST=${1-~/work/nfs}
	rm $DEST/* ./build/* -rvf
	sudo make && sudo chown -R developer:developer . &&\
		cp -R ./build/* $DEST/ && echo FINISHED
}

a2400_web()
{
	DEST=${1-/2400cgiweb}
	SRC=${2-./build/PUMA6/project_build_i686/IntelCE/cgiweb-1.0.6/filesystem/www}
	#sudo rm $DEST/* $SRC/* -rvf
	#sudo chown -R developer:users $DEST && 
	sudo make CL2400 && sudo cp -R $SRC/ $DEST/ &&\
		sudo cp -R ./platformdb/CL2400/filesystem/etc/init.d/httpd_init $DEST/www/ && \
		sudo cp -R ./platformdb/CL2400/filesystem/bin/ce_air_history.sh $DEST/www/ &&\
	echo FINISHED
}

header_create()
{
	[ $# -eq 2 -a -d $2 ] && \
		path="${2}/" || \
		path=""

	cat <<-EOF>> ${path}$1.h
	/*Created on: " $(date +'%d/%m/%Y')"
		Author: Alex
		Reviewed by:
		Rejects:
	*/
	#ifndef __${1^^}_H__
	#define __${1^^}_H__

	#endif /* __${1^^}_H__ */
	EOF
}

export find_exclude='-not -name "*.svn*" -not -name "*.ko" -not -name "*.o" -not -iwholename "*.svn*" -not -iwholename "*.git*"'
ctest_file()
{
	cat <<-EOF>> $1
	/*Created on: " $(date +'%d/%m/%Y')"
		Author: Alex
		Reviewed by:
		Rejects:
	*/
	#include <stdio.h>

	int main( int argc , char ** argv, char ** env)
	{
			return 0;
	}
	EOF
}

chdir()
{
	[ $# -eq 1 ] && mkdir -p ${1} && pushd ${1}
}

echo Hello, Alex
