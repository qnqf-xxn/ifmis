if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}

Ext.lt.pmkpi.financialevaluation.checkservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,//工作流guid
        _leftmenuid = config.leftmenuid,//隐藏菜单
        _prolev = config.prolev,//项目级次
        _saveAgency = config.saveAgency,//单位
        _menuid = config.menuid,//菜单
        _bustype = config.bustype,//业务类型，项目/部门/政策
        _tablecode,//查询表名
        _wheresql,//项目过滤条件
        _defquerysql = {},
        _defquery,
        _tablesql,   //表过滤条件
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    ;
    window.parent.Ext.lt.pmkpi.childwindow = window;


    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        if (_bustype == "program") {
            _defquerysql = eval('(' + uiconfig.config + ')');
            _tablesql = _defquerysql["configsql"];
        }
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _wheresql = config.wheresql;
    });

    cmp.query = function() {
        var params = {};
        params.saveAgency = _saveAgency;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.defquery = _defquery;
        params.tablesql = _tablesql;
        params.leftmenuid = _leftmenuid;
        params.prolev = _prolev;
        params.type = "check";
        params.menuid = _menuid;
        params.lefttabtype = _bustype;
        params.prowheresql = _wheresql;
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.financial.proconfirm.ProConfirmBOTX";
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
        Ext.lt.RCP.call(service , "saveProgramProConfirm", params, function(rs) {
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

    /**
     * 查看项目情况
    */
    cmp.queryView = function(){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据查看项目明细！",function(){});
            return;
        }
        var url = "/pmkpi/yearprogram/query/edit.page";
        if (_bustype == "dept") {
            url = "/pmkpi/yeardept/query/edit.page";
        }
        var params = {};
        params.mainguid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.viewtype = "query";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "项目绩效目标查看");
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