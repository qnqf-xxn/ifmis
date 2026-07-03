if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};

Ext.lt.pmkpi.buspageservice = function(config, service){
	var perfcommon = Ext.lt.pmkpi.perfcommon(config, service);
	var cmp = {};
	var serviceid = service,
		_treedata = config.treedata,
		_uikey,//菜单url
		_superguid,//菜单父级guid
		_levelno,//菜单级次
		_guid,//菜单guid
		_menutype,
		_scrWidth =document.body.clientWidth,
		_scrHeight =document.body.clientHeight;

	$(function (){
		perfcommon.initDatatable();
		cmp.querytree();
	})

	/**
	 * 左侧树点击
	 */
	Ext.lt.message.hook("left", "click",function(obj){
		var treeNode = obj.node.data;
		if(treeNode && treeNode.uikey != null){ //不选择预算单位按类型查询
			_uikey = treeNode.uikey;
			_levelno = treeNode.levelno;
			_menutype = treeNode.menutype;
			_superguid = treeNode.superguid;
			_guid = treeNode.guid;
		} else {
			Ext.lt.ui.alert("菜单不能进行页面配置！",function(){});
			return;
		}
		cmp.query();
	});

	Ext.lt.pmkpi.querytree = function(){
		cmp.querytree();
	}

	cmp.query = function (){
		var param = {};
		param.uikey = _uikey;
		var datas = Ext.lt.RCP.asyncall(serviceid, "getData", param);
		datatable.setDatas(datas);
	}

	cmp.querytree = function (){
		var datas = Ext.lt.RCP.asyncall(serviceid, "getMenuTree", null);
		lefttree.setRecordset(datas, 0);
	}

	Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
		var cols = obj.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if(col["colcode"]=="ui"){
				col.style = " text-align:center;";
				col.fn = function(l,c,data,col){
					if(data.componentid == "bustabpage" || data.componentid == "bustoolbutton" || data.componentid == "busqueryform"
						|| data.componentid == "busuidatatable" || data.componentid == "buseditform" || data.componentid == "pmkpilefttreetab"){
						var html = "<a style='color:#468ac9;cursor:pointer;'>设置</a>";
						return html;
					}
				}
				col.onclick = function(td, el, l, c, d) {
					var componentid = d.componentid;
					var uikey = d.url;
					if (d.config.indexOf("key:") != -1) {
						var dataconfig =d.config.substring(1, d.config.length - 1);
						if (dataconfig && dataconfig != "") {
							var dataconfigs = dataconfig.split(",");
							for (var i=0;i<dataconfigs.length;i++) {
								var str = dataconfigs[i];
								if (str.split(":")[0] && str.split(":")[0] == "key") {
									uikey = str.split(":")[1].replace("'", "");
									uikey = uikey.replace("'","");
									break;
								}
							}

						}
					}
					if(!uikey || "" == uikey){
						Ext.lt.ui.alert("key不存在,请检查！",function(){});
						return;
					}
					var url;
					var tablecode;
					if(componentid=="busuidatatable"){ //别表
						url = "/pmkpi/set/uidatatablecols/edit.page";
						tablecode = "BUSFW_T_UICOLUMN";
					} else if(componentid=="buseditform"){//编辑区
						url = "/pmkpi/set/uieditformcols/edit.page";
						tablecode = "BUSFW_T_UIEDITFORM";
					} else if(componentid=="bustoolbutton"){//按钮
						url = "/pmkpi/set/uifunctioncols/edit.page";
						tablecode = "BUSFW_T_UIFUNCTION";
					} else if(componentid=="bustabpage"){//页签
						url = "/pmkpi/set/uitabcols/edit.page";
						tablecode = "BUSFW_T_UITABPAGE";
					} else if(componentid=="busqueryform"){//查询区
						url = "/pmkpi/set/uiqueryformcols/edit.page";
						tablecode = "BUSFW_T_UIQUERYFORM";
					} else if(componentid=="pmkpilefttreetab"){//左侧树页签
						url = "/pmkpi/set/pmkpilefttreetab/edit.page";
						tablecode = "V_PERF_T_TREETAB";
					} else {
						Ext.lt.ui.alert("组件不能进行ui设置！",function(){});
					}
					var params = {};
					params.uikey = uikey;
					params.tablecode = tablecode;
					url = Ext.lt.pmkpi.genPageUrl(url, params);
					Ext.lt.ui.openModalWindow(url,_scrWidth*0.95, _scrHeight*0.95,"框架列配置");
				}
			}
		}
	});

	cmp.add = function (){
		var params = {};
		params.levelno = _levelno;
		params.superguid = _superguid;
		params.guid = _guid;
		params.pagetype = "add";
		var url = "/pmkpi/setting/buspage/setmenu.page";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url,_scrWidth*0.75, _scrHeight*0.75,"新增菜单");
	}

	cmp.mod = function (){
		if (_menutype != "add") {
			Ext.lt.ui.alert("选择左侧菜单不能进行修改菜单操作！",function(){});
			return;
		}
		var params = {};
		params.levelno = _levelno;
		params.superguid = _superguid;
		params.guid = _guid;
		params.pagetype = "mod";
		var url = "/pmkpi/setting/buspage/setmenu.page";
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url,_scrWidth*0.75, _scrHeight*0.75,"修改菜单");
	}

	cmp.del = function (){
		if (_menutype != "add") {
			Ext.lt.ui.alert("选择左侧菜单不能进行删除菜单操作！",function(){});
			return;
		}
		Ext.lt.ui.confirm('是否删除已选中菜单？',null,function(is){
			if(is){
				Ext.lt.ui.loadingShow();
				var params = {};
				params.guid = _guid;
				Ext.lt.RCP.call(service , "del", params, function(rs){
					Ext.lt.ui.loadingClose();
					if (rs.flg=="1") {
						Ext.lt.ui.alert('删除成功！',function(){
							cmp.querytree();
						});
					}
				},function(){
					Ext.lt.ui.loadingClose();
					Ext.lt.ui.alert('删除失败！',function(){
					});
				});
			}
		})
	}

	cmp.save = function (){
		var datas = datatable.getRecordSet().toArray();
		if (!datas || datas.length <= 0) {
			Ext.lt.ui.alert('列表无数据！',function(){
			});
			return;
		}
		if (!datatable.checkAll()) return;//先校验
		var params = {};
		for (var i=0;i<datas.length;i++) {
			var configstr = datas[i].config;
			if(configstr.includes('tiptitle')){
				var newconfigstr = configstr.replaceAll("tip","");
				datas[i].config = newconfigstr;
			}
		}
		params.datas = datas;
		params.uikey = _uikey;
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
		Ext.lt.ui.loadingClose();
		if (rs && rs.success) {
			Ext.lt.ui.alert('保存成功！',function(){
				cmp.query();
			});
		}
	}

	//置顶
	cmp.settop = function (){
		perfcommon.settop(datatable,"id");
	}
	//置尾
	cmp.setend = function (){
		perfcommon.setend(datatable,"id");
	}
	//上移
	cmp.setup = function (){
		perfcommon.setup(datatable,"id");
	}
	//下移
	cmp.setdown = function (){
		perfcommon.setdown(datatable,"id");
	}
	//刷新缓存
	cmp.cachenames = function(){
		var url = "/pmkpi/busfw/cache/manage/index.page";
		var params = {};
		url = Ext.lt.pmkpi.genPageUrl(url, params);
		Ext.lt.ui.openModalWindow(url,_scrWidth*0.95, _scrHeight*0.95,"刷新绩效缓存");
	}
	return cmp;
}
