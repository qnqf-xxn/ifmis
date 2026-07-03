if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}

Ext.lt.pmkpi.financialevaluation.deptfill = function(config, service){
    var cmp = {};
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,//菜单id
        _leftmenuid,//隐藏菜单
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,
        _proworkflow = config.proworkflow,//项目工作流guid
        _finhide = config.finhide,//隐藏菜单后缀
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _finaudithide = config.finaudithide,
        _datasource,//数据源集合
        _workflow,//工作流guid
        _tabcode,//页签code
        _tabfilter,//页签过滤条件
        _defquery,
        _prolev = config.prolev,//项目级次
        _displaycols = [],
        _saveAgency,//左侧树选择单位
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _lefttabtype = "program",//左侧树页签guid 默认项目支出
        _bustype,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst=true;
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _workflow = obj.leftwfid;
        _lefttreename = obj["name"];
        _leftmenuid = obj.leftmenuid;
        _lefthidebtn = obj.hidebtns;
        _bustype = _lefttabtype;
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        cmp.setTableColum();
        common.setworkflow(_workflow);
        common.setTabNum(obj);
        var treedatas =Ext.lt.pmkpi.querytree();
        Ext.lt.pmkpi.query();
        obj.datas = treedatas;
        return obj;
    }

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.bustype = _bustype;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        return datalist;
    }

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        common.pendingtasktab();
        tabChange(_lefttab);
        isfirst = false;
    })

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.menuid = _menuid;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.tabfilter = _tabfilter;
        params.tabcode = _tabcode;
        params.tablesql = _defquery;
        params.beanid = "pmkpi.evaluation.financial.deptfill.DeptfillBOTX";
        common.setColDatasource(_datasource, datatable);
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        _defquery = uiconfig.defquery;
    });

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){ //不选择预算单位按类型查询
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
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
            if (_lefttabtype == "program") {
                if (config && config.isdept == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            } else if (_lefttabtype == "dept") {
                if (config && config.ispro == 1) {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                } else {
                    col.display = true;
                }
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        _tabhidtbtn = obj.hidebtns;
        common.changTooltoolbuttontStatus(0,_lefthidebtn + "," + _tabhidtbtn);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) { //首次不走查询
            Ext.lt.pmkpi.query();
        }
    }

    /**
     *工作流.
     */
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length != 1) {
            Ext.lt.ui.alert("请选择一条数据进行" + obj.name + "！",function(){});
            return;
        }
        var action = obj.code;
        if (action == "audit") {
            var params = {};
            params.mainguid = datas[0].guid;
            params.saveAgency = datas[0].agencyguid;
            params.projguid = datas[0].proguid;
            params.viewtype = "query";
            params.workflow = _workflow;
            params.prolev = _prolev;
            params.bustype = _lefttabtype;
            var url = "/pmkpi/evaluation/financial/auditedit.page";
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth*0.7,scrHeight*0.7,"财政评价审核-"+_lefttreename);
        } else {
            var params = {};
            params.datas = datas;
            params.busguid = _lefttabtype + _finaudithide + "_" + datas[0]["wfstatus"];
            // 校验页签参数
            params.checktable = "v_perf_t_finevaluation";
            if (_lefttabtype && "program" == _lefttabtype) { //项目支出
                params.checkkey = "/pmkpi/evaluation/financial/deptfill/proedit";
            } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
                params.checkkey = "/pmkpi/evaluation/financial/deptfill/deptedit";
            }
            if (obj.code == "sendaudit" && !common.checkTabPageData(params)) return false;//先校验
            common.doAction(obj, params);
        }
    }

    /**
     * 填报
     */
    cmp.mod = function(obj){
        var params = {};
        var data = datatable.getSelected();
        params.viewtype = "mod";
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选择一条数据进行上传！",function(){});
            return;
        }
        if (obj.code == "queryresult") {
            params.viewtype = "query";
        }
        params.mainguid = data[0].guid;
        params.proguid = data[0].proguid;
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        params.saveAgency = data[0].agencyguid;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/evaluation/financial/deptfill/proedit.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/evaluation/financial/deptfill/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "填报-" + _lefttreename);
    }

    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var params = {};
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].proguid;
        params.viewtype = "query";
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/evaluation/financial/deptfill/proedit.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/evaluation/financial/deptfill/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"财政评价审核-"+_lefttreename);
    }

    /**
     * 查看项目
     */
    cmp.showProjView = function (obj){
        var params = {};
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        params.proguid = data[0].proguid;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.doubleprocess.TlpJxAuditService", "getProInfo", params);
        if(xmxxEditobject.length>0){
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            var pro_lev = xmxxEditobject[0].pro_lev;
            if(pro_lev && pro_lev == "2"){
                common.proinfoview(datatable,params);
            }else {
                params.vchtypeid = xmxxEditobject[0].vchtypeid;
                params.projectkind = xmxxEditobject[0].projectkind;
                common.queryPromain(datatable,params);
            }
        }else{
            Ext.lt.ui.alert("未查询到该项目的项目库信息数据！",function(){});
        }
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    return cmp;
}