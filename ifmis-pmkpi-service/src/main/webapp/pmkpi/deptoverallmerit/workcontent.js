if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.workcontent){
	Ext.lt.pmkpi.workcontent = {};
}

Ext.lt.pmkpi.workcontent = function(config, service){
    var serviceid = service,
        _mainguid = config.mainguid,
        _projguid = config.projguid,
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _contenttype = config.contenttype,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _findex;//一级指标
    var cmp = {};
    
    Ext.lt.message.hook("editform", "drawed",function(obj){
    	var config = obj.configs;
    });

    cmp.query = function(){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.viewtype = _viewtype;
        params.contenttype = _contenttype;
        var read = "edit"==_viewtype ? false : true;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
        	var editobject = rs.data[0];
        	editform.synchEditformByObj(editobject);
        	if(!editobject){
        		drawlist("",read);
        		Ext.lt.ui.loadingClose();
        		return;
        	}
        	drawlist(editobject.content,read);
        	Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        if (!editform.check()) return false;//先校验
        var params = {};
        params.datas = editform.getEditFormValues();
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.busguid = _busguid;
        params.contenttype = _contenttype;
        params.content=UE.getEditor("input").getContent();
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        cmp.query();
        return rs;
    }

    $(function () {
        debugger
        cmp.query();
    })

    return cmp;
}


//任务内容
function drawlist(context,read){
    if(document.getElementById("myDiv")==null){
        var obj=document.createElement("div");
        obj.id="myDiv";
        //obj.style.border="1px solid #000000";
        obj.style.width="99.6%";
        if(read){
            obj.style.height="94%";
        }else{
            obj.style.height="90%";
        }
        obj.style.margin="10px 5px 0 0";
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
//                objone.style.position="relative";
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

    if(read){
        var htmlTextare="<textarea id='input' style='width:99.8%; height:100%'></textarea> ";
        $("#myDivtwo").html("");
        $("#myDivtwo").append(htmlTextare);
        UE.delEditor('input');
        var ue = UE.getEditor("input",{
            autoHeightEnabled : false,
            allowDivTransToP :false, //禁止将div转换为p
            zIndex: 1, //编辑器层级
            toolbars:[],
            wordCount:false,
            readonly:true
        });
        ue.addListener("ready", function() {ue.setContent(context)});
    }else{
        var htmlTextare="<textarea id='input' style='width:99.8%; height:90%'></textarea> ";
        $("#myDivtwo").html("");
        $("#myDivtwo").append(htmlTextare);
        UE.delEditor('input');
        var ue = UE.getEditor("input",{
            //scaleEnabled:true,
            autoHeightEnabled : false,
            maximumWords:10000,
            allowDivTransToP :false, //禁止将div转换为p
            zIndex: 1 //编辑器层级
        });
        ue.addListener("ready", function() {ue.setContent(context)});
    }
}