if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.evaluate){
    Ext.lt.pmkpi.evaluate = {};
}
if(!Ext.lt.pmkpi.evaluate.preevaluateservice){
    Ext.lt.pmkpi.evaluate.preevaluateservice = {};
}

var _selectedtree = null;
Ext.lt.pmkpi.evaluate.preevaluateservice = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        queryurl=config.queryurl,
        _nodecode, //左侧树节点
        _nodeguid, //左侧树节点id
        _tablecode, //业务表
        _tabfilter, //页签过滤条件
        _tabcode, //页签
        _uikey, //
        _tabtype,
        _defquery, //表格过滤条件
        _orderby, //排序
        _deltables, //主表删除要删除的明细
        _delcols, //
        _prolev = "3",//项目级次
        _deptcoldatas = config.deptcoldatas,//部门列数据
        _depttabledata = config.depttabledata,//部门表数据
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _procoldatas = config.procoldatas,//项目列数据
        _protabledata = config.protabledata,//项目表数据
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _lefttabtype = "program",//左侧树页签guid 默认项目支出
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    _scrWidth =document.body.clientWidth-300,
        _scrHeight =document.body.clientHeight-300;
    var _elementcode = config["elementcode"];
    var _columncode = config["columncode"];
    var serviceid = service;
    var isfirst=true;

    $(function (){
        commoncmp.initDatatable();
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        tabChange(params);
    })

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        var ordernum = obj.ordernum;
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        var data;
        var key;
        if (_lefttabtype == "program"){
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            _lefttreename = "项目支出";
            cmp.setTableColum(_procoldatas);
            data = _proqfdatas;
            key = '/pmkpi/review/report/program';
        } else if (_lefttabtype == "dept") {
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            key = '/pmkpi/review/report/dept';
            _lefttreename = "部门整体"
            cmp.setTableColum(_deptcoldatas);
            data = _deptqfdatas;
        }
        queryfrom(data,key);
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.pmkpi.query();
        obj.datas = datalist
        return obj;
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
        if ($(".busquerypanel_outline")[0]) {
            queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
            queryform.draw($(".busquerypanel_outline")[0]);
        }
    }

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
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
        params.beanid = "pmkpi.evaluate.PreEvaluateBo";
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
        if(_lefttabtype == "program"){ //不选择预算单位按类型查询
            _saveAgency = treeNode.guid;
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else if(_lefttabtype == "dept") {
            _saveAgency = treeNode.guid;
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            //Ext.lt.pmkpi.isleaf = '0';
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        }
        cmp.query();
    });
    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(cols){
        var c = [];
        var tmainCol = datatable.getCols();
        c.push(tmainCol[0]);
        c.push(tmainCol[1]);
        for (var i=0; i<cols.length; i++) {
            c.push(cols[i]);
        }
        datatable.setCols(c);
        // var h = $("#queryform .busquerypanel").height();
        // var buttonH = $('.busnomalbtn_outline').height();
        // var tableh = scrHeight - h- buttonH-20;
        // datatable.resize(scrWidth,tableh);
        // datatable.headsort(false);
        // datatable.setAllowcustom(false);
        // datatable.setAllowClock(false);
        var page = {};//datatable.getPage();
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

    //退回
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
        var data = datatable.getSelected();
        if(data.length == 0){
            Ext.lt.ui.alert("请选择要修改的数据！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        if (data.length == 1) {
            params.saveAgency = data[0].agencyguid; //虽然是agency也有可能是处室
            params.mainguid = data[0].proguid;
            params.columncode = _columncode; //左侧树要素保存字段.
            params.viewtype = "mod";
            params.prolev = "3"; //项目级别
            params.isvisiable = "2"; //项目级别
            params.busIsHidden = "1"; //项目级别
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"查看明细");
        } else {
            Ext.lt.ui.alert("请选择一条要修改的数据！",function(){});
            return;
        }
    }

    /**
     * 评估
     */
    cmp.evaluate = function (obj){
        var data = datatable.getSelected();
        if(data.length == 0){
            Ext.lt.ui.alert("请选择要评估的数据！",function(){});
            return;
        }
        var params = {};
        var url = "/pmkpi/evaluate/preevaluate/edit.page";
        if (data.length == 1) {
            params.saveAgency = data[0].agencyguid; //虽然是agency也有可能是处室
            params.mainguid = data[0].proguid;
            params.procode = data[0].pro_code;
            params.guid = data[0].guid;
            params.columncode = _columncode; //左侧树要素保存字段.
            params.viewtype = "mod";
            params.prolev = "3"; //项目级别
            params.workflow = _workflow;
            // params.busIsHidden = "1"; //隐藏按钮
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"评估");
        } else {
            Ext.lt.ui.alert("请选择一条要评估的数据！",function(){});
            return;
        }
    }

    return cmp;
}




