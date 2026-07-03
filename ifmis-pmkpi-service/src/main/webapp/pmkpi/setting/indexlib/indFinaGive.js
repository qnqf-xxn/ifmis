if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.indFinaGive){
    Ext.lt.pmkpi.indFinaGive = {};
}

Ext.lt.pmkpi.indFinaGive.finaGiveservice = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _tablesql,
        _agency,
    scrWidth =document.body.clientWidth,
    scrHeight =document.body.clientHeight;
    var serviceid = service;

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        cmp.query();
    })
    //查询
    cmp.query = function (filter){
        query(filter);
    }

    function query(filter){
        if(!_agency){
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        var params = {};
        params.treeid = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        if (filter) {
            params.querySql = filter;
        }
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        params.tablesql = _tablesql;
        params.elementcode = 'INDEXCOMFUNC';
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.finagive.IndFinaGiveBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }
    
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _agency = treeNode.guid;
            _name=treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _tablesql=uiconfig.defquery;
    });

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            cfg.key = '/pmkpi/indexlib/finagive';
            cfg.bustable = datatable;
            if (data.size() == 0) {
                alert("请选择数据进行导出！");
                return;
            } else {
                cfg.downtype = 'xls';//下载  类型
                dataexport.excelexport(cfg);
            }
        } else {
            Ext.lt.ui.alert("页面无数据！", {timeout: 1}, function () {
            });
            return;
        }
    }
    //授权
    cmp.give = function (){
        var params = {};
        var url = "/pmkpi/indexlib/finagive/edit.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth-5,scrHeight-6,"财政个性指标授权");
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        if (obj.queryform){
            _queryfilter = obj.queryform.getQuerySQL();
        }
        cmp.query(_queryfilter);
    });

    return cmp;
}


