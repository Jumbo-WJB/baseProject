<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Cache-control" content="no-cache">
    <title>提现管理 - 财务管理系统</title>
                                               <link rel="stylesheet" type="text/css" href="http://static.yangyi.qa.anhouse.com.cn/fin/common/plugins/jquery.datepicker/jquery.datepicker.css" />
<link rel="stylesheet" type="text/css" href="http://static.yangyi.qa.anhouse.com.cn/fin/fin/fin.css" />
<link rel="stylesheet" type="text/css" href="http://static.yangyi.qa.anhouse.com.cn/fin/fin/paycenter/getcashmanage.css" />
<script type="text/javascript" charset="utf-8" src="http://static.yangyi.qa.anhouse.com.cn/fin/common/library/jquery-1.11.0.min.js"></script>
 
<script type="text/javascript">
	i = 1;
	j = 1;
	$(document).ready(function(){
		
		$("#btn_add1").click(function(){
			document.getElementById("newUpload1").innerHTML+='<div id="div_'+i+'"><input  name="file" type="file"  /><input type="button" value="删除"  onclick="del_1('+i+')"/></div>';
			  i = i + 1;
		});
		
		$("#btn_add2").click(function(){
			document.getElementById("newUpload2").innerHTML+='<div id="div_'+j+'"><input  name="file_'+j+'" type="file"  /><input type="button" value="删除"  onclick="del_2('+j+')"/></div>';
			  j = j + 1;
		});
	});

</script>
<body id="fin_common_headercomponent">
 <h1>springMVC字节流输入上传文件</h1> 
    <form name="userForm1" action="${base}/presentAudit/upload" enctype="multipart/form-data" method="post">
		<div id="newUpload1">
			<input type="file" name="file">
		</div>
		
	  <input type="button" id="btn_add1" value="增加一行" >
		<input type="submit" value="上传" >
 	</form> 
	  
 	 <h1>springMVC包装类上传文件</h1> 
 	<form name="userForm2" action="${base}/presentAudit/upload2" enctype="multipart/form-data" method="post"">
 		<div id="newUpload2">
			<input type="file" name="file">
		</div>
		<input type="button" id="btn_add2" value="增加一行" >
		<input type="submit" value="上传" >
 	</form> 
</body>
</html>
