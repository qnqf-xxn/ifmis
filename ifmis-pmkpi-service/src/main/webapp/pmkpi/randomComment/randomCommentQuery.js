if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.randomComment){
    Ext.lt.pmkpi.randomComment = {};
}

Ext.lt.pmkpi.randomComment.queryIndex = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _agency,
        _prokind,
        _tablecode = config.tablecode,
        _tempatecode = config.tempatecode,
        _tabcode,
        _tabfilter,
		_name,
        _pagetype,
        _uiquerykey,
        _defquery,
        _orderby,
        _deltables,
        _delcols,
        _bustype,
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _leftmenuid,//隐藏菜单
        _isfirst = true, // 是否第一次进页面（控制查询方法）
        _displaycols = [],
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    var agencydata;

    var serviceid = service;
    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        //查询之前处理待送审，还是被退回页签
        deptcmp.pendingtasktab();
        tabChange(_lefttab);
        _isfirst = false;
    })

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _agency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _bustype = _lefttabtype;
        _workflow = obj.leftwfid;
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var data;
        var key;
        if (_lefttabtype == "program") {
            data = _proqfdatas;
            key = '/pmkpi/randomcomment/query/index';
            //_uikey = "/pmkpi/perfself/apply/edit";
        } else if (_lefttabtype == "dept") {
            key = '/pmkpi/randomcomment/query/dept';
            //_uikey = "/pmkpi/randomcomment/scope/dept/edit";
            data = _deptqfdatas;
        }
        queryfrom(data, key);
        //deptcmp.changTooltoolbuttontStatus(0,  _lefthidebtn + "," + _tabhidtbtn);
        cmp.setTableColum();
        deptcmp.setworkflow(_workflow);
        var treelist = Ext.lt.pmkpi.querytree();
        obj.datas = treelist
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
        params.leftmenuid = _leftmenuid;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.pmkpi.query();
        return datalist;
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
        datatable.redraw(); //从新绘制表格
    }

    
    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
    	//获取选中的左侧树code
//    	var index = lefttree.cfg.activeTab;
//    	var activedics = lefttree.cfg.dics[index];
//    	_selectedtree = activedics;
        if(!_agency){
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
//        if(!_prokind){
//        	_prokind = "treeroot";
//        	Ext.lt.pmkpi.isleaf = 0;
//        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
//        params.prokind = _prokind;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.bustype = _bustype;
        params.beanid = "pmkpi.randomcomment.RandomCommentQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
        /*Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            if (rs && rs.data && rs.data.length == 1) {
                agencydata = rs.data[0];
            } else {
                agencydata = [];
            }
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });*/
    }

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            cfg.key = datatable.key;//datatable的key值
            cfg.bustable = datatable;
            if (data.size() == 0) {
                if (Ext.lt.ui.confirm("是否导出当前全部数据？")) {
                    cfg.hassql = 1;
                    cfg.beanid = config.bobeanid;//业务具体的bo  主要用到 bo中getvodsql()方法
                    if (typeof (queryform) != 'undefined') {
                        cfg.isHaveQueryForm = true;//是否有查询区
                        cfg.queryConfig = queryform.getQueryParam();//查询区条件
                    }
                    cfg.isHaveTabPage = true;
                    cfg.filter = " 1=1 ";
                    cfg.downtype = 'xls';
                    dataexport.excelexport(cfg);
                } else {
                    return;
                }
            } else {
                cfg.downtype = 'xls';//下载  类型
                dataexport.excelexport(cfg);
            }
        } else {
            Ext.lt.ui.alert("页面无数据！", {timeout: 1}, function () {
            });
            return;
        }
    }

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _agency = treeNode.guid;
            _name=treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tabcode = config.tabcode;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uiquerykey = config.uiquerykey;
        _bustype = config.bustype;
        _deltables = config.deltables;
        _delcols = config.delcols;
        var cols = obj.cols;
        var key = obj.table.key;
        var str = 0;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "projname"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.projname + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                	var url = _uiquerykey + ".page";
                    var params = {};
                    params.projguid = d.projguid;
                    var rs = Ext.lt.RCP.asynserver("pmkpi.perfSelf.PerfSelfApplyService", "findByProjGuid", params);
                    params.pagetype = "editreport";
                    params.mainguid = rs.guid;
                    params.saveAgency = rs.agencyguid;
                    params.projguid = rs.projguid;
                    params.procode = rs.pro_code;
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    params.bustype = _bustype;
                    params.menuid = _menuid;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"抽评结果填报查看");
                };
            }
        }
    });


    //页签方法
    cmp.clickTabpage = function(obj){
        deptcmp.changTooltoolbuttontStatus(0,  obj.hidebtns);
        _tabfilter = obj.filter;
        var config = obj.config;
        var tabconfig = eval('(' + config + ')');
        _ctablecode = tabconfig.tablecode;
        Ext.lt.pmkpi.query();
    }

    cmp.showProjView = function (obj){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        deptcmp.proinfoview(datatable,params);
    }
    
    //导出抽评报告
    cmp.expdoc = function(obj){
    	obj.config ="{tempatecode:'"+ _tempatecode+"'}";
    	Ext.lt.pmkpi.expdoc(obj, datatable);
    }
    
    //导出自评报告
    cmp.expselfdoc = function(obj){
    	obj.config ="{tempatecode:'selfevalproindex'}";
    	Ext.lt.pmkpi.expdoc(obj, datatable);
    }
    
    return cmp;
}

//左侧树切换页签事件
function tabChange(index, cfg){
	_selectedtree= index.code;
}