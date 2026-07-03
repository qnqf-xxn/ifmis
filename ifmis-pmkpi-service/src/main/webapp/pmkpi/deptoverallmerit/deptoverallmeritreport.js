if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptoverallmerit){
	Ext.lt.pmkpi.deptoverallmerit = {};
}

var _selectedtree=null;
Ext.lt.pmkpi.deptoverallmerit.deptoverallmeritreportservice = function(config, service){
    // window.parent.Ext.lt.pmkpi.childwindow = window;
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _savetable = config.tablecode,
        _infotablecode,
        _infosavetablecode,
        _busguid,
        _agency,
        _bustype,
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

    $(function (){
        common.initDatatable();
    })
    
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
        params.viewtype = _uikey.indexOf("audit")=="-1" ? "edit" : "audit";
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
        _busguid = config.busguid,
        _infotablecode = config.infotablecode;
        _infosavetablecode = config.infosavetablecode;
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
                    params.workflow = _workflow;
                    params.bustype = _bustype;
                    params.menuid = _menuid;
                    params.tablecode = _infotablecode;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门综合评价");
                };
            }
        }
    });

    /**
     * 填报/修改
     */
    cmp.save = function (obj){
        var config = obj.config;
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert("请选择一条数据进行填报/修改！",function(){});
            return;
        }
        var params = {};
        params.pagetype = "editreport";
        params.workflow = _workflow;
        params.type = "dept";
        var url = _uikey + ".page";
		if (data.length == 1) {
		    params.saveAgency = data[0].agencyguid;
            //params.mainguid = data[0].perfgoalguid;
            //params.projguid = data[0].projguid;
            params.mainguid = data[0].guid;
            params.bustype = _bustype;
            params.menuid = _menuid;
            params.viewtype = url.indexOf("audit")=="-1" ? "edit" : "audit";
            params.tablecode = _infotablecode;
            params.tabcode = _infosavetablecode;
		}
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门综合评价填报");
    }

    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.pagetype = _pagetype;
        params.deltables = _deltables;
        params.delcols = _delcols;
        common.deltable(datatable, params);
    }

    //送审/审核
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.actioncode = obj.code;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.bustype = _bustype;
        params.menuid = _menuid;
        params.busguid = _busguid;
        params.viewtype = _uikey.indexOf("audit")=="-1" ? "edit" : "audit";
        var method = _uikey.indexOf("audit")=="-1" ? "sendToFinintorg" : "sendtonext";
        var check = false;
        if(obj.code == "cancelsendaudit" && _uikey.indexOf("audit")=="-1"){
        	//取消送审，校验数据流程
        	var rs = Ext.lt.RCP.asyncall(serviceid , "checkSubmitstatus", params);
            if (rs && rs.success == true){
            	check = true;
            }else {
            	Ext.lt.ui.alert(obj.name + "失败！所选择的数据财政已审核",function(){
                });
            }
        }else{
            var str = "";
            for (var i = 0; i < datas.length; i++) {
                str += "'" + datas[i].guid + "',";
            }
            if (str.length > 0) {
                str = str.substr(0,str.length - 1);
            }
            params.mainguid = str;
            // 送审，提交校验附件
            var rs = Ext.lt.RCP.asyncall(serviceid , "checkFile", params);
            if (rs && rs.success == true){
                check = true;
            }else {
                Ext.lt.ui.alert(obj.name + "失败,"+rs.msg,function(){
                });
            }
        }
        if(check){
        	Ext.lt.ui.confirm('是否确定“' + obj.name + '”已选择的数据？',null,function(is){
        		if(is){
        			Ext.lt.ui.loadingShow();
        			Ext.lt.RCP.call(serviceid, method, params, function(rs){
        				if (rs && rs.success == true){
        					Ext.lt.ui.alert( obj.name + "成功！",function(){
        						Ext.lt.ui.loadingClose();
        						cmp.query();
        					});
        				}else {
        					if (rs.success == false){
        						common.openlistdiv(rs);
        					} else if (!rs){
        						return false;
        					} else {
        						Ext.lt.ui.alert(obj.name + "保存失败！",function(){
        						});
        					}
        				}
        				Ext.lt.ui.loadingClose();
        			},function(resp){
        				Ext.lt.ui.loadingClose();
        				var alertmsg = obj.name + "失败！\n失败原因：" + resp;
        			});
        		}
        	});    
        }
        return rs;
    }
    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
//        changToolbuttonStatus(toolbutton, 0, obj.hidebtns);
    	common.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        Ext.lt.pmkpi.query();
    }

    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery : true,
            datatable : 'datatable',
            drawmode :'div',
            key: key,
            label: "快速查询",
            labelwidtreporttraceh: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength:18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }


    return cmp;
}


//左侧树切换页签事件
function tabChange(index, cfg){
	_selectedtree= index.code;
}
