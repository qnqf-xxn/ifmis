if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.baseinfo)
    Ext.lt.pmkpi.baseinfo = {};
var serviceid;
Ext.lt.pmkpi.baseinfo = function(config, service) {
    var cmp = {};
    serviceid = service;
    var _serviceid = service;
    var _tablecode,
        _defquery,
        _uikey,
        _sxuikey,
        _nodeguid,
        _orderby,
        _isSx = config.isSx,
        _leftflag = config.leftflag,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;

    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    /**
     * 删除
     */
    cmp.del = function(){
        var selDatas = datatable.getSelected();
        if (selDatas.length <= 0) {
            Ext.lt.ui.alert("请选择要删除的数据！",function(){});
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',{icon: "warn"},function(is){
            if(is){
                var params = {};
                params.tablecode = _tablecode;
                params.datas = selDatas;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid , "delDatas", params, function(rs){
                    datatable.removeData(selDatas);
                    Ext.lt.ui.loadingClose();
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    /**
     * 新增
     */
    cmp.add = function(){
        if(!_nodeguid || _nodeguid == "treeroot" ){
            Ext.lt.ui.alert("请选择左侧树末级节点数据！",function(){});
            return;
        }
        var newguid = Ext.lt.RCP.asyncall(_serviceid , "getCreateguid", null);
        var params = {};
        var url = _uikey + ".page";
        params.viewtype = "add";
        params.tablecode = _tablecode;
        params.guid = newguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"基础资料编辑");
    }
    $(function () {
        cmp.query();
    })
    /**
     * 修改
     */
    cmp.update = function(){
        var selDatas = datatable.getSelected();
        if (selDatas.length > 1) {
            Ext.lt.ui.alert("请选择一条数据修改！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        params.viewtype = "mod";
        params.tablecode = _tablecode;
        params.guid = selDatas[0]["guid"];
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"基础资料编辑");
    }

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        if(!_nodeguid){
            _nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.nodeguid = _nodeguid;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.querycol = _leftflag;
        params.beanid = "pmkpi.baseinfo.BaseinfoBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }


    /**
     * 新增
     */
    cmp.sxadd = function(){
        if(!_nodeguid || _nodeguid == "treeroot" || Ext.lt.pmkpi.isleaf != "1"){
            Ext.lt.ui.alert("请选择左侧树末级节点数据！",function(){});
            return;
        }
        var params = {};
        var url = _sxuikey + ".page";
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.viewtype = "add";
        params.tablecode = _tablecode;
        params.guid = newguid;
        params.mainguid = newguid;
        params.isSx = "isSx";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"编辑");
    }

    /**
     * 修改
     */
    cmp.sxupdate = function(){
        var selDatas = datatable.getSelected();
        if (selDatas.length > 1) {
            Ext.lt.ui.alert("请选择一条数据修改！",function(){});
            return;
        }
        var params = {};
        var url = _sxuikey + ".page";
        params.viewtype = "mod";
        params.tablecode = _tablecode;
        params.guid = selDatas[0]["guid"];
        params.mainguid = selDatas[0]["guid"];
        params.isSx = "isSx";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"基础资料编辑");
    }



    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });


    /**
     * 左侧树点击事件
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _nodeguid = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });


    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _uikey = config.uikey;
        _sxuikey = config.sxuikey;
        _orderby = obj.uiconfig.orderby;
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
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
                    if(_isSx  == 1){
                        url = _sxuikey + ".page";
                    }
                    params.viewtype = "query";
                    params.tablecode = _tablecode;
                    params.guid = d.guid;
                    params.mainguid = d.guid;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"基础资料编辑");
                };
            }
        }
    });
    return cmp;
}