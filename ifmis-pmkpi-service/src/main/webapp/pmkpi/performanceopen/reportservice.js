if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.performanceopen){
    Ext.lt.pmkpi.performanceopen = {};
}

Ext.lt.pmkpi.performanceopen.reportservice = function(config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _tablecode,
        _workflow = config.workflow,//工作流guid
        _lefttreename = "绩效公开",
        _lefttabtype = "perfopen",
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _opencode,
        _agencode,
        _openisleaf,
        _agenisleaf;
    var isfirst = true;
    var serviceid = service;
    var _displaycols = [];

    Ext.lt.pmkpi.query = function(){
        if (!_opencode) {
            _opencode = "treeroot";
            _openisleaf = "0";
        }
        if (!_agencode) {
            _agencode = "treeroot";
            _agenisleaf = "0";
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.protype = _lefttabtype;
        params.opencode = _opencode;
        params.agencode = _agencode;
        params.openisleaf = _openisleaf;
        params.agenisleaf = _agenisleaf;
        params.beanid = "pmkpi.performanceopen.PerfOpenBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            if (_lefttabtype == "perfopen"){
                _opencode = treeNode.code;
                _openisleaf = treeNode.isleaf;
            } else if (_lefttabtype == "perfagen") {
                _agencode = treeNode.code;
                _agenisleaf = treeNode.isleaf;
            }
        } else {
            if (_lefttabtype == "perfopen"){
                _opencode = "treeroot";
                _openisleaf = '2';
            } else if (_lefttabtype == "perfagen") {
                _agencode = "treeroot";
                _agenisleaf = '2';
            }
        }
        cmp.setTableColum();
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            if (cols[i]["colcode"] && cols[i]["isvisiable"] == 1) {
                if ((_tabcode == "alreadyaudit" || _tabcode == "alldeals") && cols[i]["edit"]) {
                    cols[i].style = "background-color:#f2f2f2;";
                    cols[i].oneditstart = function (table, e, l, c, d) {
                        return false;
                    }
                } else if ((_tabcode == "waitaudit" || _tabcode == "back") && cols[i]["edit"]) {
                    cols[i].style = "background-color:rgb(237, 255, 245);";
                    cols[i].oneditstart = function (table, e, l, c, d) {
                    }
                }
            }
        }
    });

    cmp.save = function() {
        var selecteds = datatable.getRecordSet().toArray();
        if (datatable.getRecordSet().toArray().length > 0) {
            var data = selecteds;
            var data1 = [];
            for ( var i = 0; i < data.length; i++) {
                var isopen = data[i].isopen;
                var openamt = data[i].openamt;
                var openurl = data[i].openurl;
                var openreason = data[i].openreason;
                if (isopen || openamt || openurl || openreason){
                    data1.push(data[i]);
                }
            }
            if(data1.length > 0){
                var config = {};
                config.data = data1;
                config.workflow = _workflow;
                config = Ext.lt.RCP.asyncall(serviceid, "save", config);
                if (config.error) {
                    Ext.lt.ui.alert(config.error);
                } else {
                    Ext.lt.ui.alert('保存成功！', function() {
                        Ext.lt.pmkpi.query();
                    });
                }
            }else {
                Ext.lt.ui.alert('暂无保存数据！');
                return;
            }
        } else {
            Ext.lt.ui.alert('页面无数据！');
            return;
        }
    }

    //导入
    cmp.import = function(){
        var url = "/pmkpi/performanceopen/resultFile.jsp";
        var params = {};
        params.menuid = _menuid;
        Ext.lt.ui.openModalWindow(url,"800","450","绩效公开导入");
    }

    cmp.showwfinfo = function(){
        var data = datatable.getSelected();
        if(data.size()==1){
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            common.proinfoview(datatable,params);
        } else if(data.size() > 1) {
            Ext.lt.ui.alert('每次只能查看一条数据！',function(){});
        } else {
            Ext.lt.ui.alert('请选择要查看的数据！',function(){});
        }
    }


    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    //送审/审核
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj["name"] + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.workflow = _workflow;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        common.doAction(obj, params);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        common.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if(!isfirst){
            Ext.lt.pmkpi.query();
            common.initDatatable();
        }
    }

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
    }

    $(function (){
        common.initDatatable();
        cmp.setTableColum();
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        params.name = _lefttreename;
        tabChange(params);
        Ext.lt.pmkpi.query();
    })

    /**
     * 更新填报中间表数据
     */
    cmp.updatemanceopen = function () {
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "updateManceOpens", null, function(rt){
            Ext.lt.ui.alert("更新成功！",function(){
                Ext.lt.pmkpi.query();
            });
            Ext.lt.ui.loadingClose();
        },function(resp){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert(resp,{timeout:5},function(){
            });
        });
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if (col.colcode == "isselfeval") {
                if ( _opencode == "03") {
                    col.display = true;
                } else {
                    _displaycols.push(col);
                    col.display = false; //display置为false，隐藏
                }
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }


    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            try {
                Ext.lt.ui.modalWindow.close();
            }catch(e){

            }
        }
    });

    return cmp;
}