if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};
if(!Ext.lt.pmkpi.rectification.finfeedback)
    Ext.lt.pmkpi.rectification.finfeedback = {};

Ext.lt.pmkpi.rectification.finfeedback.info = function(config, service){
    var cmp = {};
    var _mainguid = config.mainguid,
    _guid = config.guid,
    _projguid = config.projguid,
    _projcode = config.projcode,
    _bustype = config.bustype,
    _type = config.type,
    _workflow = config.workflow;

    $(function () {
        cmp.writeBack();
    })

    cmp.writeBack = function(){
        var params = {};
        params.mainguid=_mainguid;
        params.guid=_guid;
        params.projguid=_projguid;
        var resule = Ext.lt.RCP.asynserver("pmkpi.rectification.RectificationAddService", "getText", params);
        editform.synchEditformByObj(resule);
        if(!resule){
            drawlist(window.document);
            return;
        }
        drawlist(resule.rectifycontent,false);
    }


    //保存
    cmp.save = function (){
        if (!editform.check()) return;//先校验
        var params = editform.getEditFormValues();
        params.rectifycontent=UE.getEditor("input").getContent();
        params.projguid=_projguid;
        params.projcode=_projcode;
        params.bustype=_bustype;
        params.type=_type;
        params.workflow=_workflow;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "save", params, function(rs){
            if(rs.error){
                Ext.lt.ui.alert(rs.error);
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.closeModalWindow();// 关闭
                window.parent.cmp.query();// 刷新
            } else{
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                    Ext.lt.ui.closeModalWindow();// 关闭
                    parent.parent.cmp.query();// 刷新
                });
            }
        });
    }
    return cmp;
}

//任务内容
function drawlist(context){
    if(document.getElementById("myDiv")==null){
        var obj=document.createElement("div");
        obj.id="myDiv";
        obj.style.width="99%";
        obj.style.height="90%";
        obj.style.margin="0 5px 0 0";
        obj.style.position="relative";
        $(".bd_main").append(obj);
    }
    if(document.getElementById("myDivone")==null){

        var objone=document.createElement("div");
        objone.id="myDivone";
        objone.style.height="0px";
        objone.style.width="99.8%";
        objone.style.margin="0px";
        objone.style.fontSize="12px";
        $("#myDiv").append(objone);
    }
    if(document.getElementById("myDivtwo")==null){
        var objtwo=document.createElement("div");
        objtwo.id="myDivtwo";
        objtwo.style.height="98%";
        objtwo.style.width="99.8%";
        objtwo.style.margin="0";
        //objtwo.style.padding="0 0 0 50px";
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
