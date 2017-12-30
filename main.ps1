Login-AzureRmAccount

Set-AzureRmContext -SubscriptionID cf7ff038-b59f-4cc3-a7e8-60c720103724


$vault = Get-AzureRmRecoveryServicesVault -Name "st4817-bv-dev"
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


