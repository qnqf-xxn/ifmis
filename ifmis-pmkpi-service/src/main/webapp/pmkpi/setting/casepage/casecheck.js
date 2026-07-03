if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.case){
    Ext.lt.pmkpi.case = {};
}

Ext.lt.pmkpi.case.checkservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,//工作流guid
        _saveAgency,//单位
        _isCasetype = config.isCasetype,
        _leftsource = config.leftsource,
        _menuid = config.menuid,//菜单
        _bustype = config.bustype,//业务类型，项目/部门/政策
        _leftmenuid = config.leftmenuid,//隐藏菜单guid
        _datatype = config.datatype,
        _tablecode,//查询表名
        _tablesql//表过滤条件
    ;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
        var tableconfig = eval('(' + uiconfig.config + ')');
        _tablesql = tableconfig[_bustype]
    });

    cmp.query = function(){
        var params = {};
        params.nodeguid = "treeroot";
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.type = "check";
        params.isCasetype = _isCasetype;
        params.leftsource = _leftsource;
        params.menuid = _menuid;
        params.lefttabtype = _bustype;
        params.leftmenuid = _leftmenuid;
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.casepage.report.CaseReportBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    cmp.save = function(){
        var datas = datatable.getSelected();
        if (!datas || datas.length <= 0) {
            Ext.lt.ui.alert('请选择案例！',function(){
            });
            return;
        }
        if (!datatable.check()) {
            return false;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.datas = datas;
        params.saveAgency = _saveAgency;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        Ext.lt.RCP.call(service , "saveAdjuctCase", params, function(rs) {
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
        common.initDatatable();
        cmp.query();
    })

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "upstatus") {
                col.oneditstart = function (table, el, l, c, d) {
                    Ext.lt.pmkpi.doMapper(_datatype,table.getCol(c));
                    this.config.isMulti = false;
                    return;
                }
            }
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    return cmp;
}