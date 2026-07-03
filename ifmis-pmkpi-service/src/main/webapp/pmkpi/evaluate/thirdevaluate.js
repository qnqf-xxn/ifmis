if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.evaluate){
    Ext.lt.pmkpi.evaluate = {};
}
if(!Ext.lt.pmkpi.evaluate.thirdevaluateservice){
    Ext.lt.pmkpi.evaluate.thirdevaluateservice = {};
}

var _selectedtree = null;
Ext.lt.pmkpi.evaluate.thirdevaluateservice = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _datasource,//数据源集合
        _tablecode, //业务表
        _tabfilter, //页签过滤条件
        _tabcode, //页签
        _defquery, //表格过滤条件
        _prolev = "3",//项目级次
        _deptcoldatas = config.deptcoldatas,//部门列数据
        _depttabledata = config.depttabledata,//部门表数据
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _procoldatas = config.procoldatas,//项目列数据
        _protabledata = config.protabledata,//项目表数据
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _lefttabtype = "program",//左侧树页签guid 默认项目支出
        _menuid = config.menuid,
        _scrWidth =document.body.clientWidth-300,
        _scrHeight =document.body.clientHeight-300;
    var _displaycols = [];
    var serviceid = service;
    var isfirst=true;

    $(function (){
        isfirst = false;
        var params = {};
        params.code = _lefttabtype;
        tabChange(params);
    })

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        var data;
        var key;
        var cols;
        if (_lefttabtype == "program"){
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            _lefttreename = "项目支出";
            cols = _procoldatas;
            //cmp.setTableColum(_procoldatas);
            data = _proqfdatas;
        } else if (_lefttabtype == "dept") {
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            _lefttreename = "部门整体"
            cols = _deptcoldatas;
            //cmp.setTableColum(_deptcoldatas);
            data = _deptqfdatas;
        }
        var params = {};
        params.tablecode = _tablecode;
        params.cols = cols;
        try{
            _datasource = Ext.lt.RCP.asyncall(service , "getDataSource", params);
            commoncmp.setColMapper(cols);
        }catch (e) {}
        cmp.setTableColum();
        queryfrom(data,key);
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
    }

    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery : true,
            datatable : 'datatable',
            drawmode :'div',
            key: key,
            label: "快速查询",
            labelwidth: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength:18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        commoncmp.setColDatasource(_datasource, datatable);
        params.beanid = "pmkpi.evaluate.ThirdEvaluateBo";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            //Ext.lt.pmkpi.querytree();
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){ //不选择预算单位按类型查询
            _saveAgency = treeNode.guid;
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            //_saveAgency = "treeroot";
            _saveAgency = treeNode.guid;
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            //Ext.lt.pmkpi.isleaf = '0';
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        }
        Ext.lt.pmkpi.query();
    });
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
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _lefttabtype) {
                    col.display = true;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
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

    //页签方法
    cmp.clickTabpage = function(obj){
        var tabcode = obj.code;
        commoncmp.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) { //首次不走查询
            Ext.lt.pmkpi.query();
        }
    }

    /**
     * 查询消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    //送审/审核
    cmp.back = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj["name"] + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        commoncmp.doAction(obj, params);
    }

    //送审情况
    cmp.viewlogs = function (){
        commoncmp.auditquery(datatable);
    }

    //导出
    cmp.export = function (){
        var cfg = {};
        if (datatable.getRecordSet().size()>0) {
            if(datatable.config.page.totalrows>65000){
                alert("导出数据不能超过65000条，当前数据为："+expdatatable.config.page.totalrows+"条，请缩小结果后再导出");
                return;
            }
            cfg.hassql = 1;
            cfg.bustable = datatable;
            cfg.key = datatable.key;
            cfg.beanid = "pmkpi.evaluate.ThirdEvaluateBo";
            cfg.isHaveQueryForm = false;
            cfg.isHaveTabPage = false;
            cfg.downtype = 'xls';
            cfg.queryform=queryform.getQueryParam();
            dataexport1.excelexport(cfg);
        }else{
            alert("没有数据可导出");
        }
    }

    /**
     * 查看明细
     */
    cmp.viewdetail = function (obj){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        commoncmp.proinfoview(datatable,params);
    }

    /**
     * 委托机构
     */
    cmp.entrust = function (obj){
        var datas = datatable.getSelected();
        if(datas.length == 0){
            Ext.lt.ui.alert("请选择要委托的数据！",function(){});
            return;
        }else{
            var url = "/pmkpi/evaluate/thirdevaluate/entrust.page";
            var params = {};
            params.datas = datas;
            params.workflow = _workflow;
            _scrWidth =document.body.clientWidth-300;
            _scrHeight =document.body.clientHeight-100;
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"委托机构");
        }
    }

    /**
     * 确认/取消/退回
     */
    cmp.confirm = function (obj){
        var btncode = obj.code;
        var actionname = "";
        if (btncode == "confirm") {
            actionname = "确认第三方机构"
        } else if (btncode == "unconfirm") {
            actionname = "取消第三方机构"
        } else if (btncode == "back") {
            actionname = "退回"
        }
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.type = btncode;
        Ext.lt.ui.confirm("是否" + actionname + "进行评审?", null, function (is) {
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "isConfirm", params, function(rt){
                    if (rt && rt.success == true){
                        Ext.lt.ui.alert( actionname + "成功！",function(){
                            Ext.lt.pmkpi.query();
                        });
                    }
                    Ext.lt.ui.loadingClose();
                },function(resp){
                    Ext.lt.ui.loadingClose();
                    var alertmsg = actionname + "失败！\n失败原因：" + resp;
                    Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
                    });
                });
            }
        });
    }

    return cmp;
}




