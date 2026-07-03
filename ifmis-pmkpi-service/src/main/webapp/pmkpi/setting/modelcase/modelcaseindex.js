if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.modelcaseindex)
    Ext.lt.pmkpi.modelcaseindex = {};

Ext.lt.pmkpi.modelcaseindex = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    window.parent.Ext.lt.pmkpi.childwindow = window;
    var serviceid = service;
    var _mainguid = config.mainguid,
        _tabData = config.tabData,
        _framesystem = config.framesystem,
        _findex,
        _tabData,
        _viewtype = config.viewtype;//区分是否查询:query是查询，其他可修改
    //根据组件id存放表名
    Ext.lt.pmkpi.isadd = false;
    var cmp = {};
    var tabobj;
    var isfirst = true;

    /**
     * 基础信息保存
     */
    cmp.infosave = function (obj){
        var params= {};
        if(_viewtype == "add"){
            Ext.lt.pmkpi.isadd = true;
        }
        params.framesystem = _framesystem;
        params.isadd = Ext.lt.pmkpi.isadd;
        commoncmp.savedatas(obj, params);
    }

    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        commoncmp.initDatatable(indexdatatable);
        if (_viewtype == "query") {
            for (var i=0; i < _tabData.length; i++){
                var tabconfig = eval('(' + _tabData[i].config + ')');
                var id = _tabData[i].componentid;
                commoncmp.tabinitpage(id,tabconfig);
            }
            document.getElementById("tabpage").style.display = "none";
            $("div[compid='toolbutton']").hide();
            document.getElementById("add").style.display = "none";
            document.getElementById("del").style.display = "none";
        }
        isfirst = false;
        commoncmp.tabpageOnclick(tabobj, _tabData, toolbutton);
    });

    /**
     * 页签方法
     */
    cmp.clickTabpage = function(obj){
        if (!isfirst) {
            commoncmp.tabpageOnclick(obj, _tabData, toolbutton);
        } else {
            tabobj = obj;
            _tabData = tabpage.cfg.data;
        }
    }

    /**
     * 切换页签理消息
     */
    Ext.lt.message.hook("perfcommon", "clicktabpage",function(obj){
        var params = obj.params;
        params.mainguid = _mainguid;
        params.framesystem = _framesystem;
    });

    /**
     * 点击编辑区类型处页签理消息
     */
    Ext.lt.message.hook("perfcommon", "editinit",function(obj){
        var params = obj.params;
        params.mainguid = _mainguid;
        params.framesystem = _framesystem;
        params.uikey = eval(obj.id).cfg["key"];
        params.pagetype = eval(obj.id).cfg["pagetype"];
    });

    Ext.lt.message.hook("perfcommon", "tableinit",function(obj){
        var params = obj.params;
        params.mainguid = _mainguid;
        params.framesystem = _framesystem;
    });

    /**
     * 保存编辑区之前封装参数
     */
    Ext.lt.message.hook("perfcommon", "beforeEditsave",function(obj){
        var params = obj.params;
        params.uikey = eval(obj.id).cfg["key"];
        params.pagetype = eval(obj.id).cfg["pagetype"];//区分主编辑区
    });

    /**
     * 保存表格之前封装参数
     */
    Ext.lt.message.hook("perfcommon", "beforeTablesave",function(obj){
        var params = obj.params;
        params.uikey = eval(obj.id)["key"];
        params.framesystem = _framesystem;
    });

    /**
     * 表格查询方法处理.
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(obj){
        var parm;
        if (_table_param[obj.componentid + "_totaltag"] == 1) {
            setTimeout(function(){
                commoncmp.amtTotal(eval(obj.componentid));
            },100);
        }
    });

    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    /**
     * 重画表格
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        var componentid = config.id;
        _table_param[componentid] = obj.uiconfig.tablecode;
        _table_param[componentid + "_defquery"] = obj.uiconfig.defquery;
        _table_param[componentid + "_orderby"] = obj.uiconfig.orderby;
        _table_param[componentid + "_totaltag"] = obj.uiconfig.totaltag;
    });

    /**
     * 新增行.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var config = indexdatatable.config;
        var componentid = config.id;
        if(_onclickid == componentid){
            var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
            var newdata ={};
            newdata.guid = newguid;
            newdata.mainguid = _mainguid;
            newdata.rowtype = "add";
            newdata.framesystem = _framesystem;
            Ext.lt.pmkpi.isadd = true;
            eval(_onclickid).getRecordSet().addData(newdata,eval(_onclickid).getRecordSet().toArray().length + 1);
        }
    });

    /**
     * 删除行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var config = indexdatatable.config;
        var componentid = config.id;
        if(_onclickid == componentid){
            var selDatas = eval(_onclickid).getSelected();
            if (selDatas.size() <= 0) {
                Ext.lt.ui.alert('请选择要删除的数据！',function(){
                });
                return;
            }
            Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
                if(is){
                    eval(_onclickid).removeData(selDatas);
                    commoncmp.amtTotal(eval(_onclickid));
                }
            })
        }
    });

    Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
        var cols = data.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="findex"){
                col.oneditstart = function (table, el, l, c, d) {
                    _findex = d.findex;
                }
                col.oneditend = function (table, el, l, c, d) {
                    var findex = d.findex;
                    var sindex = d.sindex;
                    if (!findex || findex==""){
                        d.sindex = "";
                        return false;
                    }
                    if (_findex != findex && sindex && sindex != "") {
                        d.sindex = "";
                        return false;
                    }
                }
            }

            if(col["colcode"]=="sindex"){
                col.oneditstart = function (table, el, l, c, d) {
                    var findex = d.findex;
                    if (!findex || findex==""){
                        Ext.lt.ui.alert('请先选择一级指标！',function(){
                        });
                        return false;
                    }
                }
            }
        }
    });

    return cmp;
}