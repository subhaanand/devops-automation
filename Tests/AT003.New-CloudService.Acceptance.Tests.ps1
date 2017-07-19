
$Config = Get-Content $PSScriptRoot\..\Tests\Acceptance.Config.json -Raw | ConvertFrom-Json
Push-Location -Path $PSScriptRoot\..\Infrastructure\Resources\

Describe "New-CloudService Tests" -Tag "Acceptance-ASM" {

    It "Should create a Cloud Service and return one output" {
        $Result = .\New-CloudService.ps1 -Location $Config.location -Name $Config.cloudServiceName
        $Result.Count | Should Be 0
    }

    It "Should create a Cloud Service with the correct name" {
        $Result = Get-AzureService -ServiceName $Config.cloudServiceName -ErrorAction SilentlyContinue
        $Result.ServiceName | Should Be $Config.cloudServiceName
    }

    It "Should create a Cloud Service in the correct location" {
        $Result = Get-AzureService -ServiceName $Config.cloudServiceName -ErrorAction SilentlyContinue
        $Result.Location | Should Be $Config.location
    }
}

Pop-Location