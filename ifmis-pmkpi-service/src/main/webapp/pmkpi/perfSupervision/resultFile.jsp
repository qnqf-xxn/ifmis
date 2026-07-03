<%@ page language="java" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ page language="java" import="gov.mof.fasp2.buscore.framework.util.GlobalConfig"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    String appid = null;
    String appidpath = (String)request.getAttribute("appidpath");
    if(appidpath!=null && !"".equals(appidpath)){
        appid = appidpath.substring(1,appidpath.length()).toUpperCase();
    }
    String key_warningmsg = "BUSCOMMON_UPLOAD_WARNING";
    String warningmsg = GlobalConfig.getConfigDataWithSpecialAppId(key_warningmsg,appid,"");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type">
    <title>文件上传</title>
</head>
<link rel="stylesheet" type="text/css" href="css/resultFile.css"/>
<style type="text/css">
.page-wrap {
    width: 80%;
    margin: 0 auto;
    /* overflow: hidden; */
}

.step-wrap .step-title-wrap > div {
    height: 40px;
    line-height: 40px;
    width: 33%;
    background: #f2f2f2;
    float: left;
    cursor: pointer;
    margin-bottom: 10px;
}

.step-wrap .step-title-wrap .first-step {
    border-radius: 7px 0 0 7px;
}

.step-wrap .step-title-wrap .sec-setp {
    margin: 0 3px;
}

.step-wrap .step-title-wrap .third-step {
    border-radius: 0px 7px 7px 0px;
}

.step-wrap .step-title-wrap .active {
    background-color: #3e86f2;
    color: #fff;
}

.step-wrap .cont {
    height: 270px;
    overflow: auto;
    box-sizing: border-box;
}

.step-wrap .first-step-cont {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
}

.step-wrap .first-step-cont a {
    text-decoration: none;
    color: #00f;
}

.step-wrap .sec-setp-cont, .step-wrap .third-setp-cont {
    text-align: left;
    clear: both;
    padding: 10px;
    box-sizing: border-box;
    display: none;
    border: 2px solid #f0f0f0;
}

.step-wrap .sec-setp-cont li {
    list-style: none;
    line-height: 30px !important;
}

span {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    display: inherit;
}

span:hover {
    overflow: visible;
}

</style>
<script type="text/javascript"
        src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/frameworksupport.js"></script>
<script type="text/javascript"
        src="../setting/zjtempdata/js/xlsx.core.min.js"></script>
<script type="text/javascript"
        src="../setting/zjtempdata/js/xlsx.full.min.js"></script>
<%
    String path = request.getContextPath();
    String menuid = request.getParameter("menuid");
%>
<body style="height:450px;">
<form id="demoForm" name="demoForm" httpMethod="post" enctype="multipart/form-data"
      action="javascript: uploadAndSubmit();" style="height:350px;">
    <div class="page-wrap">
        <div class="step-wrap">
            <div class="step-title-wrap">
                <div class="active first-step">第一步：选择文件</div>
                <div class="sec-setp">第二步：上传文件</div>
                <div class="third-step">第三步：导入完成</div>
            </div>
            <div class="cont first-step-cont">
<%--                <a target="_blank" href = "file/ss.jpg" >图片</a><br>--%>
<%--                <a target="_blank" href = "ss.jpg" >图片1</a><br>--%>
<%--                <a target="_blank" href = "file/导入监审结果-模板.zip" >图片3</a><br>--%>
                <p>如果没有文件模板文件，请下载
                    <a href="javascript:download();" onclick="javascript:download();">excel</a>模板文件
<%--
                    <a target="_blank" href="file/导入监审结果-模板.zip" download="导入监审结果-模板.zip">excel</a>模板文件
--%>
                    <br><font style="color: red;height: 36px;margin-left: 138px;font-size: 13px;"><%=warningmsg %></font>
                </p>
            </div>
            <div id="filepath" class="cont sec-setp-cont"></div>
            <div id="filepathsta" class="progressbar cont third-setp-cont">
                <div id="div1" class="div1" style="float:left;width:380px">
                </div>
                <div id="div2" class="div2" style="float:right;width:180px">
                </div>
            </div>
            </div>
    </div>

    <div class="new-contentarea" style="text-align:center;">
        <a href="javascript:void(0)" class="upload-file"><label for="upload-file">上传文件</label></a>
        <input type="file" name="file" id="upload-file" accept=".xls,.xlsx" multiple
               style="right:50%;margin-right:-83px;"/>
        <input type="hidden" id="menuid" value="<%=path%>">
    </div>
    <div id="execute" class="execute">
        <button>立即执行</button>
    </div>
    <div id="executes" class="execute">
        <button onclick="startScroll(this)">导入完成</button>
    </div>
</form>

<script type="text/javascript">
    var responseWind = parent;
    responseWind.Ext.lt.layout.doLayout();
    var url = "../supervisionController/importExcel.do?tokenid=" + getUrlParam('tokenid', responseWind.location.search);

    function getUrlParam(val, url) {
        var uri = url || window.location.search;
        var re = new RegExp("(\\?|&)" + val + "\=([^\&\?]*)", "ig");
        return ((uri.match(re)) ? (uri.match(re)[0].substr(val.length + 2)) : null);
    }

    $("#upload-file").change(function () {
        var form = document.forms["demoForm"];
        var file = form["file"];
        var path = "";
        for (var i = 0; i < file.files.length; i++) {
            path += "<li style='line-height:20px;'>文件名称: '" + file.files[i].name + "' 大小 '" + file.files[i].size / 1024 + "KB</li>"
            //path = path + file.files[i].name + "</br>";
        }

        for (var i = 0; i < $(this).get(0).files.length; ++i) {
            var filePath = $(this).val();
        }
        if (path != null && path != "") {
            $(".first-step-cont").css("display", "none");
            $(".sec-setp-cont").css("display", "block");
            $(".new-contentarea").css("display", "none");
            $(".progressbar").css("display", "none");
            $(".execute").css("display", "block");
            //$(".executes").css("display","none");
            $("#executes").attr("style", "display:none");
            $(".message1").css("display", "none");
            $(".message").css("display", "none");
            $(".step-title-wrap").children().removeClass('active');
            $(".sec-setp").addClass('active');
        }
        /*if (path != null && path != "") {
            $(".new-contentarea").css("display","none");
            $(".progressbar").css("display","none");
            $(".execute").css("display","block");
            $(".message1").css("display","none");
        } */
        $("#filepath").html(path);
    });

    function uploadAndSubmit() {
        $(".new-contentarea").css("display", "none");
        $(".progressbar").css("display", "block");
        //$(".execute").css("display", "none");
        var form = document.forms["demoForm"]["file"];
        var reader = new FileReader();
        if (form.files.length > 0) {
            reader.onloadstart = function () {
                $("#message").html("开始校验...");
            };
            var arr = [];
            for (var i = 0; i < form.files.length; i++) {
                var flag = 0;
                var file = form.files[i];
                SetProgress(((i + 1) / form.files.length * 100).toFixed(2));
                $("#message").html("正在校验第" + (i + 1) + "条数据(" + form.files[i].name + ")...").fadeIn("slow");
                var fileName = form.files[i].name;
                var fileSplit = fileName.split(".");
                debugger;
                if (fileSplit.length == 2) {
                    //判断上传文件的类型
                    if (!(fileSplit[1] == 'xls' || fileSplit[1] == 'xlsx')) {
                        $("#message").html("导入失败...");
                        arr.push(fileName + "&&请上传execl文件&&1")
                        flag++;
                        //SetMessage("请上传execl文件...");
                        //return;
                    }
                } else {
                    $("#message").html("导入失败...");
                    arr.push(fileName + "&&文件格式错误(文件名称.xls/文件名称.xlsx)&&1")
                    flag++;
                    //SetMessage("文件名称格式错误(文件名称.xls/文件名称.xlsx)...");
                    //return;
                }
                if (flag == 0) {
                    var formData = new FormData();
                    formData.append("file", file);
                    formData.append("menuid", Request("menuid"));
                    //注意：这里append进去的是File对象，而不是FileList对象
                    //formData.append("file", file);
                    //formData.append("appid", "perf");
                    /*reader.onprogress = function(p) {
                        $("#message").html("正在导入 (Bytes：" + p.loaded + "/" + file.size")...");
                    };*/
                    //SetProgress(((i + 1) / form.files.length * 100).toFixed(2));
                    $("#message").html("正在导入第" + (i + 1) + "条数据(" + form.files[i].name + ")...").fadeIn("slow");
                    /*var config = {};
                    config.appid = "111";
                    var config = Ext.lt.RCP.asynserver("pmkpi.randomcomment.RandomCommentResultService", "fileUpload", config);
                    if(config.error){
                        $("#message1").html("失败!");
                    }else{
                        $("#message").html("完成导入!").fadeIn("slow");
                    }*/
                    $.ajax({
                        //url : "/pmkpi/fileController/fileUpload1.do",
                        url: url,
                        //enctype: "multipart/form-data",
                        type: "POST",
                        dataType: "json",
                        async: false,
                        cache: false,
                        processData: false,
                        contentType: false,
                        data: formData,
                        success: function (data) {
                            if (data.success) {
                                arr.push(fileName + "&&" + data.code + "&&0")
                                $("#message").html(data.code).fadeIn("slow");
                            } else {
                                arr.push(fileName + "&&" + data.code + "&&1")
                                //SetMessage(data.code);
                            }
                        }
                        //error : function(data) {
                        //		SetMessage("导入失败!");
                        //}
                    });
                }
            }
            ;
            fileStatus(arr);
            $(".step-title-wrap").children().removeClass('active');
            $(".third-step").addClass('active');
            $(".sec-setp-cont").css("display", "none");
            $(".execute button").text('导入完成');
            $(".third-setp-cont").css("display", "block");
            //$("#message").html("执行成功...");
            $("#demoForm .execute").css("marginTop", "0")
            $("#execute").attr("style", "display:none");
            $("#executes").attr("style", "display:block");
            //fileSubmit();
            //reader.onload = function() {};
        }
    }

    function fileSubmit() {
        var form = document.forms["demoForm"]["file"];
        var reader = new FileReader();
        if (form.files.length > 0) {
            SetProgress((0.00).toFixed(2));
            $("#message").html("开始导入...");
            for (var i = 0; i < form.files.length; i++) {
                //从零开始创建FormData对象 手动注入
                var file = form.files[i];
                //var formData = new FormData($("#demoForm")[0]);
                var formData = new FormData();
                formData.append("file", file);
                formData.append("menuid", Request("menuid"));
                //注意：这里append进去的是File对象，而不是FileList对象
                //formData.append("file", file);
                //formData.append("appid", "perf");
                /*reader.onprogress = function(p) {
                    $("#message").html("正在导入 (Bytes：" + p.loaded + "/" + file.size")...");
                };*/

                SetProgress(((i + 1) / form.files.length * 100).toFixed(2));
                $("#message").html("正在导入第" + (i + 1) + "条数据(" + form.files[i].name + ")...").fadeIn("slow");
                /*var config = {};
                config.appid = "111";
                var config = Ext.lt.RCP.asynserver("pmkpi.randomcomment.RandomCommentResultService", "fileUpload", config);
                if(config.error){
                    $("#message1").html("失败!");
                }else{
                    $("#message").html("完成导入!").fadeIn("slow");
                }*/
                $.ajax({
                    //url : "/pmkpi/fileController/fileUpload1.do",
                    url: url,
                    //enctype: "multipart/form-data",
                    type: "POST",
                    dataType: "json",
                    async: false,
                    cache: false,
                    processData: false,
                    contentType: false,
                    data: formData,
                    success: function (data) {
                        if (data.success) {
                            $("#message").html(data.code).fadeIn("slow");
                        } else {
                            SetMessage(data.code);
                        }
                    },
                    error: function (data) {
                        SetMessage("导入失败!");
                    }
                });
            }
            $("#message").html("执行成功...");
        }


    }

    function fileStatus(arr) {
        if (arr.length > 0) {
            var div1 = "";
            var div2 = "";
            for (var j = 0; j < arr.length; j++) {
                var split = arr[j].split("&&");
                var name = split[0];
                var sta = split[1];
                var i = split[2];
                div1 += "<span>" + name + "</span>"
                if (i == 0) {
                    div2 += "<span style='color:#3e86f2'>" + sta + "</span>"
                } else if (i == 1) {
                    div2 += "<span style='color:#f23e4f'>" + sta + "</span>"
                }
            }
            $("#div1").html(div1);
            $("#div2").html(div2);
        }
    }
    function download() {
        var aoa = [
            ['监审意见', '其它意见', '项目名称', '预算资金（万元）','一级指标','二级指标', '三级指标', '指标值', '权重','入库状态','预算单位','处室', '一级项目名称', '流程状态', '是否事前评估']
        ];
        var sheet = XLSX.utils.aoa_to_sheet(aoa);
        openDownloadDialog(sheet2blob(sheet), '导入监审结果-模板.xlsx');
    }
    function openDownloadDialog(url, saveName)
    {
        if(typeof url == 'object' && url instanceof Blob)
        {
            url = URL.createObjectURL(url); // 创建blob地址
        }
        var aLink = document.createElement('a');
        aLink.href = url;
        aLink.download = saveName || ''; // HTML5新增的属性，指定保存文件名，可以不要后缀，注意，file:///模式下不会生效
        var event;
        if(window.MouseEvent) event = new MouseEvent('click');
        else
        {
            event = document.createEvent('MouseEvents');
            event.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
        }
        aLink.dispatchEvent(event);
    }
    // 将一个sheet转成最终的excel文件的blob对象，然后利用URL.createObjectURL下载
    function sheet2blob(sheet, sheetName) {
        sheetName = sheetName || 'sheet1';
        var workbook = {
            SheetNames: [sheetName],
            Sheets: {}
        };
        workbook.Sheets[sheetName] = sheet;
        // 生成excel的配置项
        var wopts = {
            bookType: 'xlsx', // 要生成的文件类型
            bookSST: false, // 是否生成Shared String Table，官方解释是，如果开启生成速度会下降，但在低版本IOS设备上有更好的兼容性
            type: 'binary'
        };
        var wbout = XLSX.write(workbook, wopts);
        var blob = new Blob([s2ab(wbout)], {type:"application/octet-stream"});
        // 字符串转ArrayBuffer
        function s2ab(s) {
            var buf = new ArrayBuffer(s.length);
            var view = new Uint8Array(buf);
            for (var i=0; i!=s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
            return buf;
        }
        return blob;
    }

    function startScroll(btn) {
        var el = window.parent.document.getElementById('ttttt');
        el.style.display = 'none';
        parent.Ext.lt.HTML.unmark();
        parent.Ext.lt.pmkpi.query();
    }

    function SetMessage(message) {
        if (message) {
            $("#message").attr("style", "display:none");
            $("#message1").html(message);
            $(".new-contentarea").css("display", "block");
            $(".execute").css("display", "none");
        }
    }

    function SetProgress(progress) {
        if (progress) {
            $("#loading div").first().css("width", String(progress) + "%"); //控制#loading div宽度
            $("#loading div").last().html(String(progress) + "%"); //显示百分比
        }
    }


    function Request(strName) {
        var strHref = window.document.location.href;
        var intPos = strHref.indexOf("?");
        var strRight = strHref.substr(intPos + 1);

        var arrTmp = strRight.split("&");
        for (var i = 0; i < arrTmp.length; i++) {
            var arrTemp = arrTmp[i].split("=");

            if (arrTemp[0].toUpperCase() == strName.toUpperCase())
                return arrTemp[1];
        }
        return "";
    }
</script>
</body>
</html>