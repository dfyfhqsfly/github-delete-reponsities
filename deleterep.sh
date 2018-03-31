# Copyright 2018 dfyfhqsfly@gmail.com.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

__ScriptVersion="version1.0"
_FileKey=file
_UserKey=user
_PwdKey=password

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
  echo "Usage :  $0 [options] [--]

    Options:
    -h|help         Display this message
    -v|version      Display script version
    -f|file         File stores response name in github to be delete
    -u|user         Name for github
    -c|credentials  Credentials for github \"username:password\""
}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

function main() 
{
  if [ $# -eq 0 ]
  then
    usage;
    exit 1
  fi

  declare -A arguments
  arguments[${_FileKey}]=""
  arguments[${_UserKey}]=""
  
  while getopts ":hvf:u:p:" opt
  do
    case $opt in
  
    h|help     )  usage; exit 0   ;;
  
    v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;
  
    f|file ) arguments[${_FileKey}]=$OPTARG ;;
    u|user ) arguments[${_UserKey}]=$OPTARG ;;
    p|password ) arguments[${_PwdKey}]=$OPTARG ;;
    ? ) echo -e "\n Option error: $OPTARG\n"
      usage; exit 1 ;;
  
    * )  echo -e "\n  Option does not exist : $OPTARG\n"
        usage; exit 1   ;;
  
    esac    # --- end of case ---
  done

  # check for no set
  for key in ${!arguments[*]};do
    if [ -z ${arguments[$key]} ];then
      echo -e "\n Option does not set : $key\n"
      usage; exit 1
    fi
  done

  while read line
  do
    echo $line
    DeleteResp $line ${arguments[${_UserKey}]} ${arguments[${_PwdKey}]}

  done < ${arguments[${_FileKey}]}
}

function DeleteResp() 
{
  resp=$1
  user=$2
  authorize=$3
  command=$(echo curl -X DELETE https://api.github.com/repos/${user}/$resp -u \"$authorize\")
  curl -X DELETE https://api.github.com/repos/${user}/$resp -u "$authorize"
  #eval $command
}

main $@


