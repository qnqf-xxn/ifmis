if (Ext.lt.pmkpi == null) {
    Ext.lt.pmkpi = {};
}
//初始化页面
var serviceid;
var QTree;
var saveMaps = {}; //存放部门对应的授权。key-value.
var saveobj = {}; //存放部门对应的授权类型整体。key-value.
var _currdept = "";//当前选中的部门行
Ext.lt.pmkpi.finagiveedit = function(config, service) {
    var cmp = {},
        qtreedatas,
    serviceid = service;
    var _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight;
    var depts =config["depts"]; //部门
    var elements =config["elements"]; //分类

    //页面加载后执行构建页面
    $(document).ready(function(){
        //构造头部页面
        Ext.lt.pmkpi.initMainDiv();
        depttable.draw(tablediv);
        var tempwidth = $("#tablediv").width();
        depttable.resize(tempwidth,_scrHeight*0.90);
        depttable.setDatas(depts);
        $("#treediv").height(_scrHeight*0.89);
        var qtreediv = document.getElementById('treediv');
        menuQTree = Ext.lt.pmkpi.createTree(elements,[]);
        menuQTree.draw(qtreediv);
        //绑定列表的点击事件
        depttable.onEvent('onclick', function (td, el, l, c, d) {
            if(d.check==1){
                var key = d.code;
                //切换先处理左侧树勾选的消息
                if(_currdept != key && _currdept != ""){
                    var tempguids = new Array();
                    var tempselectd = QTree.getSelected();
                    if(tempselectd.length == 0){
                        tempselectd = [];
                    }
                    var temparrs = Ext.lt.cloneobj(tempselectd);
                    $.each(temparrs, function(i, item){
                        tempguids.push(item["guid"]);
                    });
                    saveMaps[_currdept] =  tempguids;
                    saveobj[_currdept] = temparrs;
                }
                var qtreediv = document.getElementById('treediv');
                var key = d.code;
                if (!saveMaps[key]){
                    var params = {};
                    params.deptcode = key;
                    Ext.lt.ui.loadingShow();
                    var rs = Ext.lt.RCP.asyncall(serviceid , "findDeptEles", params);
                    if(rs.length == 0){
                        rs = [];
                    }
                    saveobj[key] =  rs;
                    var tempguids = new Array();
                    $.each(rs, function(i, item){
                        tempguids.push(item["eltwoguid"]);
                    });
                    saveMaps[key] =  tempguids;
                    Ext.lt.ui.loadingClose();
                }
                menuQTree = Ext.lt.pmkpi.createTree(elements,saveMaps[key]);
                menuQTree.draw(qtreediv);
                //处理完成后
                _currdept = d.code;
            }
        });
    });
    //右侧区域填写html脚本
    Ext.lt.pmkpi.initMainDiv = function() {
        var headhtml = ' <div id="main_div" width= "700px"> ';
        headhtml += ' <table width="100%" heigth="460px" border="0"> ';
        headhtml += ' <tr><th width="49%" align="left"><span>&nbsp;预算部门：</span></th><th width="49%" align="left">&nbsp;行业类别：</th></tr> ';
        headhtml += '<tr><td colspan="2" height="6px"></td></tr>';
        headhtml += ' <tr><td><div id="tablediv"  name="tablediv"></div>';
        headhtml += ' </td><td> ';
        headhtml += ' <div id="treediv" width="98%" style="border:1px solid #ddd;margin-top:0px;"></div></td> ';
        headhtml += ' </tr></table>';
        headhtml += ' </div> ';
        $(".bd_main").append(headhtml);
        $(".bd_main").css("overflow","hidden");
    }

    /*
      *初始化以及重建数结构.
     */
    Ext.lt.pmkpi.createTree =  function (data ,seldatas) {
        qtreedatas = data;
        QTree = new Ext.lt.Qtree({
            data : data,
            classname : "pop",
            selectmode : "n",
            outformart : '#code-#name',
            linkchild:true,
            complementary:false,
            values: seldatas,
            field : {
                id : "guid",
                name : "name",
                code : "code",
                sid : "superguid",
                level : "levelno",
                isleaf : "isleaf"
            },
            on : {
                'nodeclick' : function() {},
                'click' : function() {}
            }
        });
        return QTree;
    }

    /**
     * 关闭窗口
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    /**
     * 保存
     */
    cmp.save = function () {
        //处理最后一次勾选，给全局变量赋值
        var tempguids = new Array();
        var tempselectd = QTree.getSelected();
        if(tempselectd.length == 0){
            tempselectd = [];
        }
        var temparrs = Ext.lt.cloneobj(tempselectd);
        $.each(temparrs, function(i, item){
            tempguids.push(item["guid"]);
        });
        saveMaps[_currdept] =  tempguids;
        saveobj[_currdept] = tempselectd;
        var params = {};
        params.depteles = saveobj;
        var resp = Ext.lt.RCP.asyncall(service, "saveFinaGive",
            params, function(resp) {});
        if(resp.flag == true){
            Ext.lt.ui.alert("保存成功！",{timeout:1},function(){});
            parent.Ext.lt.ui.modalWindow.close();
            parent.indexfinagive.query();
        } else {
            Ext.lt.ui.alert("保存失败！请联系管理员！",{timeout:1},function(){});
        }
    }

    return cmp;
}
