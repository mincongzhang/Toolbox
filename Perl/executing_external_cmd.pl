#There are many ways to execute external commands from Perl. The most commons are:

#system function
#exec function
#backticks (``) operator
#open function

#All of these methods have different behaviour, so you should choose which one to use depending of your particular need. In brief, these are the recommendations:

#system()	you want to execute a command and don't want to capture its output
#exec	you don't want to return to the calling perl script
#backticks	you want to capture the output of the command
#open	you want to pipe the command (as input or output) to your script
