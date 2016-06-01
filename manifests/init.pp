#### Users Module ####
# All the parameters for this module are pulled from Hiera.
# It takes advantage of the common/environment/node logic that
# Hiera already does.
# 
####
#
# users::users: should be a hash
# The keys at this level of the hash should just be usernames. i.e:
# 
# users::users:
#   mkaminski:
#   kclaxton:
#   lreed:
#
####
#  
# The next level of hash should contain at least one of the following:
# 1) user, 
# 2) ssh,
# 3) sudo,
#
# All three of these keys are optional. 
# You can have any combination of them. i.e.
# 
# mkaminski:
#   user:
#   ssh:
#   sudo:
# kclaxton:
#   user:
#   sudo:
# lreed:
#   ssh:   
#
# Note: Order does not matter.
#
####
#
# User: You can pass any var that the User puppet resouces takes.
#
####
#
# Ssh: Needs any number of keys.
#
# Requiered vars:
#   1) keyname (the key of the hash at this level)
#   2) key (The actuall ssh key)
# Optional vars:
#   1) ensure:
#   2) keyType
#
#   By Default it ensures present and assumes the keyType is "rsa"
#  
# Each key name needs to be Unique. i.e:
#
# GOOD: 
#
# ssh:
#   key1:
#   key2:
#
# BAD:
#
# ssh:
#   key1:
#   key1:
#
# Keys will appear in /home/USERNAME/.ssh
# The file containing the key will appear as USERNAME-KEYTYPE-KEYNAME
#
####
#
# Sudo: Can set any number of hosts/allowed.
# It will set the allowed to all hosts. i.e:
#
# sudo:
#   hosts :
#     - "*comserv*"
#     - "*tas*"
#   allowed  :
#     - "/sbin/reboot"
#     - "/usr/bin/yum"
#
# This will set: USERNAME *comserv*, *tas* = /sbin/reboot, /usr/bin/yum
#
####
#
# Complete Sample Hiera:
#
# users::users:
#   mkaminski:
#      user:
#        ensure     : "present"
#        uid        : "16777243"
#        comment    : "Matan Kaminski"
#        managehome : true
#        password   : "PASSWORD HASH"
#      ssh:
#        key1:
#          keyType : "rsa"
#          key     : "SSH-KEY-1"
#        key2:
#          keyType : "rsa"
#          key     : "SSH-KEY-2"
#      sudo:
#        priority : "10"
#        hosts :
#          - "*comserv*"
#          - "*tas*"
#        allowed  :
#          - "/sbin/reboot"
#          - "/usr/bin/yum"
#
#############
#
# Author: Matan Kaminski
# Matan.kaminski@gmail.com
#

class enrichedusers() {
  # Can't just pass the var 
  # We want to do a merge between Common, Environment, and Node.
  $userArray=hiera_hash(enrichedusers::users)
  create_resources( enrichedusers::userparser, $userArray)

  $groupArray=hiera_hash(enrichedusers::groups)
  create_resources( enrichedusers::groupparser, $groupArray)

}

