if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
/**
 * 初始化加载.
 */
Ext.lt.pmkpi.deifselectpro = function(config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _defquery,//列表查询条件
        _orderby,//排序
        _tablecode,//表名
        _configquery;//组件查询条件
    var _cmp = {};
    var scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    /**
     * 页面加载完成
     */
    $(function() {
        common.initDatatable();
        _cmp.query();
        window.parent.indexwindow = window;
    })

    /**
     * 重画表格列.
     */
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _configquery = config.defquery;
        _orderby = uiconfig.orderby;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if (col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }

        }
    })

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        _cmp.query();
    });

    /**
     * 关闭
     * @param obj
     */
    _cmp.closewin = function(){
        parent.Ext.lt.ui.modalWindow.close();
    }
    /**
     * 查询
     */
    _cmp.query = function(){
        var params = {};
        var bustype = Ext.lt.getparam("bustype");
        params.beanid = "pmkpi.deif.DeifselectproBOTX";
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.defquery = _configquery;
        params.orderby = _orderby;
        params.bustype = bustype;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        Ext.lt.ui.loadingShow();
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
            $(".winfooter").find("#查看自评详情").hide();
            if(bustype == "pmkpi100" || bustype == "pmkpi120"){
                $(".winfooter").find("#查看自评详情").show();
            }
        });
    }

    //导出
    Ext.lt.pmkpi.deifselectpro.exp = function() {
        var datas = datatable.getSelected();
        var params = {};
        params.data = datas;
        params.bustype = Ext.lt.getparam("bustype");
        params.dd = Ext.lt.getparam("dd");
        params.submenu = Ext.lt.getparam("submenu");
        if(datas.length <= 0){
            Ext.lt.ui.confirm("未选择数据，是否导出全部数据",{icon:"warn"},function(ret){
                if(ret){
                    params.beanid = "pmkpi.deif.DeifselectproBOTX";
                    params.tablecode = _tablecode;
                    params.tablesql = _defquery;
                    params.defquery = _configquery;
                    params.orderby = _orderby;
                    params.queryConfig = queryform.getQueryParam();
                    params.querySql = queryform.getQuerySQL();
                    Ext.lt.RCP.down("pmkpi.deif.DeifselectproService", 'exportJsonData',params,function(resp){
                        alert(resp);
                    });
                }
            });
        }else{
            Ext.lt.RCP.down("pmkpi.deif.DeifselectproService", 'exportJsonData',params,function(resp){
                alert(resp);
            });
        }
    }

    //关闭
    Ext.lt.pmkpi.deifselectpro.close  = function() {
        var closeBtn = $(window.frameElement).parents('table').find('button:eq(0)');
        $(closeBtn).trigger('click');
    }

    //自评详情
    Ext.lt.pmkpi.deifselectpro.selfdetail  = function() {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var params = {};
        var url = "/pmkpi/perfself/apply/edit.page";
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.viewtype = "query";
        params.bustype = "program";
        params.tablecode = _tablecode;
        params.wfstatus = data[0].wfstatus;
        params.proguid = data[0].projguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.9, scrHeight*0.9, "绩效自评查看-项目支出");
    }

    return _cmp;
}