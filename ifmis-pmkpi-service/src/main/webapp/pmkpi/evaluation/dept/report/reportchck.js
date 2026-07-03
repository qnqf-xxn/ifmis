if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.deptevaluation){
    Ext.lt.pmkpi.deptevaluation = {};
}

Ext.lt.pmkpi.deptevaluation.checkservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,//工作流guid
        _leftmenuid = config.leftmenuid,//隐藏菜单
        _prolev = config.prolev,//项目级次
        _saveAgency = config.saveAgency,//单位
        _menuid = config.menuid,//菜单
        _hidename = config.hidename,
        _bustype = config.bustype,//业务类型，项目/部门/政策
        _tablecode,//查询表名
        _tablesql//表过滤条件
    ;
    var _isNINGXIA = config.isNINGXIA;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        if (_bustype == "program") {
            var _defquerysql = eval('(' + uiconfig.config + ')');
            _tablesql = _defquerysql["depteval"];
        }else{
            _tablesql = uiconfig.defquery;
        }
    });

    cmp.query = function() {
        var params = {};
        params.saveAgency = _saveAgency;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.hidename = _hidename;
        params.prolev = _prolev;
        params.leftmenuid = _leftmenuid;
        params.type = "check";
        params.menuid = _menuid;
        params.lefttabtype = _bustype;
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.evaluation.dept.report.DeptReportBOTX";
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
        params.isNINGXIA = _isNINGXIA;
        Ext.lt.RCP.call(service , "saveProgram", params, function(rs) {
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
        common.initDatatable();
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        cmp.query();
    })

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    return cmp;
}