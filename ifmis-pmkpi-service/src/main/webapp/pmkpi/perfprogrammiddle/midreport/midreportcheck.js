if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.midprogrm){
    Ext.lt.pmkpi.midprogrm = {};
}
if(!Ext.lt.pmkpi.midprogrm.midcheckservice){
    Ext.lt.pmkpi.midprogrm.midcheckservice= {};

}
Ext.lt.pmkpi.midprogrm.midcheckservice = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,//工作流guid
        _prolev = config.prolev,//项目级次
        _saveAgency = config.saveAgency,//单位
        _menuid = config.menuid,//菜单
        _isleaf = config.isleaf,
        _defquerysql = {},
        _bustype = config.bustype,//业务类型，项目/部门/政策
        _tablecode,//查询表名
        _tablesql//表过滤条件
        ;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquerysql = eval('(' + uiconfig.config + ')');
        _tablesql = _defquerysql["nzpro"];
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
        params.lefttabtype = _bustype;
        params.nodeguid = _saveAgency;
        params.isleaf = _isleaf;
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.midperfprogram.midCheckBOTX";
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
            });
            Ext.lt.ui.loadingClose();
        }, function(rs) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(rs,function(){
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