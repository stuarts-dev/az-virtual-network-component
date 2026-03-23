# Virtual Network Component

This configuration can be used to provision a list of Virtual Networks within a Subscription.

## Inputs

The component requires the following values to be provided:-

`subscription_id`: The Id of the Subscription in which the Virtual Network(s) should be created.

`location`: The Azure Region in which the Virtual Network(s) should be created. Defaults to `uksouth` if not supplied.

`vnets`: A list of one or more objects which the define the Virtual Networks to create. Each Virtual Network object can also define Subnets, each of which can contain an NSG with its own rules Rules.

`standalone_nsgs`: A list of one or more objects to define standalone NSGs that don't have an association with any subnet created by this component.

`common_nsg_rules`: A list of one or more objects to define NSG rules that should be added to all NSGs created by this component - i.e. those defined within the context of the `vnets` object and those within `standalone_nsgs`.

`tags`: The standard tags to apply to MPS resources.

## Execution
```
terraform init -backend-config=../../platform-releases/tfvars/{env}/{sub}/virtual-networks/backend.tfvars -reconfigure

terraform plan -var-file=../../platform-releases/tfvars/{env}/{sub}/virtual-networks/terraform.tfvars

terraform apply -var-file=../../platform-releases/tfvars/{env}/{sub}/virtual-networks/terraform.tfvars
```

## Promotion backend.tfvars

Promotion backend.tfvars file was created to workaround issue while uploading artifacts to nexus.
This will not be accessible and effectively force uploading artifacts to nexus from dev environment only as it references to dev mgmt storage account.
