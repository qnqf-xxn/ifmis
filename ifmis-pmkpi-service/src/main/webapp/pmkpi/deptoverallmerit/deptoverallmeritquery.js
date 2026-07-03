if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptoverallmerit){
	Ext.lt.pmkpi.deptoverallmerit = {};
}

var _selectedtree=null;
Ext.lt.pmkpi.deptoverallmerit.deptoverallmeritqueryservice = function(config, service){
    // window.parent.Ext.lt.pmkpi.childwindow = window;
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _savetable = config.tablecode,
        _infotablecode,
        _agency,
        _bustype,
        _querytype = config.querytype,
//        _prokind,
        _tablecode,
        _viewtabcode,
        _ctablecode,
        _tabfilter,
        _tabcode,
		_name,
        _pagetype,
        _uikey,
        _defquery,
        _orderby,
        _deltables,
        _delcols,
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;

    var serviceid = service;
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
//        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
//        params.prokind=_prokind;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.viewtabcode = _viewtabcode;
        params.pagetype = _pagetype;
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.ctablecode = _ctablecode;
        params.bustype = _bustype;
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    //导出
    cmp["exportProj"] = function(){
        if (datatable.getRecordset().size() != 0) {
            var selectDatas = datatable.getSelected();
            var cfg = {};
            cfg.beanid = config.bobeanid;//业务具体的bo  主要用到 bo中getvodsql()方法
            cfg.isHaveQueryForm=true;//是否有查询区
            cfg.queryConfig = queryform.getQueryParam();//查询区条件
            cfg.isHaveTabPage=false;
            cfg.filter = " 1=1 ";
            cfg.key = datatable.key;//datatable的key值
            cfg.bustable = datatable;
            cfg.istitleflag='1';//使用 菜单+时间 为导出文件名
            Ext.lt.ui.addtempLog("导出数据：条数" + (selectDatas.length==0?"全部":selectDatas.length));
            dataexport.excelexport(cfg);
        } else {
            Ext.lt.ui.alert("页面无数据！",{timeout:1},function(){});
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
    
//    Ext.lt.message.hook("left", "click",function(obj){
//        var treeNode = obj.node.data;
//        if(treeNode){
//        	if(_selectedtree == "PMKPIAGENCYALLPAY" || _selectedtree == "PMKPIDEPT"){
//        		_agency = treeNode.guid;
//        		_prokind = "treeroot";
//        		Ext.lt.pmkpi.isleaf = treeNode.isleaf;
//        	}else if(_selectedtree == "PMKPIPROKIND"){
//        		_prokind = treeNode.guid;
//        		_agency = "treeroot";
//        		Ext.lt.pmkpi.isleaf = '0';
//        	}
//            _name=treeNode.name;
//        } else {
//    		_agency = "treeroot";
//    		_prokind = "treeroot";
//            Ext.lt.pmkpi.isleaf = '0';
//        }
//        cmp.query();
//    });

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });
    
    $(function () {
        cmp.query();
    })

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _viewtabcode = config.viewtabcode;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _bustype = config.bustype;
        _uikey = config.uikey;
        _deltables = config.deltables;
        _delcols = config.delcols;
        _infotablecode = config.infotablecode;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                	var url = _uikey + ".page";
                    var params = {};
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.saveAgency = d.agencyguid;
                    //params.projguid = d.projguid;
                    params.viewtype = "query";
                    params.querytype = _querytype;
                    params.workflow = _workflow;
                    params.bustype = _bustype;
                    params.menuid = _menuid;
                    params.tablecode = _infotablecode;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门综合评价查询");
                };
            }
        }
    });

    //送审情况
    cmp.queryaudit = function (){
        deptcmp.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        Ext.lt.pmkpi.query();
    }
    
    return cmp;
}


//左侧树切换页签事件
function tabChange(index, cfg){
	_selectedtree= index.code;
}
