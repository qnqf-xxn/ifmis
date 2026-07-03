if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.rectification)
    Ext.lt.pmkpi.rectification = {};
if(!Ext.lt.pmkpi.rectification.add)
    Ext.lt.pmkpi.rectification.add = {};

Ext.lt.pmkpi.rectification.add.proj = function(config, service){
    var cmp = {};
    var serviceid = config.serverid,
    _bustype = config.bustype,
    _type = config.type,//1.RANDOMCOMMENT(抽评),2.FINEVALUATION(财政重点评价)
    _menuid = config.menuid,
    _workflow = config.workflow,
    _leftmenuid = config.leftmenuid,//隐藏菜单
    _tableSql,//表过滤条件
    _lefttabtype = "program",
    _treeid,
    _isleaf,
    _tablecode;
    //初始化
    cmp.draw = function(){
        cmp.query();
    }
    //查询
    cmp.query = function(){
        if(!_treeid){
            _treeid = "treeroot";
            _isleaf = 0;
        }
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.defquery = _tableSql;
        params.bustype = _bustype;
        params.menuid = _menuid;
        params.treeid = _treeid;
        params.type = _type;
        params.isleaf = _isleaf + "";
        params.tablecode = _tablecode;
        params.leftmenuid = _leftmenuid;
        if (_bustype == "3"){
            _lefttabtype = "dept";
        }
        params.lefttabtype = _lefttabtype;
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.rectification.RectificationAddProjBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    //财政重点评价(选择项目-确定)
    cmp.finadd = function(){
        var size = datatable.getRecordSet().size();
        if(size>0){
            var selecteds = datatable.getSelected().size();
            if (selecteds <= 0) {
                Ext.lt.ui.alert('请选择数据！',function(){});
                return;
            }
            if (selecteds!=1) {
                Ext.lt.ui.alert('只能选择一条数据！',function(){});
                return;
            }
            var data = datatable.getSelected();
            Ext.lt.ui.loadingClose();
            parent.Ext.lt.ui.closeModalWindow();// 关闭
            window.parent.cmp.add(data);
        }
    }

    //抽评(选择项目-确定)直接新增至列表
    cmp.add = function(){
        var selecteds = datatable.getSelected().size();
        var data = datatable.getSelected();
        if(_type == "RANDOMCOMMENT"){
            if (selecteds <= 0) {
                Ext.lt.ui.alert('请选择数据！',function(){});
                return;
            }
            if (selecteds!=1) {
                Ext.lt.ui.alert('只能选择一条数据！',function(){});
                return;
            }
            var params = {};
            params.projguid=data[0].guid;
            params.pro_code=data[0].pro_code;  //项目编码
            params.bustype=_bustype;
            params.type=_type;
            params.workflow=_workflow;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid , "save", params, function(rs){
                if(rs.error){
                    Ext.lt.ui.alert(rs.error);
                    Ext.lt.ui.loadingClose();
                    parent.Ext.lt.ui.closeModalWindow();// 关闭
                    window.parent.cmp.query();// 刷新
                } else{
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert(("保存成功！"),{}, function(ret) {
                        parent.Ext.lt.ui.closeModalWindow();// 关闭
                        parent.cmp.query();// 刷新
                    });
                }
            });
        }else{
            Ext.lt.ui.closeModalWindow();// 关闭
            window.parent.cmp.add(data);
        }
    }

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
        } else {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _tableSql = config.wheresql;
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    $(function () {
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.redraw();
        cmp.query();
    })

    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();// 关闭
        window.parent.cmp.query();
    }

    return cmp;
}



