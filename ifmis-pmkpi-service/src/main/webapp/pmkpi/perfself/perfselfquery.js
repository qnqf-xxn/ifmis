if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfself) {
    Ext.lt.pmkpi.perfself = {};
}

var _selectedtree = null;
Ext.lt.pmkpi.perfself.perfselfqueryservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var
        _menuid = config.menuid,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _leftmenuid,//隐藏菜单
        _agency,
        _bustype,
        _tabcode,
        _name,
        _pagetype,
        _uikey,
        _defquery,
        _orderby,
        _displaycols = [],
        _tablecode,
        _queryConfig, //查询区配置
        _querySql, //查询区条件
        _deptcode = config.deptcode,//数据分析大屏跳转-参数
        _busguid = config.busguid,//数据分析大屏跳转-参数
        _divcode = config.divcode,//数据分析大屏跳转-参数
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _isNINGXIA = config.isNINGXIA;

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _agency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var data;
        var key;
        if (_lefttabtype == "program" || _lefttabtype == "transprogram") {
            data = _proqfdatas;
            key = '/pmkpi/perfself/apply/index';
            _uikey = "/pmkpi/perfself/apply/edit";
        } else if (_lefttabtype == "parentprogram") {
            data = _proqfdatas;
            key = '/pmkpi/perfself/apply/index';
            _uikey = "/pmkpi/selfparent/program/edit";
        } else if (_lefttabtype == "dept") {
            key = '/pmkpi/perfself/apply/dept';
            _uikey = "/pmkpi/perfself/apply/dept/edit";
            data = _deptqfdatas;
        }
        _querySql = "";
        queryfrom(data, key);
        if(_SYSTEMSTYLE_ == "grey"){
            $("#queryform .searchLeft").css("height","50px");
            queryform.retract();
        }
        common.changTooltoolbuttontStatus(0, _lefthidebtn);
        cmp.setTableColum();
        var treelist = Ext.lt.pmkpi.querytree();
        obj.datas = treelist;
        return obj;
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

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.deptcode = _deptcode;//数据分析大屏跳转-参数
        params.busguid = _busguid;//数据分析大屏跳转-参数
        params.divcode = _divcode;//数据分析大屏跳转-参数
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        cmp.query();
        return datalist;
    }

    //查询
    cmp.query = function (obj) {
        Ext.lt.pmkpi.query();
    }
    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        tabChange(_lefttab);
    })

    Ext.lt.pmkpi.query = function () {
        //获取选中的左侧树code
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.queryConfig = _queryConfig;
        params.querySql = _querySql;
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.bustype = _bustype;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.deptcode = _deptcode;//数据分析大屏跳转-参数
        params.busguid = _busguid;//数据分析大屏跳转-参数
        params.divcode = _divcode;//数据分析大屏跳转-参数
        params.beanid = "pmkpi.perfSelf.PerfSelfQueryBO";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
            setTimeout(function(){
                datatable.resetSum();
            },300);
        });
    }
    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var config = eval(col.config);
            if (config && !$.isEmptyObject(config) && col.alias != "序号") {
                if (config.lefttabtype == _lefttabtype || (config.lefttabtype == "program" && _lefttabtype == "transprogram")) {
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
        datatable.redraw(); //从新绘制表格
    }

    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _agency = treeNode.guid;
            _name = treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        _queryConfig = queryform.getQueryParam();
        _querySql = queryform.getQuerySQL();
        // var wheresql = "";
        // var company = _queryConfig[0].company; //金额单位
        // var oper_pro_total_amt = _queryConfig[0].oper_pro_total_amt; //项目总金额最大值
        // var pro_total_amt = _queryConfig[0].pro_total_amt; //项目总金额最小值
        // var oper_bgtamt = _queryConfig[0].oper_bgtamt;  //当年预算金额查询范围
        // var bgtamt = _queryConfig[0].bgtamt;  //当年预算金额值
        // if (company == "2") { //单位：万元
        //     pro_total_amt = pro_total_amt != null ? (parseFloat(pro_total_amt) * 10000) : null;
        //     bgtamt = bgtamt != null ? (parseFloat(bgtamt) * 10000) : null;
        // } else if (company == "3") { //单位：亿元
        //     pro_total_amt = pro_total_amt != null ? (parseFloat(pro_total_amt) * 100000000) : null;
        //     bgtamt = bgtamt != null ? (parseFloat(bgtamt) * 100000000) : null;
        // }
        // var a = _querySql.indexOf("(COMPANY");
        // var b = _querySql.indexOf("(PRO_TOTAL_AMT");
        // var c = _querySql.indexOf("(BGTAMT");
        // var  index = a;
        // if (a == -1) {
        //     index = b;
        //     if (b == -1) {
        //         index = c;
        //     }
        // }
        // if (index != -1) {
        //     wheresql = _querySql.substring(0, index);
        //     if (pro_total_amt != null) {
        //         wheresql += "(pro_total_amt " + oper_pro_total_amt + pro_total_amt + ") and ";
        //     }
        //     if (bgtamt != null) {
        //         wheresql += "(bgtamt " + oper_bgtamt + bgtamt + ") and ";
        //     }
        //     wheresql = wheresql.substring(0, wheresql.length - 4);
        //     _querySql = wheresql;
        // }
        cmp.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "warn") { //目标值构建符号和单位
                col.cseditfn = function (i, j, rs, style) { //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var warn = !data.warn ? "" : data.warn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }
        }
    });

    //送审情况
    cmp.queryaudit = function () {
        common.auditquery(datatable);
    }

    /**
     * 查看明细
     */
    cmp.detailed = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].projguid;
        params.procode = data[0].pro_code;
        params.viewtype = "query";
        params.bustype = _lefttabtype;
        params.tablecode = _tablecode;
        params.wfstatus = data[0].wfstatus;
        params.querycode = true;  //部门整体目标查询条件
        params.proguid = data[0].projguid;
        if (_isNINGXIA) {
            params.projectkind = _lefttabtype;
        } else {
            params.projectkind = data[0].projectkind;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效自评查看-" + _lefttreename);
    }

    /**
     * 查看项目
     */
    cmp.showProjView = function (obj){
        var params = {};
        var datas = datatable.getSelected();
        if (datas.size() != 1) {
            Ext.lt.ui.alert('请选择一条项目数据进行查看！', function () {
            });
            return;
        }
        params.proguid = datas[0].projguid;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.doubleprocess.TlpJxAuditService", "getProInfo", params);
        params.submenu = _menuid;
        params.pro_code = datas[0].pro_code;
        var pro_lev;
        if (xmxxEditobject && xmxxEditobject.length > 0) {
            pro_lev = xmxxEditobject[0].pro_lev;
            params.vchtypeid = xmxxEditobject[0].vchtypeid;
            params.projectkind = xmxxEditobject[0].projectkind;
        }
        if(pro_lev == "1"){
            common.queryPromain(datatable,params);
        }else {
            common.proinfoview(datatable,params);
        }
    }

    /**
     * 河北导出
     * @param obj
     */
    cmp.hbexpdoc = function(obj){
        var data = datatable.getSelected();
        if (data.size() == 0) {
            alert("请选择数据进行导出！");
            return;
        }
        var guids = [];
        for(var i=0;i<data.length;i++){
            guids.push(data[i].guid);
        }
        var btnconfig = eval('(' + obj.config + ')');
        var templatecode = btnconfig.tempatecode;
        var bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        var parammap = new Map();
        parammap.set("templatecode", templatecode);
        parammap.set("guids", guids);
        parammap.set("bobeanid", bobeanid);
        common.hbExpdocFile(parammap);
    }

    //模板导出
    cmp["expdoc"] = function(btn){
        var datas = datatable.getSelected();
        if(datas.length <= 0){
            Ext.lt.ui.alert("请选择数据！", function () {
            });
            return;
        }
        var btnconfig = eval('(' + btn.config + ')');
        var _tempatecode;
        var reporttype;//导出报告类型，一般监控报告，项目、部门整体报告
        var guids = [];
        var param = {};
        if (_lefttabtype == "program") {
            _tempatecode = btnconfig.protempatecode;
            reporttype = btnconfig.proexptype;
        } else if (_lefttabtype == "dept") {
            _tempatecode = btnconfig.depttempatecode;
            reporttype = btnconfig.deptexptype;
        }
        for (var i = 0; i < datas.length; i++) {
            var data = datas[i];
            guids.push(data["guid"]);
        }
        param.guids = guids;
        param.templatecode = _tempatecode;
        param.exptype = _lefttabtype;
        param.reporttype = reporttype;
        param.viewtype = btnconfig.viewtype;
        param.bobeanid = "pmkpi.perfSelf.PerfSelfApplyBOTX";
        Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService", 'createWord', param, "downframe");
        var rcpconsole = document.getElementsByClassName('rcpconsole');
        for(var i = 0; i < rcpconsole.length; i++){
            rcpconsole.item(i).style.display = 'none';
        }
        Ext.lt.ui.loadingClose();
    }

    cmp.tjhzexpdoc = function(btn){
        var btnconfig = eval('(' + btn.config + ')');
        var _tempatecode = btnconfig.tempatecode;
        var param = {};
        param.templatecode = _tempatecode;
        param.menuid = _menuid;
        param.bobeanid = "pmkpi.perfSelf.PerfSelfQueryBOTX";
        Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService",'createWord',param,"downframe");
        var rcpconsole=document.getElementsByClassName('rcpconsole');
        for(i=0;i<rcpconsole.length;i++){
            rcpconsole.item(i).style.display = 'none';
        }
        Ext.lt.ui.loadingClose();
    }

    /**
     * 批量导出指标完成情况及其他附件
     */
    cmp.indexFileExp = function(obj) {
        var buttonconfig = eval('(' + obj.config + ')');
        var data = datatable.getSelected();
        if(data.length < 1){
            Ext.lt.ui.alert( "请选择数据进行附件导出！",function(){
            });
            return;
        }
        var list = [];
        for (var i = 0; i < data.size(); i++) {
            var params = {};
            params.guid = data[i].guid;//数据id
            params.name = data[i].name;//名称
            params.code = data[i].pro_code;//项目编码
            params.agency = data[i].agencyguid;//单位
            list.push(params);
        }
        var params = {};
        params.bustype =  _lefttabtype + "selfindexfile" ; // 文件表类型
        params.fileexptype = "self"; //附件导出类型: 自评
        params.list = list;
        params.tokenid = Ext.lt.token.getTokenid();
        params.zipname = buttonconfig.zipname;
        var ins = Ext.lt.RCP.down("pmkpi.perfcommon.fileexp.FileExpService",'indexFileExp',params,'downframe');
    }

    /**
     * 查看项目资金来源
     */
    cmp.querySourceFund = function (){
        var cols = [];
        cols.push("agencyguid");
        cols.push("projguid");
        cols.push("pro_code");
        var url = "/pmkpi/program/sourcefund.page";
        common.queryDataList(cols, url);
    }

    return cmp;
}
