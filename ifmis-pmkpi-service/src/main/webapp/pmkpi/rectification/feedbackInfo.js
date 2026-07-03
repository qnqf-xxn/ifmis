if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};
if(!Ext.lt.pmkpi.rectification.feedback)
    Ext.lt.pmkpi.rectification.feedback = {};

Ext.lt.pmkpi.rectification.feedback.info = function(config, service){
    var cmp = {};
    var _mainguid = config.mainguid;
    var _guid = config.guid;
    var _queryYear = config.queryYear,//跨年查询查询年度
    _queryProvince = config.queryProvince;//跨年查询查询区划

    $(function () {
        cmp.writeBack(true);
    })

    cmp.writeBack = function(isquery){
        var params = {};
        params.mainguid=_mainguid;
        params.guid=_guid;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        var resule = Ext.lt.RCP.asynserver("pmkpi.rectification.FeedbackInfoService", "getText", params);
        editform.synchEditformByObj(resule);
        if(!resule){
            drawlist(window.document);
            return;
        }
        drawlist(resule.feedbackcontent,false);
        if (isquery) {
            parent._isQuery = true;
        }
    }

    //反馈信息详情保存
    cmp.save = function (){
        if(!check()){
            return;
        }
        var params = {};
        params.backcontent=UE.getEditor("input").getContent();
        params.mainguid=_mainguid;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        isSaveMain = true;
        // cmp.query();
        return rs;
    }
    return cmp;
}

//任务内容
function drawlist(context){
    if(document.getElementById("myDiv")==null){
        var obj=document.createElement("div");
        obj.id="myDiv";
        //obj.style.border="1px solid #000000";
        obj.style.width="99%";
        obj.style.height="90%";
        obj.style.margin="0 5px 0 0";
        obj.style.position="relative";
        //obj.style.display = "none";
        $(".bd_main").append(obj);
    }
    if(document.getElementById("myDivone")==null){

        var objone=document.createElement("div");
        objone.id="myDivone";
        //objone.style.border="1px solid #000000";
        objone.style.height="0px";
        objone.style.width="99.8%";
        objone.style.margin="0px";
        objone.style.fontSize="12px";
//		objone.style.position="relative";
        $("#myDiv").append(objone);
    }
    if(document.getElementById("myDivtwo")==null){
        var objtwo=document.createElement("div");
        objtwo.id="myDivtwo";
        //objtwo.style.border="1px solid #000000";
        objtwo.style.height="98%";
        objtwo.style.width="99.8%";
        objtwo.style.margin="0";
        //objtwo.style.padding="0 0 0 50px";
        objtwo.style.position="relative";
        $("#myDiv").append(objtwo);
    }
    var htmlTextare="<textarea id='input' style='width:100%; height:90%'></textarea> ";
    $("#myDivtwo").html("");
    $("#myDivtwo").append(htmlTextare);
    UE.delEditor('input');
    var ue = UE.getEditor("input",{
        autoHeightEnabled : false,
        allowDivTransToP :false, //禁止将div转换为p
        zIndex: 1 //编辑器层级
    });

    ue.addListener("ready", function() {ue.setContent(context)});
}

function check() {
    var text=UE.getEditor("input").getContentTxt();
    if(text==""){
        alert("任务内容不能为空！");
        return false;
    }
    if(text.length>5000){
        alert("任务内容不能大于5000！");
        return false;
    }

    return true;
}

UE.registerUI('expdoc', function (editor, uiName) {
    return new UE.ui.Button({
        name: uiName,
        title: '导出world',  // 这里是设置当鼠标指向这个按扭时显示的文字
        onclick: function () {
            var content = UE.getEditor("input").getContent();
            var idObject = document.getElementById("Uedocfileform");
            if (idObject != null){
                idObject.parentNode.removeChild(idObject);
            }
            var url = "/pmkpi/ueditor/export/expdoc.do?tokenid=" + Ext.lt.token.getTokenid();
            var form=$("<form>");//定义一个form表单
            form.attr("id","Uedocfileform");
            form.attr("style","display:none");
            form.attr("target","");
            form.attr("method","post"); //请求类型
            form.attr("action",url); //请求地址
            $("body").append(form);//将表单放置在web中
            var tempinput=$("<input>");
            tempinput.attr("type","hidden");
            tempinput.attr("id","content");
            tempinput.attr("name","content");
            tempinput.attr("value",content);
            form.append(tempinput);
            form.submit();
        }
    });
}, [1, ['editor']]);
