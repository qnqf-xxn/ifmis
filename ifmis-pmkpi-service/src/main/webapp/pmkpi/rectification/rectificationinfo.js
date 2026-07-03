if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};

Ext.lt.pmkpi.rectification.info = function(config, service){
    var cmp = {};
    var projguid = config.projguid;
    var projcode = config.pro_code;
    var _bustype = config.bustype;
    var _type = config.type;
    var _workflow = config.workflow;
    var editformobj = config.rectifyinfo;
    var isSaveMain=false;//评价类型信息是否已保存

    $(function () {
        cmp.writeBack();
    })

    cmp.writeBack = function(){
        if (editformobj) {
            editform.synchEditformByObj(editformobj);
            drawlist(editformobj.rectifycontent);
        }
    }

    cmp.infosave = function(){
        if (!editform.check()) return;//先校验
        var params = editform.getEditFormValues();
        var rs = Ext.lt.RCP.asyncall(service , "infosave", params);
        Ext.lt.ui.loadingClose();
        isSaveMain = true;
        return rs;
    }

    //保存
    cmp.save = function (){
        if (!editform.check()) return;//先校验
        var params = editform.getEditFormValues();
        params.projguid=projguid;
        params.projcode=projcode;
        params.bustype=_bustype;
        params.type=_type;
        params.workflow=_workflow;
        params.rectifycontent = editformobj.rectifycontent;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "save", params, function(rs){
            if(rs.error){
                Ext.lt.ui.alert(rs.error);
                Ext.lt.ui.loadingClose();
            } else{
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                });
            }
        });
    }
    return cmp;
}

//任务内容
function drawlist(context,read){
    if(document.getElementById("myDiv")==null){
        var obj=document.createElement("div");
        obj.id="myDiv";
        //obj.style.border="1px solid #000000";
        obj.style.width="99.6%";
        obj.style.height="94%";
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

    var htmlTextare="<textarea id='input' style='width:99.8%; height:100%'></textarea> ";
    $("#myDivtwo").html("");
    $("#myDivtwo").append(htmlTextare);
    UE.delEditor('input');
    var ue = UE.getEditor("input",{
        //initialFrameHeight : 610, //编辑器高度
        autoHeightEnabled : false,
        allowDivTransToP :false, //禁止将div转换为p
        zIndex: 1, //编辑器层级
        toolbars:[],
        wordCount:false
        //readonly:true
    });
    if(null!=context&&""!=context){
        ue.addListener("ready", function() {ue.setContent(context)});
    }
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
