# TaskSchedulerGUI
A gui to create, delete, and manage tasks in task scheduler

Will allow you to quickly glance at a current tasks in Task Scheduler and allow you to make minor changes if needed.  Most useful though will be spawning new task quickly and easily. Task Scheduler is fine if you need a something scheduled on a recurring basis, but running one offs I find is a pain and using this tool will simplify that process.

To limit the scope of what it pulls from task scheduler modify $PATHREGEX towards the top of the script to a valid regex that will grab the path you want to limit it too. If you're not too great with regex use regex101.com and set the Flavor to ".Net C#" so you can test it quicker than constantly closing and loading the script.
