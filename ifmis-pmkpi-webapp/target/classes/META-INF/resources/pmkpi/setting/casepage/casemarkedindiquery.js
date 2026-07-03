if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.casemarkedindi){
    Ext.lt.pmkpi.casemarkedindi = {};
}
Ext.lt.pmkpi.casemarkedindi.casemarkedindiquery = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _tablecode,
        _workflow,//工作流guid
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _defquery,//列表查询条件
        _tabcode,//页签编码
        _nodeguid,//左侧树选择单位
        _isCasetype,//是否是分类
        _leftsource,
        _defYear= config.defYear;
    var _scrHeight = Math.floor(document.documentElement.clientHeight * 0.95);
    var _scrWidth =  Math.floor(document.documentElement.clientWidth * 0.95);

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _nodeguid = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _workflow = obj.leftwfid;
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var _leftconfig = eval('(' + obj.config + ')');
        _leftsource = _leftconfig.leftsource;
        common.changTooltoolbuttontStatus(0,  _lefthidebtn);
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.leftsource = _leftsource;
        var rt = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(rt.treeDatas, 0);
        _isCasetype = rt.isCasetype;
        Ext.lt.pmkpi.query();
        obj.datas = rt.treeDatas;
        return obj;
    }


    $(function (){
        common.initDatatable();
        cmp.setTableColum();
        var _lefttab = lefttree.getActiveTabCfg();
        tabChange(_lefttab);
    })

    /**
     * 动态设置近三年引用次数列名
     */
    cmp.setTableColum = function(){
        var cols = datatable.getCols();
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            if (col.colcode == "indi_count1") {
                col.alias = _defYear-2;
            }else if (col.colcode == "indi_count2") {
                col.alias = _defYear-1;
            }if (col.colcode == "indi_count3") {
                col.alias = _defYear;
            }
        }
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
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
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.nodeguid = _nodeguid;
        params.isCasetype = _isCasetype;
        params.leftsource = _leftsource;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.type = "indilist";
        params.beanid = "pmkpi.casemarkedindi.CasemarkedIndiBOTX";
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
        if(treeNode){ //不选择预算单位按类型查询
            _nodeguid = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        Ext.lt.pmkpi.query();
    });

    /**
     * 查看引用项目列表
     */
    cmp.showProList = function (data,year) {
        var params = {};
        params.queryYear = year;
        params.indi_code = data.indi_code;
        params.menuId = _leftmenuid;
        var url = "/pmkpi/casemarkedindi/prolist.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight, year+"年度引用情况");
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "indi_count1" || col["colcode"] == "indi_count2" || col["colcode"] == "indi_count3") {
                col.style = " text-align:center;";
                col.fn = function(l, c, data, val){
                    var html = '<a title = ' + val + ' style="color:#468ac9;cursor:pointer;">' + val + '</a>';
                    return html;
                }
                if (col["colcode"] == "indi_count1") {
                    col.onclick = function(td, el, l, c, d) {
                        cmp.showProList(d,_defYear-2);
                    };
                }
                if (col["colcode"] == "indi_count2") {
                    col.onclick = function(td, el, l, c, d) {
                        cmp.showProList(d,_defYear-1);
                    };
                }
                if (col["colcode"] == "indi_count3") {
                    col.onclick = function(td, el, l, c, d) {
                        cmp.showProList(d,_defYear);
                    };
                }
            }
        }
    });

    return cmp;
}