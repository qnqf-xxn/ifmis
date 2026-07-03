if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.randomComment){
    Ext.lt.pmkpi.randomComment = {};
}

Ext.lt.pmkpi.randomComment.resultIndex = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _busguid,
        _agency,
        _prokind,
        _tablecode = config.tablecode,
        _tabcode,
        _tabfilter,
        _proTable,
		_name,
        _pagetype,
        _uikey,
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
        _tempatecode = config.tempatecode,
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
            key = '/pmkpi/randomcomment/result/index';
            //_uikey = "/pmkpi/perfself/apply/edit";
        } else if (_lefttabtype == "dept") {
            key = '/pmkpi/randomcomment/result/dept';
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
        params.beanid = "pmkpi.randomcomment.RandomCommentResultBOTX";
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
    
    Ext.lt.message.hook("perfcommon", "auditquery",function(){
    	Ext.lt.ui.closeModalWindow();
        parent.Ext.lt.pmkpi.query();
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
        _proTable = config.proTable;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        _bustype = config.bustype;
        _deltables = config.deltables;
        _delcols = config.delcols;
        _busguid = config.busguid;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "projname"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.projname + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                	var url = _uikey + ".page";
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
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"抽评结果查看");
                };
            }
        }
    });
    
    cmp.report = function (obj){
    	var size = datatable.getRecordSet().size();
		if(size>0){
			var datas = datatable.getSelected();
	        if (datas.length <= 0) {
	            Ext.lt.ui.alert("请选择一条信息进行填报！",function(){});
	            return;
	        }
	        if (datas.length > 1) {
	            Ext.lt.ui.alert("最多选择一条信息进行填报！",function(){});
	            return;
	        }
			/*var guid = null;
            var mainguid = null;
			var projguid = null;
			var agencyguid = null;
            var procode = null;
			for(var i=0;i<datas.size();i++){
                var params = {};
                params.projguid = datas[i].projguid;
                var rs = Ext.lt.RCP.asynserver("pmkpi.perfSelf.PerfSelfApplyService", "findByProjGuid", params);
                mainguid = rs.guid;	// 自评质量数据id
				projguid = rs.projguid; // 项目基本信息id
				agencyguid = rs.agencyguid;
                procode = rs.pro_code;
			}*/
			var url = _uikey + ".page";
	        var params = {};
	        params.mainguid = datas[0].selfguid;
	        params.projguid = datas[0].projguid;
	        params.tabcode = _proTable;
	        params.bustype = _bustype;
	        params.menuid = _menuid;
	        params.saveAgency = datas[0].agencyguid;
	        params.procode = datas[0].pro_code;
	        url = Ext.lt.pmkpi.genPageUrl(url, params);
	        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"抽评结果填报")
		}else{
			Ext.lt.ui.alert('页面无数据！');
			return ;
		}
    	
    }
    
    cmp.submit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.actioncode = obj.code;
        params.tablecode = _tabcode;
        params.busguid = _busguid;
        Ext.lt.ui.confirm('是否确定“' + obj.name + '”已选择的数据？',null,function(is){
            if(is){
            	Ext.lt.ui.loadingShow();
//            	var rs = Ext.lt.RCP.asyncall(serviceid , "submit", params);
            	Ext.lt.RCP.call(serviceid, "submit", params, function(rs){
	                if (rs && rs.success == true){
	                    Ext.lt.ui.alert( obj.name + "成功！",function(){
	                    	cmp.query();
	                    });
	                }else {
	                    if (rs.success == false){
	                    	deptcmp.openlistdiv(rs);
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
//                    Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
//                    });
                });
            }	
        });    
    }

    //页签方法
    cmp.clickTabpage = function(obj){
    	deptcmp.changTooltoolbuttontStatus(0, obj.hidebtns);
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
	cmp.upload = function(){
		var url = "/pmkpi/randomComment/resultFile.jsp";
        var params = {}; 
        params.menuid = _menuid;
        Ext.lt.ui.openModalWindow(url,"800","450","上传评价结果");

        
//        var trandom = $("#tttt");
//		Ext.lt.HTML.mark();
//		trandom.remove();
////		if(trandom.size()==0){
//			var url = Ext.lt.token.urlAddToken("/pmkpi/randomComment/resultFile.jsp");
//			var htmlArr = [];
//			var zindex = 200000 + Ext.lt.ui.getwinindex();
//			htmlArr.push("<div id='tttt' style='position: absolute;z-index:"+zindex+";left: 428px; top: 173px; display: block;'>");
//			htmlArr.push("<iframe src='"+url+"' allowtransparency='true' style='background-color:transparent;width:800px;height:450px; border: white;' scrolling='yes'></iframe>");
//			htmlArr.push("</div>");
//			trandom = $(htmlArr.join(""));
//			$("body").append(trandom);
////		}
//		trandom.show();
//	    Ext.lt.HTML.center(trandom[0]);
	}
	
	cmp.exp = function(obj){
		var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！",function(){});
            return;
        }
        var params = [];
        var data = {};
        var arr = [];
		for(var i=0;i<datas.size();i++){
		     var list = {};
            // var list = new Map();
			list.mainguid = datas[i].guid;	// 自评质量数据id
			list.bustype = _bustype;
			list.tablecode = _tabcode;
			list.menuid = _menuid;
			list.projguid = datas[i].projguid;
			list.code = datas[i].projcode;
			list.name = datas[i].projname;
			arr.push(list);
            data.datas = arr;
		}
		params.push (data);
		var url = "/pmkpi/expFileController/expFile.do";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
        var ids = [];
        ids.push("111");
        ids.push("222");
        ids.push("333");

        var json= JSON.stringify(arr);
        json = json.replace(/,/g,"&");
        jQuery.ajax({
			/*type : 'POST',
			dataType : 'json',
			//contentType : 'application/json',
			contentType : 'application/x-www-form-urlencode;charset=utf-8',
			url : url,
            traditional: true,
            data : {listMap :param},*/

            url : url,
            data:{ids:json,
            id:ids},
            type : 'POST',
            traditional: true,
			success : function(data) {
				if(data.success){
			        var url = "/pmkpi/randomComment/exportFile.jsp?size="+datas.size();
	        		Ext.lt.ui.openModalWindow(url,"650","120","导出评价结果");
	    	   } else {
	    		   
	    	   }
			}
		});
		
//		Ext.lt.RCP.call(serviceid, "expFile", params, function(rs){
//            if (rs && rs.success == true){
//            }else {
//                Ext.lt.ui.alert(obj.name + "保存失败！",function(){
//                });
//            }
//            Ext.lt.ui.loadingClose();
//    	},function(resp){
//            Ext.lt.ui.loadingClose();
//            var alertmsg = obj.name + "失败！\n失败原因：" + resp;
////            Ext.lt.ui.alert(alertmsg,{timeout:5},function(){
////            });
//        });
		
		//window.open("/pmkpi/randomComment/files/code&name&date.xlsx");
	}

    cmp.expdoc = function(obj){
        obj.config ="{tempatecode:'"+ _tempatecode+"'}";
        Ext.lt.pmkpi.expdoc(obj, datatable);
    }


    //导入
    cmp.import  = function(obj){
        // 暂时写死导入模板的code
        var importcode = "pmkpi_randomresult";
        var vchtypeid = "28EEDFD75D961E146149497926D63252";
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.vchtypeid = vchtypeid;
        params.tabtype = _lefttabtype;
        params.rowtype = "add";
        params.workflow = _workflow;
        params.menuid = _menuid;
        window.importparam = params;
        params.importcode = importcode;
        params.tablecode = _tablecode;
        Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(){
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.pmkpi.impsucess();
        });
    }
	
    return cmp;
}
function xml_parse(input) {
    //支持chrome IE10  
    if (window.FileReader) {   
        var  file = input.files[0];  
    }
}
//左侧树切换页签事件
function tabChange(index, cfg){
	_selectedtree= index.code;
}