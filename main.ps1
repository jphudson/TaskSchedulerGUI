###################################################################################
#                                                                                 #
#  GUI interface for creating, deleting, and modifying tasks                      #
#                                                                                 #
#     1) Functions                                                                #
#     2) Window Box And Tab Creation                                              #
#     3) View Current Tasks Tab Elements                                          #
#     4) Start Window                                                             #
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
#  1) Functions                                                                   #
###################################################################################

###################################################################################
#  2) Window Box And Tab Creation                                                 #
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

#Tab creation
$ViewCurrentTasksTab = New-Object System.Windows.Forms.Tabpage
$ViewCurrentTasksTab.DataBindings.DefaultDataSourceUpdateMode = 0
$ViewCurrentTasksTab.UseVisualStyleBackColor = $true
$ViewCurrentTasksTab.Name = "View Scheduled Tasks"
$ViewCurrentTasksTab.Text = "View Scheduled Tasks"
$FormTabControl.Controls.Add($ViewCurrentTasksTab)

###################################################################################
#  3) View Current Tasks Tab Elements                                             #
###################################################################################

#Top Folder Dropdown
$TopFolderDropdownLabel = New-Object System.Windows.Forms.Label
$TopFolderDropdownLabel.text = "Top Folder:"
$TopFolderDropdownLabel.Width = 70
$TopFolderDropdownLabel.location = New-Object System.Drawing.Point(10,10)
$ViewCurrentTasksTab.Controls.Add($TopFolderDropdownLabel)
$TopFolderDropdown = New-Object System.Windows.Forms.ComboBox
$TopFolderDropdown.text = ""
$TopFolderDropdown.width = 200
$TopFolderDropdown.AutoSize = $true
$TopFolderList = @('FolderSimulateLongFolderNames1','Folder2','FolderSimulateLongFolderNames3')
ForEach ($folder in $TopFolderList){
    [void]$TopFolderDropdown.Items.Add($folder)
}
$TopFolderDropdown.SelectedIndex = 0
$TopFolderDropdown.Location = New-Object System.Drawing.Point(90,10)
$ViewCurrentTasksTab.Controls.Add($TopFolderDropdown)

#Sub Folder Dropdown
$SubFolderDropdownLabel = New-Object System.Windows.Forms.Label
$SubFolderDropdownLabel.text = "Sub Folder:"
$SubFolderDropdownLabel.Width = 70
$SubFolderDropdownLabel.location = New-Object System.Drawing.Point(10,35)
$ViewCurrentTasksTab.Controls.Add($SubFolderDropdownLabel)
$SubFolderDropdown = New-Object System.Windows.Forms.ComboBox
$SubFolderDropdown.text = ""
$SubFolderDropdown.width = 200
$SubFolderDropdown.AutoSize = $true
$SubFolderList = @('FolderSimulateLongFolderNames1','Folder2','FolderSimulateLongFolderNames3')
ForEach ($folder in $SubFolderList){
    [void]$SubFolderDropdown.Items.Add($folder)
}
$SubFolderDropdown.SelectedIndex = 0
$SubFolderDropdown.Location = New-Object System.Drawing.Point(90,35)
$ViewCurrentTasksTab.Controls.Add($SubFolderDropdown)

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
$TasksList = @('TaskSimulateLongTaskNames1','Task2','TaskSimulateLongTaskNames3')
ForEach ($folder in $TasksList){
    [void]$TaskSelectionDropdown.Items.Add($folder)
}
$TaskSelectionDropdown.SelectedIndex = 0
$TaskSelectionDropdown.Location = New-Object System.Drawing.Point(385,10)
$ViewCurrentTasksTab.Controls.Add($TaskSelectionDropdown)

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
$TaskName = New-Object System.Windows.Forms.Label
$TaskName.text = "Test Name"
$TaskName.Width = 70
$TaskName.location = New-Object System.Drawing.Point(80,100)
$ViewCurrentTasksTab.Controls.Add($TaskName)

#Task Path
$TaskPathLabel = New-Object System.Windows.Forms.Label
$TaskPathLabel.text = "Task Path:"
$TaskPathLabel.Width = 70
$TaskPathLabel.location = New-Object System.Drawing.Point(10,130)
$ViewCurrentTasksTab.Controls.Add($TaskPathLabel)
$TaskPath = New-Object System.Windows.Forms.Label
$TaskPath.text = "Test Path"
$TaskPath.Width = 70
$TaskPath.location = New-Object System.Drawing.Point(80,130)
$ViewCurrentTasksTab.Controls.Add($TaskPath)

#State
$StateLabel = New-Object System.Windows.Forms.Label
$StateLabel.text = "State:"
$StateLabel.Width = 70
$StateLabel.location = New-Object System.Drawing.Point(10,160)
$ViewCurrentTasksTab.Controls.Add($StateLabel)
$State = New-Object System.Windows.Forms.Label
$State.text = "Status"
$State.Width = 70
$State.location = New-Object System.Drawing.Point(80,160)
$ViewCurrentTasksTab.Controls.Add($State)

#Last Run Date
$LastRunDateLabel = New-Object System.Windows.Forms.Label
$LastRunDateLabel.text = "Last Run Date:"
$LastRunDateLabel.Width = 85
$LastRunDateLabel.location = New-Object System.Drawing.Point(10,190)
$ViewCurrentTasksTab.Controls.Add($LastRunDateLabel)
$LastRunDate = New-Object System.Windows.Forms.Label
$LastRunDate.text = "Date Information"
$LastRunDate.Width = 120
$LastRunDate.location = New-Object System.Drawing.Point(95,190)
$ViewCurrentTasksTab.Controls.Add($LastRunDate)

#Next Run Date
$NextRunDateLabel = New-Object System.Windows.Forms.Label
$NextRunDateLabel.text = "Next Run Date:"
$NextRunDateLabel.Width = 85
$NextRunDateLabel.location = New-Object System.Drawing.Point(10,220)
$ViewCurrentTasksTab.Controls.Add($NextRunDateLabel)
$NextRunDate = New-Object System.Windows.Forms.Label
$NextRunDate.text = "Date Information"
$NextRunDate.Width = 120
$NextRunDate.location = New-Object System.Drawing.Point(95,220)
$ViewCurrentTasksTab.Controls.Add($NextRunDate)

###################################################################################
#  4) Start Window                                                                #
###################################################################################
$Form.Add_Shown({$form.Activate()})
[void] $form.ShowDialog()