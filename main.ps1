###################################################################################
#                                                                                 #
#  GUI interface for creating, deleting, and modifying tasks                      #
#                                                                                 #
#                                                                                 #
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
#  1) Window Box Creation                                                         #
###################################################################################

[void][System.Reflection.Assembly]::LoadwithPartialName("System.Drawing")
[void][System.Reflection.Assembly]::LoadwithPartialName("System.Windows.Forms")

#Main Window Creation
$form = New-Object System.Windows.Forms.Form
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.text = "Task Scheduler GUI"
$form.size = New-Object System.Drawing.Size(1400,600)
$form.startposition = "CenterScreen"
$form.backgroundImageLayout = "Zoom"
$form.MinimizeBox = $true
$form.maximizeBox = $true
$form.SizeGripStyle = "Show"
$Icon = [system.drawing.icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
$form.Icon = $Icon
$FormTabControl = New-Object System.Windows.Forms.TabControl
$FormTabControl.Size = "1375,540"
$FormTabControl.Location = "10,10"
$Form.Controls.Add($FormTabControl)

#Tab creation
$ViewCurrentTasksTab = New-Object System.Windows.Forms.Tabpage
$ViewCurrentTasksTab.DataBindings.DefaultDataSourceUpdateMode = 0
$ViewCurrentTasksTab.UseVisualStyleBackColor = $true
$ViewCurrentTasksTab.Name = "View Scheduled Tasks"
$ViewCurrentTasksTab.Text = "View Scheduled Tasks"
$FormTabControl.Controls.Add($ViewCurrentTasksTab)




$Form.Add_Shown({$form.Activate()})
[void] $form.ShowDialog()