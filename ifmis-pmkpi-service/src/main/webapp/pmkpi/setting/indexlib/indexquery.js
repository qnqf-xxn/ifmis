if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.indexquery)
    Ext.lt.pmkpi.indexquery = {};

var zcolumns = {};
Ext.lt.pmkpi.indexquery = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _treeid,
        _levelno = 1,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _indextype = config["pagetype"],
        _tablesql,
        _isleaf,
        _treeNode,
        _queryfilter,
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight,
        sxflag = "";//山西查询标识(省级指标，市级指标，县级指标)
    var cmp = {};
    var isFirst = true;

    /**
     * 加载完成后执行.
     */
    $(function () {
        common.initDatatable();
        tabChange(_lefttab);
        isFirst = false;
    })

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if (treeNode){
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
            _levelno = treeNode.levelno;
            _treeNode = treeNode;
        }else {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        cmp.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        if (obj.queryform){
            _queryfilter = obj.queryform.getQuerySQL();
        }
        cmp.query(_queryfilter);
    });

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var uiconfig = obj.table.uiconfig;
        _tablesql = uiconfig.defquery;
        zcolumns = uiconfig.columns;
        $.each(zcolumns, function(i, item){
            if(item && item["isvisiable"] == 0){
                delete zcolumns[i];
            }
        });
    });

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        cmp.query();
    }
    /**
     * 查询
     */
    cmp.query = function(filter){
        if (!_treeid) {
            _treeid = "treeroot";
        }
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.tabtype = _lefttabtype;
        params.isleaf = _isleaf;
        params.sxflag = sxflag;
        params.levelno = _levelno;
        params.tablesql = _tablesql;
        if (filter) {
            params.querySql = filter; //工作流
        }
        params.menuid = _leftmenuid; //菜单
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.setting.indexlib.query.IndexQueryBOTx";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }
    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _treeid = "treeroot";
        _isleaf = 0;
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        cmp.refdrawtable(obj);
        common.setTabNum(obj);
        common.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        var params = {};
        params.menuid = _leftmenuid;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        if (!isFirst) {
            Ext.lt.pmkpi.query();
        }
        obj.datas = datalist
        return obj;
    }
    /**
     * 重新构建表格.
     */
    cmp.refdrawtable = function(obj){
        var oldcols = zcolumns;
        datatable.columns.checkbox.style = "text-align:center";
        var columns = [datatable.columns.seq,datatable.columns.checkbox];
        $.each(oldcols, function(i, item){
            if (item){
                if (obj["code"] == 'INDEXCOMFUNC' || obj["code"] == 'INDEXCOMFUNC_ZJ' || obj["code"] == 'INDEXCOMFUNC_HuBei'
                    ||obj["code"] == 'PMKPIDEPT' || obj["code"] == 'INDEXTRANPAY' || obj["code"] == 'INDEXCOMFUNC_JiangXi'
                    || "PMKPIAGENCYALLPAY" == obj["code"]){
                    if (!item.config["iscommon"]||item["config"]["iscommon"] == 0){
                        item.display = true;
                        item.isvisiable = 1;
                    } else {
                        item.display = false;
                        item.isvisiable = 0;
                    }
                }
                if (obj["code"] == 'IDEXCOMCLS'){
                    if (!item.config["iscommon"]||item["config"]["iscommon"] == 1){
                        item.display = true;
                        item.isvisiable = 1;
                    } else {
                        item.display = false;
                        item.isvisiable = 0;
                    }
                }
                if (obj["code"] == 'INDEXTRANPAY'){
                    if ((item["config"]["lefttype"] == _lefttabtype && item["config"]["iscommon"] == 0) || item["config"]["iscommon"] == 1){
                        item.display = false;
                        item.isvisiable = 0;
                    } else {
                        item.display = true;
                        item.isvisiable = 1;
                    }
                }
                columns.push(item);
            }
        });
        Ext.lt.cache.removeData("dtcolumn_" + datatable.id);
        datatable.setCols(columns);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    //省级指标查看
    cmp.provinceindex = function () {
        sxflag = "province";
        Ext.lt.pmkpi.query();
    }

    //市级指标查看
    cmp.cityindex = function () {
        sxflag = "city";
        Ext.lt.pmkpi.query();
    }

    //县级指标查看
    cmp.countyindex = function () {
        sxflag = "county";
        Ext.lt.pmkpi.query();
    }

    //送审情况
    cmp.showwfinfo = function (){
        common.auditquery(datatable);
    }

    /**
     * 查看明细
     */
    cmp.detailed = function () {
        var selectDatas = datatable.getSelected();
        if (!selectDatas || selectDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条指标进行查看明细！",function(){});
            return;
        }
        var url = "/pmkpi/indexlib/edit.page"; //个性
        if (_indextype=="finance" && _lefttabtype=="IDEXCOMCLS") {//共性指标
            url = "/pmkpi/indexlib/commedit.page";
        }
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.tabtype = _lefttabtype;
        params.pagetype = "mod";
        params.viewtype = "query";
        // params.workflow = _workflow; //工作流
        params.guid = selectDatas[0]["guid"];
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"查看指标");
    }

    return cmp;
}
