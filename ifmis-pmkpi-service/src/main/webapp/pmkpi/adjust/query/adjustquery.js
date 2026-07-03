if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.adjust) {
    Ext.lt.pmkpi.adjust = {};
}

Ext.lt.pmkpi.adjust.queryservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _tablecode,
        _prolev = config.prolev,//项目级次
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _displaycols = [];

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var data;
        var key;
        if (_lefttabtype == "program") {
            data = _proqfdatas;
            key = '/pmkpi/adjust/report/program';
        } else if (_lefttabtype == "dept") {
            key = '/pmkpi/adjust/report/dept';
            data = _deptqfdatas;
        }
        cmp.setTableColum();
        queryfrom(data, key);
        common.changTooltoolbuttontStatus(0,  _lefthidebtn);
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.pmkpi.query();
        obj.datas = datalist
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

    $(function () {
        common.initDatatable();
        tabChange(_lefttab);
    })

    //查询
    cmp.query = function (obj) {
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function () {
        if (!_saveAgency) {
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
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.tabfilter = _tabfilter;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.adjust.query.AdjustQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) { //不选择预算单位按类型查询
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function (cols) {
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
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.proguid = data[0].proguid;
        params.viewtype = "query";
        params.prolev = _prolev;
        params.bustype = _lefttabtype;
        params.procode = data[0].pro_code;
        params.projectkind = data[0].projectkind;
        var url = "";
        if (_lefttabtype && "program" == _lefttabtype) { //项目支出
            url = "/pmkpi/adjust/report/proedit.page";
        } else if (_lefttabtype && "dept" == _lefttabtype) { //部门整体
            url = "/pmkpi/adjust/report/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效目标调整-" + _lefttreename);
    }

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        Ext.lt.pmkpi.query();
        Ext.lt.ui.closeModalWindow();
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    /**
     * 查看项目明细
     */
    cmp.prodetailed = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        common.proinfoview(datatable,params);
    }

    return cmp;
}