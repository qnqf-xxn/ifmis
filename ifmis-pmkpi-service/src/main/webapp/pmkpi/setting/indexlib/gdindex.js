if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.gdindex = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _qfdatas = config.qfdatas,//查询区数据
        _coldatas = config.coldatas,//列数据
        _tabledatas = config.tabledatas,//表数据
        _treeid, //左侧树节点
        _tabfilter, //页签过滤条件
        _tabcode, //页签
        _defquery, //表格过滤条件
        _orderby, //排序
        _tablecode,
        _isleaf,
        _levelno,
        _treename,
        _treeNode,
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight;
    var isfirst = true;
    var serviceid = service;

    $(function () {
        commoncmp.pendingtasktab();
        commoncmp.initDatatable();
        isfirst = false;
        cmp.query();
        tabChange();
    })

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        if(!_treeid){
            _treeid = "treeroot";
            _isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.treeid = _treeid;
        params.isleaf = _isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.tablecode = _tablecode;
        params.beanid = "pmkpi.setting.gd.GDIndexBO";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        });
    }
    /**
     * 点击左侧树.
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
            _levelno = treeNode.levelno;
            _treename = treeNode.name;
            _treeNode = treeNode;
        } else {
            _treeid = "treeroot";
            _isleaf = '0';
        }
        cmp.query();
    });

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function () {
        _treeid = "treeroot";
        _isleaf = '0';
        var data = _qfdatas;
        var key = '/pmkpi/setting/gd/gdindex';
        _tablecode = _tabledatas.tablecode;
        queryfrom(data,key);
       /* if (!isFirst) {
            Ext.lt.pmkpi.query();
        }*/
    }


    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery: true,
            datatable: 'datatable',
            drawmode: 'div',
            key: key,
            label: "快速查询",
            labelwidth: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength: 18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
    });

    /**
     * 新增
     */
    cmp.add = function () {
        if ((!_treeid || 1!= _isleaf)) {
            Ext.lt.ui.alert("请选择左侧末级结点进行新增！",function(){});
            return;
        }
        var params = {};
        params.treeid = _treeid;
        params.treename = _treename;
        params.superid = _treeNode["superguid"];
        params.pagetype = "add";
        params.workflow = _workflow; //工作流
        url = Ext.lt.pmkpi.genPageUrl("/pmkpi/gdindex/edit.page", params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"新增指标");
    }


    /**
     * 修改
     */
    cmp.mod = function () {
        var selectDatas = datatable.getSelected();
        if (!selectDatas || selectDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条指标进行修改！",function(){});
            return;
        }
        var params = {};
        params.treeid = _treeid;
        params.pagetype = "mod";
        params.workflow = _workflow; //工作流
        params.guid = selectDatas[0]["guid"];
        url = Ext.lt.pmkpi.genPageUrl("/pmkpi/gdindex/edit.page", params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"修改指标");
    }

    /**
     * 删除
     */
    cmp.del = function () {
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = _tabcode;
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "delDatas", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除成功！',function(){
                        cmp.query();
                    });
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    /**
     * 查询消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });


    return cmp;
}

