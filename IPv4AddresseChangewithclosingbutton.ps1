Add-Type -AssemblyName System.Windows.Forms

# Funktion, um eine zufällige IPv4-Adresse der Klasse C zu generieren
function Generate-RandomIPv4Address {
    $a = 192
    $b = 168
    $c = Get-Random -Minimum 1 -Maximum 256
    $d = Get-Random -Minimum 1 -Maximum 256
    $address = "$a.$b.$c.$d"
    return $address
}

# Funktion, um die IPv4-Adresse zu ändern
function Set-IPv4Address {
    $newAddress = Generate-RandomIPv4Address
    $cmd = "netsh interface ipv4 set address ""Ethernet"" static $newAddress 255.255.255.0 192.168.1.1 1"
    Invoke-Expression $cmd
    $currentLabel.Text = "Aktuelle IPv4-Adresse: " + (Get-NetIPAddress -AddressFamily IPV4)
    $changeButton.Text = "IPv4-Adresse ändern ($newAddress)"
}

# Funktion zum Schließen des Formulars
function Close-Form {
    $form.Close()
}

# Erstellen des Windows-Formulars
$form = New-Object System.Windows.Forms.Form
$form.Text = "IPv4-Adresse ändern"
$form.AutoSize = $true

# Label für die derzeitige IPv4-Adresse
$currentLabel = New-Object System.Windows.Forms.Label
$currentLabel.Location = New-Object System.Drawing.Point(10,10)
$currentLabel.AutoSize = $true
$currentLabel.Text = "Aktuelle IPv4-Adresse: " + (Get-NetIPAddress -AddressFamily IPV4)

# Button zum Ändern der IPv4-Adresse
$changeButton = New-Object System.Windows.Forms.Button
$changeButton.Location = New-Object System.Drawing.Point(10,70)
$changeButton.AutoSize = $true
$changeButton.Text = "IPv4-Adresse ändern"
$changeButton.Add_Click({Set-IPv4Address})

# Button zum Schließen des Formulars
$closeButton = New-Object System.Windows.Forms.Button
$closeButton.Location = New-Object System.Drawing.Point(10,100)
$closeButton.AutoSize = $true
$closeButton.Text = "Schließen"
$closeButton.Add_Click({Close-Form})

# Hinzufügen der Steuerelemente zum Formular
$form.Controls.Add($currentLabel)
$form.Controls.Add($changeButton)
$form.Controls.Add($closeButton)

# Anzeigen des Formulars
$form.ShowDialog() | Out-Null
