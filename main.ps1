###################################################################################
#                                                                                 #
#  GUI interface for creating, deleting, and modifying tasks                      #
#                                                                                 #
#     1) Variables                                                                #
#     2) Functions                                                                #
#     3) Window Box And Tab Creation                                              #
#     4) View Current Tasks Tab Elements                                          #
#     5) Modify or Create Tasks Tab Elements                                      #
#     5) Start Window                                                             #
#                                                                                 #
#                                                                                 #
#  Created By: John Hudson                                                        #
#  Creation Date: 3/23/23                                                         #
#                                                                                 #
#                                                                                 #
###################################################################################

###################################################################################
# Revision History                                                                #
#                                                                                 #
#                                                                                 #
###################################################################################

###################################################################################
#  1) Variables                                                                   #
###################################################################################

#for narrowing down the paths so it isn't cluttered with all the Windows ones
$PATHREGEX = "\\*"

###################################################################################
#  2) Functions                                                                   #
###################################################################################
function Get-TaskPaths{
    $paths = Get-ScheduledTask | Where-Object {$_.$TaskPath -match $PATHREGEX} | Select-Object -Unique -ExpandProperty TaskPath
    [void]$TaskPathDropdown.Items.Add("")
    foreach ($path in $paths){
        [void]$TaskPathDropdown.Items.Add($path)
    }
}

function Get-Tasks{
    $TaskSelectionDropdown.Items.Clear()
    $TaskSelectionDropdown.ResetText()
    $tasks = Get-ScheduledTask | Where-Object {$_.TaskPath -eq $TaskPathDropdown.SelectedItem} | Select-Object -ExpandProperty TaskName
    [void]$TaskSelectionDropdown.Items.Add("")
    foreach($task in $tasks){
        [void]$TaskSelectionDropdown.Items.Add($task)
    }
}

function Get-Refresh{
    $Task = (Get-ScheduledTask $TaskSelectionDropdown.SelectedItem)
    $TaskHistory = (Get-ScheduledTaskInfo $TaskSelectionDropdown.SelectedItem)

    $TaskName.Text = $Task.TaskName
    $TaskPath.Text = $task.TaskPath
    $TaskDescription.Text = $Task.Description
    $State.Text = $Task.State | Out-String
    $LastRunDate.Text = $TaskHistory.LastRunDate
    $NextRunDate.Text = $TaskHistory.NextRunDate
    $ExecuteFile.Text = $Task.Actions.Execute
    $Arguments.Text = $Task.Actions.Arguments
    $WorkingDirectory.Text = $Task.Actions.WorkingDirectory

}

###################################################################################
#  3) Window Box And Tab Creation                                                 #
###################################################################################

[void][System.Reflection.Assembly]::LoadwithPartialName("System.Drawing")
[void][System.Reflection.Assembly]::LoadwithPartialName("System.Windows.Forms")

#Main Window Creation
$form = New-Object System.Windows.Forms.Form
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.text = "Task Scheduler GUI"
$form.size = New-Object System.Drawing.Size(1400,800)
$form.startposition = "CenterScreen"
$form.backgroundImageLayout = "Zoom"
$form.MinimizeBox = $true
$form.maximizeBox = $true
$form.SizeGripStyle = "Show"
$Icon = [system.drawing.icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
$form.Icon = $Icon
$FormTabControl = New-Object System.Windows.Forms.TabControl
$FormTabControl.Size = "1365,740"
$FormTabControl.Location = "10,10"
$Form.Controls.Add($FormTabControl)

#View Tasks Tab creation
$ViewCurrentTasksTab = New-Object System.Windows.Forms.Tabpage
$ViewCurrentTasksTab.DataBindings.DefaultDataSourceUpdateMode = 0
$ViewCurrentTasksTab.UseVisualStyleBackColor = $true
$ViewCurrentTasksTab.Name = "View Scheduled Tasks"
$ViewCurrentTasksTab.Text = "View Scheduled Tasks"
$FormTabControl.Controls.Add($ViewCurrentTasksTab)

#Modify Tasks Tab creation
$ModifyTasksTab = New-Object System.Windows.Forms.Tabpage
$ModifyTasksTab.DataBindings.DefaultDataSourceUpdateMode = 1
$ModifyTasksTab.UseVisualStyleBackColor = $true
$ModifyTasksTab.Name = "Modify Scheduled Tasks"
$ModifyTasksTab.Text = "Modify Scheduled Tasks"
$FormTabControl.Controls.Add($ModifyTasksTab)

#Create Tasks Tab creation
$CreateTasksTab = New-Object System.Windows.Forms.Tabpage
$CreateTasksTab.DataBindings.DefaultDataSourceUpdateMode = 2
$CreateTasksTab.UseVisualStyleBackColor = $true
$CreateTasksTab.Name = "Create Scheduled Tasks"
$CreateTasksTab.Text = "Create Scheduled Tasks"
$FormTabControl.Controls.Add($CreateTasksTab)

###################################################################################
#  4) View Current Tasks Tab Elements                                             #
###################################################################################

#Top Folder Dropdown
$TaskPathDropdownLabel = New-Object System.Windows.Forms.Label
$TaskPathDropdownLabel.text = "Task Path:"
$TaskPathDropdownLabel.Width = 70
$TaskPathDropdownLabel.location = New-Object System.Drawing.Point(10,10)
$ViewCurrentTasksTab.Controls.Add($TaskPathDropdownLabel)
$TaskPathDropdown = New-Object System.Windows.Forms.ComboBox
$TaskPathDropdown.text = ""
$TaskPathDropdown.width = 200
$TaskPathDropdown.AutoSize = $true
Get-TaskPaths
$TaskPathDropdown.Add_SelectedIndexChanged({Get-Tasks})
$TaskPathDropdown.SelectedIndex = 0
$TaskPathDropdown.Location = New-Object System.Drawing.Point(90,10)
$ViewCurrentTasksTab.Controls.Add($TaskPathDropdown)

#Task Selection
$TaskSelectionDropdownLabel = New-Object System.Windows.Forms.Label
$TaskSelectionDropdownLabel.text = "Task:"
$TaskSelectionDropdownLabel.Width = 50
$TaskSelectionDropdownLabel.location = New-Object System.Drawing.Point(335,10)
$ViewCurrentTasksTab.Controls.Add($TaskSelectionDropdownLabel)
$TaskSelectionDropdown = New-Object System.Windows.Forms.ComboBox
$TaskSelectionDropdown.text = ""
$TaskSelectionDropdown.width = 200
$TaskSelectionDropdown.AutoSize = $true
$TaskSelectionDropdown.Location = New-Object System.Drawing.Point(385,10)
$TaskSelectionDropdown.Add_SelectedIndexChanged({Get-Refresh})
$ViewCurrentTasksTab.Controls.Add($TaskSelectionDropdown)

#Refresh button
$RefreshButton = New-Object System.Windows.Forms.Button
$RefreshButton.Location = New-Object System.Drawing.Point(600,40)
$RefreshButton.Size = New-Object System.Drawing.Point(120,25)
$RefreshButton.Text = "Refresh"
$RefreshButton.Add_Click({Get-Refresh})
$ViewCurrentTasksTab.Controls.Add($RefreshButton)

#Divider
$Divider = New-Object System.Windows.Forms.Label
$Divider.text = ""
$Divider.Height = 1
$Divider.Width = 1340
$Divider.BorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$Divider.AutoSize = $false
$Divider.location = New-Object System.Drawing.Point(10,80)
$ViewCurrentTasksTab.Controls.Add($Divider)

#Task Name
$TaskNameLabel = New-Object System.Windows.Forms.Label
$TaskNameLabel.text = "Task Name:"
$TaskNameLabel.Width = 70
$TaskNameLabel.location = New-Object System.Drawing.Point(10,100)
$ViewCurrentTasksTab.Controls.Add($TaskNameLabel)
$TaskName = New-Object System.Windows.Forms.TextBox
$TaskName.text = ""
$TaskName.Width = 400
$TaskName.location = New-Object System.Drawing.Point(80,100)
$TaskName.ReadOnly = $true
$TaskName.BorderStyle = 0
$TaskName.BackColor = $ViewCurrentTasksTab.BackColor
$ViewCurrentTasksTab.Controls.Add($TaskName)

#Task Path
$TaskPathLabel = New-Object System.Windows.Forms.Label
$TaskPathLabel.text = "Task Path:"
$TaskPathLabel.Width = 70
$TaskPathLabel.location = New-Object System.Drawing.Point(10,130)
$ViewCurrentTasksTab.Controls.Add($TaskPathLabel)
$TaskPath = New-Object System.Windows.Forms.TextBox
$TaskPath.text = ""
$TaskPath.Width = 400
$TaskPath.location = New-Object System.Drawing.Point(80,130)
$TaskPath.ReadOnly = $true
$TaskPath.BorderStyle = 0
$TaskPath.BackColor = $ViewCurrentTasksTab.BackColor
$ViewCurrentTasksTab.Controls.Add($TaskPath)

#State
$StateLabel = New-Object System.Windows.Forms.Label
$StateLabel.text = "State:"
$StateLabel.Width = 70
$StateLabel.location = New-Object System.Drawing.Point(10,160)
$ViewCurrentTasksTab.Controls.Add($StateLabel)
$State = New-Object System.Windows.Forms.TextBox
$State.text = ""
$State.Width = 70
$State.location = New-Object System.Drawing.Point(80,160)
$State.ReadOnly = $true
$State.BorderStyle = 0
$State.BackColor = $ViewCurrentTasksTab.BackColor
$ViewCurrentTasksTab.Controls.Add($State)

#Last Run Date
$LastRunDateLabel = New-Object System.Windows.Forms.Label
$LastRunDateLabel.text = "Last Run Date:"
$LastRunDateLabel.Width = 85
$LastRunDateLabel.location = New-Object System.Drawing.Point(10,190)
$ViewCurrentTasksTab.Controls.Add($LastRunDateLabel)
$LastRunDate = New-Object System.Windows.Forms.TextBox
$LastRunDate.text = ""
$LastRunDate.Width = 200
$LastRunDate.location = New-Object System.Drawing.Point(95,190)
$LastRunDate.ReadOnly = $true
$LastRunDate.BorderStyle = 0
$LastRunDate.BackColor = $ViewCurrentTasksTab.BackColor
$ViewCurrentTasksTab.Controls.Add($LastRunDate)

#Next Run Date
$NextRunDateLabel = New-Object System.Windows.Forms.Label
$NextRunDateLabel.text = "Next Run Date:"
$NextRunDateLabel.Width = 85
$NextRunDateLabel.location = New-Object System.Drawing.Point(10,220)
$ViewCurrentTasksTab.Controls.Add($NextRunDateLabel)
$NextRunDate = New-Object System.Windows.Forms.TextBox
$NextRunDate.text = ""
$NextRunDate.Width = 200
$NextRunDate.location = New-Object System.Drawing.Point(95,220)
$NextRunDate.ReadOnly = $true
$NextRunDate.BorderStyle = 0
$NextRunDate.BackColor = $ViewCurrentTasksTab.BackColor
$ViewCurrentTasksTab.Controls.Add($NextRunDate)

#Task Description
$TaskDescriptionLabel = New-Object System.Windows.Forms.Label
$TaskDescriptionLabel.text = "Description:"
$TaskDescriptionLabel.Width = 85
$TaskDescriptionLabel.location = New-Object System.Drawing.Point(10,250)
$ViewCurrentTasksTab.Controls.Add($TaskDescriptionLabel)
$TaskDescription = New-Object System.Windows.Forms.TextBox
$TaskDescription.text = ""
$TaskDescription.Width = 800
$TaskDescription.Height = 70
$TaskDescription.location = New-Object System.Drawing.Point(95,250)
$TaskDescription.ReadOnly = $true
$TaskDescription.BorderStyle = 0
$TaskDescription.BackColor = $ViewCurrentTasksTab.BackColor
$TaskDescription.Multiline = $true
$ViewCurrentTasksTab.Controls.Add($TaskDescription)

#Execute File
$ExecuteFileLabel = New-Object System.Windows.Forms.Label
$ExecuteFileLabel.text = "Execute:"
$ExecuteFileLabel.Width = 85
$ExecuteFileLabel.location = New-Object System.Drawing.Point(10,320)
$ViewCurrentTasksTab.Controls.Add($ExecuteFileLabel)
$ExecuteFile = New-Object System.Windows.Forms.TextBox
$ExecuteFile.text = ""
$ExecuteFile.Width = 800
$ExecuteFile.location = New-Object System.Drawing.Point(95,320)
$ExecuteFile.ReadOnly = $true
$ExecuteFile.BorderStyle = 0
$ExecuteFile.BackColor = $ViewCurrentTasksTab.BackColor
$ViewCurrentTasksTab.Controls.Add($ExecuteFile)

#Arguments
$ArgumentsLabel = New-Object System.Windows.Forms.Label
$ArgumentsLabel.text = "Arguments:"
$ArgumentsLabel.Width = 85
$ArgumentsLabel.location = New-Object System.Drawing.Point(10,350)
$ViewCurrentTasksTab.Controls.Add($ArgumentsLabel)
$Arguments = New-Object System.Windows.Forms.TextBox
$Arguments.text = ""
$Arguments.Width = 800
$Arguments.location = New-Object System.Drawing.Point(95,350)
$Arguments.ReadOnly = $true
$Arguments.BorderStyle = 0
$Arguments.BackColor = $ViewCurrentTasksTab.BackColor
$ViewCurrentTasksTab.Controls.Add($Arguments)

#Working Directory
$WorkingDirectoryLabel = New-Object System.Windows.Forms.Label
$WorkingDirectoryLabel.text = "Working Directory:"
$WorkingDirectoryLabel.Width = 100
$WorkingDirectoryLabel.location = New-Object System.Drawing.Point(10,380)
$ViewCurrentTasksTab.Controls.Add($WorkingDirectoryLabel)
$WorkingDirectory = New-Object System.Windows.Forms.TextBox
$WorkingDirectory.text = ""
$WorkingDirectory.Width = 800
$WorkingDirectory.location = New-Object System.Drawing.Point(115,380)
$WorkingDirectory.ReadOnly = $true
$WorkingDirectory.BorderStyle = 0
$WorkingDirectory.BackColor = $ViewCurrentTasksTab.BackColor
$ViewCurrentTasksTab.Controls.Add($WorkingDirectory)

###################################################################################
#  5) Modify Tasks Tab Elements                                                   #
###################################################################################

#Top Folder Dropdown
$MTTaskPathDropdownLabel = New-Object System.Windows.Forms.Label
$MTTaskPathDropdownLabel.text = "Task Path:"
$MTTaskPathDropdownLabel.Width = 70
$MTTaskPathDropdownLabel.location = New-Object System.Drawing.Point(10,10)
$ModifyTasksTab.Controls.Add($MTTaskPathDropdownLabel)
$MTTaskPathDropdown = New-Object System.Windows.Forms.ComboBox
$MTTaskPathDropdown.text = ""
$MTTaskPathDropdown.width = 200
$MTTaskPathDropdown.AutoSize = $true
Get-TaskPaths
#$MTTaskPathDropdown.Add_SelectedIndexChanged({Get-Tasks})
$MTTaskPathDropdown.SelectedIndex = 0
$MTTaskPathDropdown.Location = New-Object System.Drawing.Point(90,10)
$ModifyTasksTab.Controls.Add($MTTaskPathDropdown)

#Task Selection
$MTTaskSelectionDropdownLabel = New-Object System.Windows.Forms.Label
$MTTaskSelectionDropdownLabel.text = "Task:"
$MTTaskSelectionDropdownLabel.Width = 50
$MTTaskSelectionDropdownLabel.location = New-Object System.Drawing.Point(335,10)
$ModifyTasksTab.Controls.Add($TaskSelectionDropdownLabel)
$MTTaskSelectionDropdown = New-Object System.Windows.Forms.ComboBox
$MTTaskSelectionDropdown.text = ""
$MTTaskSelectionDropdown.width = 200
$MTTaskSelectionDropdown.AutoSize = $true
$MTTaskSelectionDropdown.Location = New-Object System.Drawing.Point(385,10)
#$TaskSelectionDropdown.Add_SelectedIndexChanged({Get-Refresh})
$ModifyTasksTab.Controls.Add($MTTaskSelectionDropdown)

#Refresh button
$MTRefreshButton = New-Object System.Windows.Forms.Button
$MTRefreshButton.Location = New-Object System.Drawing.Point(600,40)
$MTRefreshButton.Size = New-Object System.Drawing.Point(120,25)
$MTRefreshButton.Text = "Refresh"
#$RefreshButton.Add_Click({Get-Refresh})
$ModifyTasksTab.Controls.Add($MTRefreshButton)

#Divider
$MTDivider = New-Object System.Windows.Forms.Label
$MTDivider.text = ""
$MTDivider.Height = 1
$MTDivider.Width = 1340
$MTDivider.BorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$MTDivider.AutoSize = $false
$MTDivider.location = New-Object System.Drawing.Point(10,80)
$ModifyTasksTab.Controls.Add($MTDivider)

###################################################################################
#  6) Create Tasks Tab Elements                                                   #
###################################################################################

###################################################################################
#  7) Start Window                                                                #
###################################################################################
$Form.Add_Shown({$form.Activate()})
[void] $form.ShowDialog()