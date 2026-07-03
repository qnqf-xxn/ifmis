if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.performance) {
    Ext.lt.pmkpi.performance = {};
}
Ext.lt.pmkpi.performance.index = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _workflow = config.workflow,//工作流guid
        _tablecode,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _leftmenuid = config.menuId,//隐藏菜单
        _tabhidtbtn,//右侧页签隐藏按钮
        // _lefttab = config.lefttab,//左侧树第一个页签
        // _lefttabtype = _lefttab.code,//左侧树页签类型
        _provincescoretype = config.provincescoretype,
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _actioncode,
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var selectdatas = [];//审核时选择得列表数据集合
    var isfirst = true;
    var ischecktab = true;
    var _displaycols = [];//页签切换隐藏列
    var tab_filters = {};//页签过滤条件集合

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function () {
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablesql = _defquery;
        params.menuId = _leftmenuid;
        if (_saveAgency == "treeroot" || _saveAgency == undefined) {
            params.filter = " 1=1 ";
        } else {
            params.filter = " oldguid='" + _saveAgency + "' ";
        }
        params.beanid = "pmkpi.workevaluate.performance.PerformanceBOTX";
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
        if (treeNode) {
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "drawed", function (obj) {
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    $(function () {
        // tabChange(_lefttab);
        common.initDatatable();
        isfirst = false;
        Ext.lt.pmkpi.query();
    });


    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        selectdatas = [];
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            try {
                Ext.lt.ui.modalWindow.close();
            } catch (e) {

            }
        }
    });

    //查看
    Ext.lt.pmkpi.info = function (obj) {
        var btnconfig = eval('(' + obj.config + ')');
        var params = {};
        params.viewtype = "query";
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        if(data[0].iseval=='2'){
            Ext.lt.ui.alert("请选择已生成绩效考核表的数据进行查看！", function () {
            });
            return;
        }
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].guid;
        params.subprovince = data[0].subprovince;
        params.taskguid = data[0].taskguid;//任务guid
        params.tasktype = data[0].tasktype;//任务类型
        params.queryProvince = data[0].subprovince;
        params.queryYear = data[0].year;
        if (btnconfig) {
            params.hidetab = btnconfig[data[0].tasktype];
        }
        params.bustype = "deptscore";//业务类型
        var url = "/pmkpi/workevaluate/performance/deptedit.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "绩效考核表-" + data[0].name);
    }
    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        // var cols = datatable.getCols(); //获取列表所有列
        // cols.push.apply(cols, _displaycols);
        // _displaycols = [];
        // for (var i = 0, len = cols.length; i < len; i++) {
        //     var col = cols[i];
        //     var config = eval(col.config);
        //     if (config && !$.isEmptyObject(config) && col.alias != "序号") {
        //         if (config.lefttabtype == _lefttabtype) {
        //             col.display = true;
        //         } else {
        //             _displaycols.push(col); //隐藏前暂存至sfagency;
        //             col.display = false; //display置为false，隐藏
        //         }
        //     }
        // }
        // datatable.setSelfdefconfig({config: "{}"});
        // datatable.redraw(); //从新绘制表格
    }
    return cmp;
}