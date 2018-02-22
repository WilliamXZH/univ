$("#button").click(function(){
    var htmlobj = $.ajax({
        url:"a.txt",
        async:false
    });
    alert(htmlobj.responseText)
});