if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.deptTJfinreview = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _menuid = config.menuid,
        _tabfilter, //页签过滤条件
        _tabcode, //页签
        _defquery, //表格过滤条件
        _orderby, //排序
        _tablecode,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;

    var serviceid = service;

    $(function(){
        commoncmp.initDatatable();
        Ext.lt.pmkpi.query();
    });

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.menuid = _menuid;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.beanid = "pmkpi.deptTJformance.DeptTJPerffinreviewBO";
        datatable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var params = {};
                    var url = _uikey + ".page";
                    params.pagetype = "audit";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.saveAgency = d.agencyguid;
                    params.viewtype = "query";
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"查看详情");
                };
            }
        }
    });

    /**
     * 确认审阅/取消审阅
     */
    cmp.review = function (obj){
        var datas = datatable.getSelected();
        if(datas.length == 0){
            Ext.lt.ui.alert("请选择要"+obj.name+"的数据！",function(){});
            return;
        }
        Ext.lt.ui.confirm("确认"+obj.name+"？",{icon:"warn"},function(ret){
            if(ret){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.seldatas = datas;
                params.actioncode = obj.code;
                params.busguid = _menuid + "_" + datas[0].wfstatus;
                Ext.lt.RCP.call(serviceid, "review", params, function (rs) {
                    if(rs.success){
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert('操作成功！', function () {
                            Ext.lt.pmkpi.query();
                        });
                    }else{
                        Ext.lt.ui.loadingClose();
                        Ext.lt.ui.alert(rs.msg, function () {
                        });
                    }
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('操作失败！', function () {
                    });
                });
            }
        });
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        Ext.lt.pmkpi.query();
    }

    return cmp;
}

