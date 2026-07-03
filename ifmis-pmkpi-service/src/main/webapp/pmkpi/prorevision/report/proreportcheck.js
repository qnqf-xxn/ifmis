if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.prorevision){
    Ext.lt.pmkpi.prorevision = {};
}
if(!Ext.lt.pmkpi.prorevision.revisioncheckservice){
    Ext.lt.pmkpi.prorevision.revisioncheckservice = {};
}

Ext.lt.pmkpi.prorevision.revisioncheckservice = function(config, service){
    var cmp = {};
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _workflow = config.workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _saveAgency = config.saveAgency,//单位
        _leftmenuid = config.leftmenuid,
        _menuid = config.menuid,//菜单
        _bustype = config.bustype,//业务类型，项目/部门/政策
        _defquerysql = {},
        _tablecode,//查询表名
        _tablesql//表过滤条件
    ;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _defquerysql = eval('(' + uiconfig.config + ')');
        _tablesql = _defquerysql["xdsql"];
        _tablecode = uiconfig.tablecode;
        // _tablesql = config.wheresql;
    });

    cmp.query = function(){
        var params = {};
        params.saveAgency = _saveAgency;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.prolev = _prolev;
        params.type = "check";
        params.menuid = _menuid;
        params.leftmenuid = _leftmenuid;
        params.lefttabtype = _bustype;
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.prorevision.RevisionCheckBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    cmp.save = function(){
        var datas = datatable.getSelected();
        if (!datas || datas.length <= 0) {
            Ext.lt.ui.alert('请选择项目！',function(){
            });
            return;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.datas = datas;
        params.saveAgency = _saveAgency;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        Ext.lt.RCP.call(service , "saveProgramadjust", params, function(rs) {
            Ext.lt.ui.alert('确认成功！',function(){
                Ext.lt.ui.closeModalWindow();
                window.parent.Ext.lt.pmkpi.query();
                window.parent.Ext.lt.pmkpi.querytree();
            });
            Ext.lt.ui.loadingClose();
        }, function(rt) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('确认失败：' + rt,function(){
            });
        });
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        if (_bustype == "program") {
            var page = {};
            page.columns = "*";
            datatable.setPage(page);
            datatable.redraw();
        }
        cmp.query();
    })

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    return cmp;
}