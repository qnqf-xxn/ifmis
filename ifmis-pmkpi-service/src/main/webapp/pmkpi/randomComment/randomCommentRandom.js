if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.randomComment){
    Ext.lt.pmkpi.randomComment = {};
}

Ext.lt.pmkpi.randomComment.randomIndex = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var random = Ext.lt.pmkpi.randomComment.random(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _agency,
        _prokind,
        _tablecode = config.tablecode,
        _tabcode,
        _tabcode1,
        _tabfilter,
		_name,
        _pagetype,
        _uikey,
        _uikey1,
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
            key = '/pmkpi/randomcomment/random/index';
            //_uikey = "/pmkpi/perfself/apply/edit";
        } else if (_lefttabtype == "dept") {
            key = '/pmkpi/randomcomment/random/dept';
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
        params.beanid = "pmkpi.randomcomment.RandomCommentRandomBOTX";
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
    
    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tabcode = config.tabcode;
        _tabcode1 = config.tabcode1;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        _uikey1 = config.uikey1;
        _deltables = config.deltables;
        _delcols = config.delcols;
        _bustype = config.bustype;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
        }
    });


    cmp.setup = function (obj){
    	var url = _uikey + ".page";
        var params = {};
        params.bustype = _bustype;
        params.tabcode = _tabcode1;
        var a = 0;
        var b = 0;
        var c = 0;
        var d = 0;
        var data = datatable.getRecordSet().toArray();
        for(var i=0;i<data.length;i++){
            if(data[i].selfresult == "优"){
                a++
            } else if(data[i].selfresult == "良"){
                b++
            }else if(data[i].selfresult == "中"){
                c++
            }else if(data[i].selfresult == "差"){
                d++
            }
        }
        params.randomprojcount = a+","+b+","+c+","+d;
        //params.randomprojcount = datatable.getRecordSet().size();
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,"400","300","随机抽取设置")
    }
    
    cmp.start = function (obj){
    	var allDatas = datatable.getRecordSet().toArray();
    	if(allDatas.size > 0){
			config = Ext.lt.RCP.asyncall(serviceid , "queryRandom", _bustype);
			if(!config){
				Ext.lt.ui.alert("请先设置抽取数量!",{icon:"sucess",timeout:2},function(){
//					Ext.lt.pmkpi.query();
				});
			}else{
				var config = {};
	    		config.data = allDatas;
				config.israndom = "1";
				config.bustype = _bustype;
				config.tablecode = _tabcode1;
				config = Ext.lt.RCP.asyncall(serviceid , "submitRandom", config);
				if(config.error){
					Ext.lt.ui.alert(config.error);
				}else{
					// 随机抽取页面调用
					random.random(config.result,config.rantime);
//					Ext.lt.ui.alert("标识成功!",{icon:"sucess",timeout:2},function(){
//						Ext.lt.pmkpi.query();
//					});
				}
			}
    		
    		
    	} else {
    		Ext.lt.ui.alert('页面没数据！');
			return;
    	}
    	
    }

    cmp.querySelfInfo = function (){
    	var data = datatable.getSelected();
    	if(data.size()==1){
    		var url = "/pmkpi/perfself/apply/edit.page";
            var params = {};
            params.projguid = data[0].projguid;
            var rs = Ext.lt.RCP.asynserver("pmkpi.perfSelf.PerfSelfApplyService", "findByProjGuid", params);
            params.pagetype = "editreport";
            params.mainguid = rs.guid;
            params.projguid = rs.projguid;
            params.procode = rs.pro_code;
            params.saveAgency = rs.agencyguid;
            params.viewtype = "query";
            params.bustype = _bustype;
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效自评查询");
		} else if(data.size() > 1) {
			Ext.lt.ui.alert('每次只能查询一条数据！',function(){});
		} else {
			Ext.lt.ui.alert('请选择要查询的数据！',function(){});
		}
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
    cmp.del = function (){
        var size = datatable.getRecordSet().size();
        if(size>0){
            var data = datatable.getSelected();
            if (data.size() <= 0) {
                Ext.lt.ui.alert('请选择要删除的数据！');
                return;
            }
            /*var israndom = null;
            for(var i=0;i<data.size();i++){
                if(israndom == null){
                    israndom = data[i].israndom;
                }
            }
            if(israndom != null){
                Ext.lt.ui.alert("该项目被抽评对象菜单引用,删除失败!",{icon:"error",timeout:2},function(){
                });
            }else {*/
                Ext.lt.ui.confirm('是否删除已选择的数据？',null,function(is){
                    if(is){
                        var config = {};
                        config.datas = data;
                        config.tablecode = _tabcode1;
                        config = Ext.lt.RCP.asyncall(serviceid , "delByGuids", config);
                        if(config.error){
                            Ext.lt.ui.alert(config.error);
                        }else{
                            Ext.lt.ui.alert("删除成功!",{icon:"sucess",timeout:2},function(){
                                cmp.query();
                            });
                        }
                    }
                });
            //}

        }else{
            Ext.lt.ui.alert('页面无数据！');
            return ;
        }
    }

    return cmp;
}

//左侧树切换页签事件
function tabChange(index, cfg){
	_selectedtree= index.code;
}