data "vsphere_datacenter" "horizon_vdi_datacenter" {
  name = var.horizon_vdi_datacenter
}

data "vsphere_compute_cluster" "horizon_vdi_compute_cluster" {
  name = var.horizon_vdi_compute_cluster
  datacenter_id = data.vsphere_datacenter.horizon_vdi_datacenter.id
}

data "vsphere_resource_pool" "horizon_vdi_resource_pool" {
  name          = "vdi"
  datacenter_id = data.vsphere_datacenter.horizon_vdi_datacenter.id
}

data "vsphere_folder" "horizon_vdi_folder" {
  path = var.horizon_vdi_folder
}

data "vsphere_network" "horizon_vdi_network" {
  name          = var.horizon_vdi_network
  datacenter_id = data.vsphere_datacenter.horizon_vdi_datacenter.id
}

data "vsphere_datastore" "horizon_vdi_datastore" {
  name          = var.horizon_vdi_datastore
  datacenter_id = data.vsphere_datacenter.horizon_vdi_datacenter.id
}

resource "vsphere_role" "horizon_role_instant_clone" {
  name = "Omnissa Horizon - Instant Clones"
  role_privileges = ["Alarm.ToggleEnableOnEntity", "Cryptographer.Access", "Cryptographer.Clone", "Cryptographer.Decrypt", "Cryptographer.Encrypt", "Cryptographer.ManageKeyServers", "Cryptographer.Migrate", "Cryptographer.RegisterHost", "Datastore.AllocateSpace", "Datastore.Browse", "Folder.Create", "Folder.Delete", "Global.DisableMethods", "Global.EnableMethods", "Global.ManageCustomFields", "Global.SetCustomField", "Global.VCServer", "Host.Config.AdvancedConfig", "Host.Inventory.EditCluster", "InventoryService.Tagging.AttachTag", "InventoryService.Tagging.CreateCategory", "InventoryService.Tagging.CreateTag", "InventoryService.Tagging.DeleteCategory", "InventoryService.Tagging.DeleteTag", "InventoryService.Tagging.ObjectAttachable", "Network.Assign", "Resource.AssignVMToPool", "StorageProfile.Update", "StorageProfile.View", "System.Anonymous", "System.Read", "System.View", "VirtualMachine.Config.AddExistingDisk", "VirtualMachine.Config.AddNewDisk", "VirtualMachine.Config.AddRemoveDevice", "VirtualMachine.Config.AdvancedConfig", "VirtualMachine.Config.Annotation", "VirtualMachine.Config.CPUCount", "VirtualMachine.Config.ChangeTracking", "VirtualMachine.Config.DiskExtend", "VirtualMachine.Config.DiskLease", "VirtualMachine.Config.EditDevice", "VirtualMachine.Config.HostUSBDevice", "VirtualMachine.Config.ManagedBy", "VirtualMachine.Config.Memory", "VirtualMachine.Config.MksControl", "VirtualMachine.Config.QueryFTCompatibility", "VirtualMachine.Config.QueryUnownedFiles", "VirtualMachine.Config.RawDevice", "VirtualMachine.Config.ReloadFromPath", "VirtualMachine.Config.RemoveDisk", "VirtualMachine.Config.Rename", "VirtualMachine.Config.ResetGuestInfo", "VirtualMachine.Config.Resource", "VirtualMachine.Config.Settings", "VirtualMachine.Config.SwapPlacement", "VirtualMachine.Config.ToggleForkParent", "VirtualMachine.Config.UpgradeVirtualHardware", "VirtualMachine.Interact.DeviceConnection", "VirtualMachine.Interact.PowerOff", "VirtualMachine.Interact.PowerOn", "VirtualMachine.Interact.Reset", "VirtualMachine.Interact.SESparseMaintenance", "VirtualMachine.Interact.Suspend", "VirtualMachine.Inventory.Create", "VirtualMachine.Inventory.CreateFromExisting", "VirtualMachine.Inventory.Delete", "VirtualMachine.Inventory.Move", "VirtualMachine.Inventory.Register", "VirtualMachine.Inventory.Unregister", "VirtualMachine.Provisioning.Clone", "VirtualMachine.Provisioning.CloneTemplate", "VirtualMachine.Provisioning.Customize", "VirtualMachine.Provisioning.DeployTemplate", "VirtualMachine.Provisioning.DiskRandomAccess", "VirtualMachine.Provisioning.PromoteDisks", "VirtualMachine.Provisioning.ReadCustSpecs", "VirtualMachine.State.CreateSnapshot", "VirtualMachine.State.RemoveSnapshot", "VirtualMachine.State.RenameSnapshot", "VirtualMachine.State.RevertToSnapshot"]
}

resource "vsphere_role" "horizon_role_without_instant_clone" {
  name = "Omnissa Horizon - Without Instant Clones"
  role_privileges = ["Cryptographer.Access", "Cryptographer.Clone", "Cryptographer.Decrypt", "Cryptographer.Encrypt", "Cryptographer.ManageKeyServers", "Cryptographer.Migrate", "Cryptographer.RegisterHost", "Datastore.AllocateSpace", "Folder.Create", "Folder.Delete", "Global.VCServer", "Host.Config.AdvancedConfig", "Resource.AssignVMToPool", "System.Anonymous", "System.Read", "System.View", "VirtualMachine.Config.AddRemoveDevice", "VirtualMachine.Config.AdvancedConfig", "VirtualMachine.Config.EditDevice", "VirtualMachine.Interact.PowerOff", "VirtualMachine.Interact.PowerOn", "VirtualMachine.Interact.Reset", "VirtualMachine.Interact.SESparseMaintenance", "VirtualMachine.Interact.Suspend", "VirtualMachine.Inventory.Create", "VirtualMachine.Inventory.CreateFromExisting", "VirtualMachine.Inventory.Delete", "VirtualMachine.Provisioning.Clone", "VirtualMachine.Provisioning.CloneTemplate", "VirtualMachine.Provisioning.Customize", "VirtualMachine.Provisioning.DeployTemplate", "VirtualMachine.Provisioning.ReadCustSpecs"]
}

resource "vsphere_entity_permissions" "horizon_vdi_compute_cluster" {
  entity_id = data.vsphere_compute_cluster.horizon_vdi_compute_cluster.id
  entity_type = "ClusterComputeResource"
  permissions {
    user_or_group = var.horizon_serviceaccount_instant_clone
    propagate = true
    is_group = false
    role_id = vsphere_role.horizon_role_instant_clone.id
  }
}

resource "vsphere_entity_permissions" "horizon_vdi_folder" {
  entity_id = data.vsphere_folder.horizon_vdi_folder.id
  entity_type = "Folder"
  permissions {
    user_or_group = var.horizon_serviceaccount_instant_clone
    propagate = true
    is_group = false
    role_id = vsphere_role.horizon_role_instant_clone.id
  }
}

resource "vsphere_entity_permissions" "horizon_vdi_datastore" {
  entity_id = data.vsphere_datastore.horizon_vdi_datastore.id
  entity_type = "Datastore"
  permissions {
    user_or_group = var.horizon_serviceaccount_instant_clone
    propagate = true
    is_group = false
    role_id = vsphere_role.horizon_role_instant_clone.id
  }
}

resource "vsphere_entity_permissions" "horizon_vdi_network" {
  entity_id = data.vsphere_network.horizon_vdi_network.id
  entity_type = "Network"
  permissions {
    user_or_group = var.horizon_serviceaccount_instant_clone
    propagate = true
    is_group = false
    role_id = vsphere_role.horizon_role_instant_clone.id
  }
}

resource "vsphere_entity_permissions" "horizon_vdi_resource_pool" {
  entity_id = data.vsphere_resource_pool.horizon_vdi_resource_pool.id
  entity_type = "ResourcePool"
  permissions {
    user_or_group = var.horizon_serviceaccount_instant_clone
    propagate = true
    is_group = false
    role_id = vsphere_role.horizon_role_instant_clone.id
  }
}