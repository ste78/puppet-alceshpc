################################################################################
##
## Alces HPC Software Stack - Puppet configuration files
## Copyright (c) 2008-2014 Alces Software Ltd
##
################################################################################
class alceshpc (
  #Generic Alces variables
  #Supported profiles:
  # - generic
  $profile = hiera('alcesbase::profile','generic'),
  #Supported roles:
  # - slave
  # - master
  $role = hiera('alcesbase::role','slave'),
  #Supported machines
  # - generic
  $machine = hiera('alcesbase::machine','generic'),
  #Cluster name:
  $clustername = hiera('alcesbase::clustername','alcescluster'),
  #Master IP (network master IP addr)
  $master_ip = hiera('alcesbase::masterip'),
  #Master Alias (network master dns alias)
  $master_alias = hiera('alcesbase::masteralias'),
  #HA (ha enabled?)
  $ha = $alcesbase::ha,
  #Keep os jitter minimal
  $jitter=$alcesbase::jitter
)
{

  class { 'alceshpc::packages':
  }

  class { 'alceshpc::lustre':
    lustre=>hiera('alceshpc::lustre',false),
    lustrenetworks=>hiera('alceshpc::lustrenetworks',undef),
    lustretype=>hiera('alceshpc::lustretype','client'),
    lustreclient_mountpoint=>hiera('alceshpc::lustreclient_mountpoint','/mnt/lustre'),
    lustreclient_target=>hiera('alceshpc::lustreclient_target',undef)
  }

  class { 'alceshpc::limits':
  }

  class { 'alceshpc::scheduler':
    schedulertype=>hiera('alceshpc::schedulertype','gridscheduler'),
    schedulerrole=>hiera('alceshpc::schedulerrole','client'),
  }

}
