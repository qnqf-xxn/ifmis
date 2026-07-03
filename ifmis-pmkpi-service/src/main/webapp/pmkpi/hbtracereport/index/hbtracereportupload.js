if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.hbtracereportupload = function(config, service){
    var cmp = {};

    var serviceid = service,
        _menuid = config.menuid,
        _tablecode,
        _defquery,
        _orderby,
        _uikey,
        _agency,//左侧树节点;
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;

    /**
     * 查询
     * @param obj
     */
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    $(function() {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.pmkpi.query = function(){
        if(!_agency){
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.menuid = _menuid;
        params.beanid = "pmkpi.hbtracereport.hbtracereportBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 填报/修改
     */
    cmp.add = function(){
        var data = datatable.getSelected();
        if(_agency == "treeroot" && data.length != 1){
            Ext.lt.ui.alert("请选择左侧部门或选中一条数据进行填报/修改！",function(){});
            return;
        }
        var params = {};
        params.pageurl = "/pmkpi/hbtracereport/upload/edit";
        var url = "/pmkpi/hbtracereport/upload/edit.page";
        if (data.length == 1) {
            params.agency = data[0].agencyguid;
            params.mainguid = data[0].guid;
            params.mod = "mod";
        } else {
            var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
            params.mainguid = newguid;
            params.agency = _agency;
            params.mod = "add";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门监控报告上报");
    }

    /**
     * 删除
     */
    cmp.del = function() {
        var selDatas = datatable.getSelected();
        if(selDatas.size() <= 0){
            Ext.lt.ui.alert('请选择要删除的数据！', function(){});
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择的数据!', null, function(is){
            if(is){
                var params = {};
                params.tablecode = _tablecode;
                params.datas = selDatas;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid , "delDatas", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    if (rs.flg=="1") {
                        Ext.lt.ui.alert('删除成功！',function(){
                            //datatable.removeData(selDatas);
                            cmp.query();
                        });
                    }
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        });
    }

    /**
     * 点击树
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _agency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
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
                    var url = "/pmkpi/hbtracereport/upload/edit.page";
                    var params = {};
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.viewtype = "query";
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门监控报告上报");
                };
            }
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    return cmp;
}