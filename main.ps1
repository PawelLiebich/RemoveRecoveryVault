Login-AzureRmAccount

Set-AzureRmContext -SubscriptionID 55555555-5555-5555-5555-555555555

$vault = Get-AzureRmRecoveryServicesVault -Name "55555-dev"
Set-AzureRmRecoveryServicesVaultContext -Vault $vault

$containers = Get-AzureRmRecoveryServicesBackupContainer -ContainerType AzureSQL -FriendlyName $vault.Name
ForEach ($container in $containers) {
 $items = Get-AzureRmRecoveryServicesBackupItem -container $container -WorkloadType AzureSQLDatabase
 ForEach ($item in $items) {
 Disable-AzureRmRecoveryServicesBackupProtection -item $item -RemoveRecoveryPoints -Force -ea SilentlyContinue
 }
 Unregister-AzureRmRecoveryServicesBackupContainer -Container $container
}
Remove-AzureRmRecoveryServicesVault -Vault $vault


