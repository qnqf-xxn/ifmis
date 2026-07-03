if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.kpisystemset)
	Ext.lt.pmkpi.kpisystemset = {};

Ext.lt.pmkpi.kpisystemset = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _tablecode,
        _tablesql,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _tablesql = obj.uiconfig.defquery;
    });

    /**
     * 查询数据
     */
    Ext.lt.pmkpi.query = function(){
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.kpisystemset.KPISystemSetBOTX";
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    $(function () {
        common.initDatatable();
        Ext.lt.pmkpi.query();
    })

    /**
     * 修改
     */
    cmp.mod = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选择要修改的数据！",function(){});
            return;
        }
        var params = {};
        var guid = data[0].guid;
        params.guid = guid;
        params.tablecode = _tablecode;
        var url = "/pmkpi/kpisystemset/infoedit.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth*0.8,scrHeight*0.8,"参数配置修改");
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    cmp.syncBdmData = function(params){
        Ext.lt.ui.confirm("确定同步预算资金数据？",{icon:"warn"},function(ret) {
            if (ret) {
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid , "syncBdmData", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(params.name + '成功！',function(){
                    });
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(params.name + '失败！',function(){
                    });
                });
            }
        });
    }

    return cmp;
}

