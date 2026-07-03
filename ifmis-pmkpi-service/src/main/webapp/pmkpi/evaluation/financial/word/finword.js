if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.finword)
    Ext.lt.pmkpi.finword = {};
var windowx;
var isSaveMain=false;//评价类型信息是否已保存
var curnode;//当前树节点
var tabsid; // 左侧树节点ID
var busIsHidden;
var mainguid;
var editformobj;
var projcode;
var projguid;
Ext.lt.pmkpi.finword = function(config, service){
    var cmp = {};
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    serviceid = config.serverid;
    _proguid = config.proguid;
    _procode = config.procode;
    _mainguid = config.mainguid;
    _bustype = config.bustype;
    _type = config.type;


    $(function () {
        //cmp.init(config);
        cmp.writeBack();
    })

    cmp.writeBack = function(){
        var params = {};
        params.mainguid=_mainguid;
        params.proguid = _proguid;
        params.procode = _procode;
        params.type = _type;
        var resule =  Ext.lt.RCP.asyncall(service, "getText", params);
        //editform.synchEditformByObj(resule);
        if(resule){
            if(_type == "1"){
                drawlist(resule.finword);
            } else {
                drawlist(resule.finreport);
            }
        }

    }


    cmp.save = function (){
        if(!check()){
            return;
        }
        var params = {};
        params.backcontent=UE.getEditor("input").getContent();
        params.mainguid=_mainguid;
        params.type = _type;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        Ext.lt.ui.loadingClose();
        isSaveMain = true;
        // cmp.query();
        return rs;
    }
    return cmp;
}

$(window).resize(function () {          //当浏览器大小变化时
    var scrWidth=document.body.clientWidth;
    var scrHeight=document.body.clientHeight;
    if(windowx){windowx.resize(scrWidth, scrHeight);}
});

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
        alert("方案内容不能为空！");
        return false;
    }
    if(text.length>5000){
        alert("方案内容不能大于5000！");
        return false;
    }
    return true;
}
