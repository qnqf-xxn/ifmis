if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptoverallmerit){
	Ext.lt.pmkpi.deptoverallmerit = {};
}

var _selectedtree=null;
Ext.lt.pmkpi.deptoverallmerit.deptoverallmeritmanageservice = function(config, service){
    // window.parent.Ext.lt.pmkpi.childwindow = window;
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _savetable = config.tablecode,
        _bustype = config.bustype,
        _agency,
//        _prokind,
        _tablecode,
        _ctablecode,
        _tabfilter,
        _tabcode,
		_name,
        _pagetype,
        _uikey,
        _defquery,
        _orderby,
        _fromtables = config.fromtables,
        _deltables,
        _delcols,
        _modelguid = config.modelguid,
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

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });


    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _bustype = config.bustype;
        _uikey = config.uikey;
        _fromtables = config.fromtables;
        _modelguid = config.modelguid;
        _deltables = config.deltables;
        _delcols = config.delcols;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
    });

    /**
     * 下达
     */
    cmp.add = function (obj){
        var config = obj.config;
        var datas = datatable.getSelected();
        if(datas.length <= 0){
            Ext.lt.ui.alert("请选中至少一条数据进行下达！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.bustype = _bustype;
        params.fromtables = _fromtables;
        params.modelguid = _modelguid;
        params.name = _name;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "saveTask", params, function(rs){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('任务下达成功！',function(){
            	Ext.lt.ui.loadingClose();
                Ext.lt.pmkpi.query();
            });
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('任务下达失败！',function(){
            });
        });
    }

    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.deltables = _deltables;
        params.delcols = _delcols;
        deptcmp.deltable(datatable, params);
    }

    //送审/审核
    cmp.wfAudit = function (obj){
        var actionname = obj.name;
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + actionname + "的数据！",function(){});
            return;
        }
        if (!deptcmp.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        deptcmp.doAction(obj, params);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
//        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        deptcmp.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        var config = obj.config;
        var tabconfig = eval('(' + config + ')');
        _ctablecode = tabconfig.tablecode;
        Ext.lt.pmkpi.query();
    }


    /**
     * 保存
     * @returns {boolean}
     */
    cmp.save = function(){
        if (!editform.check()) return false;
        var datas = parent.datatable.getSelected();
        var params = {};
        params.datas = datas;
        params.infodata = editform.getEditFormValues();
        params.tablecode = _savetable;
        params.workflow = _workflow;
        params.bustype = _bustype;
        params.fromtables = _fromtables;
        params.modelguid = _modelguid;
        params.name = _name;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "saveTask", params, function(rs){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('任务下达成功！',function(){
                Ext.lt.ui.closeModalWindow();
                window.parent.Ext.lt.pmkpi.query();
            });
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('任务下达失败！',function(){
            });
        });
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    return cmp;
}


//左侧树切换页签事件
function tabChange(index, cfg){
	_selectedtree= index.code;
}
