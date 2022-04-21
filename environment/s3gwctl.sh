#!/bin/sh

set -e

export IMAGE_NAME=${IMAGE_NAME:-"generic/ubuntu2004"}
export VM_NET=${VM_NET:-"10.46.201.0"}
export VM_NET_LAST_OCTET_START=${CLUSTER_NET_LAST_OCTET_START:-"101"}
export CIDR_NET=${CIDR_NET:-"172.22.0.0"}
export WORKER_COUNT=${WORKER_COUNT:-"1"}
export ADMIN_MEM=${ADMIN_MEM:-"4096"}
export ADMIN_CPU=${ADMIN_CPU:-"2"}
export ADMIN_DISK_SIZE=${ADMIN_DISK_SIZE:-"8G"}
export WORKER_MEM=${WORKER_MEM:-"4096"}
export WORKER_CPU=${WORKER_CPU:-"2"}
export WORKER_DISK_SIZE=${WORKER_DISK_SIZE:-"8G"}

build_env() {
  echo "Building environment ..."
  echo "IMAGE_NAME=${IMAGE_NAME}"
  echo "VM_NET=${VM_NET}"
  echo "VM_NET_LAST_OCTET_START=${VM_NET_LAST_OCTET_START}"
  echo "CIDR_NET=${CIDR_NET}"
  echo "WORKER_COUNT=${WORKER_COUNT}"
  echo "ADMIN_MEM=${ADMIN_MEM}"
  echo "ADMIN_CPU=${ADMIN_CPU}" 
  echo "ADMIN_DISK_SIZE=${ADMIN_DISK_SIZE}"
  echo "WORKER_MEM=${WORKER_MEM}"
  echo "WORKER_CPU=${WORKER_CPU}"
  echo "WORKER_DISK_SIZE=${WORKER_DISK_SIZE}" 

  vagrant up
}

destroy_env() {
  echo "Destroying environment ..."
  echo "WORKER_COUNT=${WORKER_COUNT}"
   
  vagrant destroy -f
}

ssh_vm() {
  echo "Connecting to $1 ..."
  echo "WORKER_COUNT=${WORKER_COUNT}"

  vagrant ssh $1
}

if [ $# -eq 0 ]; then
  build_env
elif [ $# -eq 1 ]; then
  case $1 in
    build)
      build_env
      break
      ;;
    destroy)
      destroy_env
      break
      ;;
  esac
else
  case $1 in
    ssh)
      ssh_vm $2
      break
      ;;
  esac
fi

exit 0
