<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 14-11-19
  Time: 下午6:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
        function fileChange(target) {
            var fileSize = 0;
            if (isIE && !target.files) {
                var filePath = target.value;
                var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
                var file = fileSystem.GetFile(filePath);
                fileSize = file.Size;
            } else {
                fileSize = target.files[0].size;
            }
            var size = fileSize / 1024;
            if (size > 10000) {
                alert("附件不能大于10M");
            }
        }
    </script>
</head>
<body>
<form action="fileAction.action" method="post" enctype="multipart/form-data">
    <input type="file" name="uploadImage"  onchange="fileChange(this);">
    <input type="submit" value="上传">
</form>
</body>
</html>