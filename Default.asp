<html>
<head>
<SCRIPT language="JavaScript">
<!--hide

var password;

var pass1="pknw1plex";

password=prompt('Please enter your password to view this page!',' ');

if (password==pass1)
  alert('Password Correct! Click OK to enter!');
else
   {
    window.location="https://www.pknw1.com";
    }

//-->
</SCRIPT>
<title>
RAWeb - Remote Applications
</title>
<style type="text/css">
a:link {color:#444444;text-decoration:none;}
a:visited {color:#444444;text-decoration:none;}
a:hover{color:#000000;text-decoration:underline;}
a:active {color:#000000;text-decoration:underline;}
#apptile
{
width:150px;
height:135px;
text-align:center;
vertical-align:bottom;
border-style:solid;
border-width:0px;
float:left;
font-size:14px;
font-weight:bold;
}
h1 {
    font-family:Arial, Helvetica, sans-serif;
    font-size: 30px;
    font-style: italic;
    color:rgb(0,0,0)
}
body
{
font-family:Arial,sans-serif;
}
</style>
<link rel="shortcut icon" href="favicon.ico">
</head>
<body>
<div style='text-align:left;'><h1>Remote<font style='color:rgb(100,100,100)'>Apps</font></h1></div><br>
<%
Whichfolder=server.mappath("rdp\") &"/" 
Dim fs, f, f1, fc
set fs = CreateObject("Scripting.FileSystemObject")  
set f = fs.GetFolder(Whichfolder)  
set fc = f.files

For Each f1 in fc
	if (LCase(Right(f1.name,4)) = ".rdp") then
		if not GetRDPvalue(f1,"full address:s:") = "" then
			appname = GetRDPvalue(f1,"remoteapplicationname:s:")
			basefilename = Left(f1.name,Len(f1.name) - 4)
			
			if appname = "" then appname = basefilename
			
			pngname = basefilename & ".png"
			set pngfs = CreateObject("Scripting.FileSystemObject")
			If pngfs.FileExists(server.mappath("png\" & pngname)) Then
				pngpath = "png/" & pngname
			Else			
				pngpath = "rdpicon.png"
			End If	
			Response.write "<div id=apptile>"
			Response.write "<a href=""" & "rdp/" & f1.name & """><img border=0 height=64 width=64 src=""" & pngpath & """><br>" & appname & "</a>"
			Response.write "</div>"
		end if
	end if
Next

function GetRDPvalue(f1,valuename)
	Err.Clear
	on error resume next
	Dim ts
	valuenamelen = Len(valuename)
	set ts = f1.OpenAsTextStream(1,-2)
	if Err.Number = 0 then
		Do While Not ts.AtEndOfStream
			Dim Line
			Line = ts.readline
			if (Lcase(Left(Line,valuenamelen)) = valuename) then
				theName = Right(Line,Len(Line)-valuenamelen)
			end if
		Loop
		theName = Replace(theName,"|","")
		GetRDPvalue = theName
	Else
		GetRDPvalue = ""
	end if
	on error goto 0
end function

%>
</body>
</html>
