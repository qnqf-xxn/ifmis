if (Ext.lt.drtemplate == null) {
	Ext.lt.drtemplate = {};
}
var menuQTree;// 左侧树对象
var searchnodeid;
var roleQTree;
var saveFlag;
var roleSelect;
var operationSelect;
var selectNodeIndex;
var selectNode;

var ischange=false;//是否改变
var datarightmenu = [];//缓存以保存到数据库中的数据权限
var qtreedatas;//菜单树菜单
var _displaycols =[];
var selectedOpData={};	//下拉框的选中的数据
// 最左边的搜素id
var ruleSearchnodeid;
var appid = "";
var transObj={
	bustoolbutton:"按钮",
	bustabpage:"页签",
	busuidatatable:"表格",
	buseditform:"编辑区"
}
var serverid;
var optiondatas = {};
var componentids = "";
Ext.lt.drtemplate.AllotIndex = function(config, server) {
	appid = config["appid"];
	serverid = server;
};

// 显示产品菜单树
function drawMenu(datas) {
	var qtreediv = document.getElementById('menudiv');
	menuQTree = createMenuTree(datas);
	menuQTree.draw(qtreediv);
};


//创建角色树
function createRoleTree(data){
	// qtree查询区
	if (!!!$(".search #mysearchinput")[0]) {
		var searchdiv = $('<div class="search" style="width:100%;height:30px;margin-left:15px;"><input type="text" id="mysearchinput" style="width:75%;margin-top:7px;float:left;" class="searchinput" tipstext="请输入关键词" value="" />'
			+ '<div id="search_btn" style="width:30px;height:24px;margin-top:7px;float:left;background:url(/busfw/common/themes/darkblue/images/bg/search.png) no-repeat left top">&nbsp;</div></div>');
		$("#lefttreediv").before(searchdiv);
		var search = searchdiv.find("#mysearchinput");
		var searchbtn = searchdiv.find("#search_btn");
		searchbtn.attr("onmouseover","this.style.background='url(/busfw/common/themes/darkblue/images/bg/search_hover.png) no-repeat left top'");
		searchbtn.attr("onmouseout","this.style.background='url(/busfw/common/themes/darkblue/images/bg/search.png) no-repeat left top'");

		Ext.lt.bindEvent(search[0], 'onkeypress',function(event){
			if(event.keyCode == "13"){
				roleQTree.searchnode([{
					field: 'code',
					values: [search.val()]
				},
					{
						field: 'name',
						values: [search.val()]
					},
					{
						field: 'pinyin',
						values: [search.val()]
					}], 'contain');
			}
		});
		Ext.lt.bindEvent(searchbtn[0], 'onclick',function() {
			roleQTree.searchnode([{
				field: 'code',
				values: [search.val()]
			},
				{
					field: 'name',
					values: [search.val()]
				},
				{
					field: 'pinyin',
					values: [search.val()]
				}], 'contain');
		});
	}

	roleQTree = new Ext.lt.Qtree({
		data : data,
		classname : "pop",
		outformart : '#code-#name',
		isexpand: false,
		expandlevel: -1,
		field : {
			id : "guid",
			name : "name",
			code : "code",
			sid : "superguid",
			level : "levelno",
			isleaf : "isleaf"
		},
		on:{
			'nodeclick' : function() {
				if(roleSelect && roleQTree.getSelected()[0].guid == roleSelect[0].guid )return;
				if (ischange) {
					if (!confirm('修改的数据尚未保存，是否离开？')) {
						roleQTree.gotoNode(roleSelect[0].guid);
						return;
					}
				}
				selectedOpData = {};
				roleSelect= roleQTree.getSelected([]);
				uidatatabledr.setDatas();
				$("#operationtypeselect").empty();
				$("#operationtypeselect").html("<option value=''>请选择</option>");
				drawMenuAndDR();
			}
		}
	});
	return roleQTree;
}
// 创建系统菜单树
function createMenuTree(data) {
	qtreedatas = data;
	var num = 1;
	if (data.length < 50) {
		num = 2;
	}
	menuQTree = new Ext.lt.Qtree({
		data : data,
		classname : "pop",
		// selectmode : "n", //取消多选复选框
		expandlevel: num,
		outformart : '#code-#name',
		linkchild:true,
		field : {
			id : "guid",
			name : "name",
			code : "code",
			sid : "superguid",
			level : "levelno",
			isleaf : "isleaf"
		},
		on : {
			'nodeclick' : function() {

			},
			'click' : function() {
				var nodeas = menuQTree.getSelected();
				if (nodeas.size() == 1) {
					if (!nodeas[0].uikey || nodeas[0].uikey == "#" || nodeas[0].uikey == "") {
						reflashMenuColor();
						optiondatas = {};
						componentids = "";
						uidatatabledr.setDatas([]);
						selectedOpData = {};
						$("#operationtypeselect").empty();
						$("#operationtypeselect").html("<option value=''>请选择</option>");
						selectNode = nodeas[0];
						return;
					}
					if(selectNode && menuQTree.getSelected()[0].guid == selectNode.guid )return;
					selectNode = nodeas[0];
					var params = {};
					var selectrole = roleQTree.getSelected();
					params.roleguid = selectrole[0].guid;
					params.uikey = selectNode.uikey;
					params.menuguid = selectNode.guid;
					Ext.lt.ui.loadingShow();
					Ext.lt.RCP.call(serverid, "getOptionDatas", params, function(resp) {
							if (resp) {
								selectedOpData = {};
								optiondatas = resp.datas;
								componentids = resp.componentids;
								uidatatabledr.setDatas([]);
								$("#operationtypeselect").empty();
								$("#operationtypeselect").html("<option value=''>请选择</option>");
							}
							Ext.lt.ui.loadingClose();
						});
				}
				reflashMenuColor();
			}
		}
	});
	return menuQTree;
}

$("#operationtypeselect").focus(function(){
	var optionString = "";
	var transNames = {};
	for (var i = 0; i < optiondatas.length; i++) {
		var opiniondata = optiondatas[i];
		var name = opiniondata.name;
		var componentid = opiniondata.componentid;
		var transName = transObj[name.split("-")[0]] + "-" + name.split("-")[1];
		transNames[componentid] = transName;
		if (componentids && componentids.indexOf(componentid) != -1){
			optionString += '<option id = "option' + componentid + '" value="' + name + '" style="color:red">' + transName + '</option>';
		} else {
			optionString += '<option id = "option' + componentid + '" value="' + name + '">' + transName + '</option>';
		}
	}
	$("#operationtypeselect").html("<option value=''>请选择</option>" + optionString);
	$("#operationtypeselect").find("#option" + selectedOpData.componentid).attr("selected",true);
});

// 左侧财政、银行树搜索区搜索功能
Ext.lt.message.hook("search", "searchvalue", function(_val) {
	var treeObj = fasplefttabpanelId.getLeftQTree();
	searchnodeid = treeObj.searchnode([ {
		field : 'code',
		values : _val
	}, {
		field : 'name',
		values : _val
	} ], 'left', searchnodeid);
});

Ext.lt.message.hook("datatable", 'beforesetcols', function (resp) {
		var cols = resp.cols;
		if ('uidatatabledr' == resp.table.config.id) {
			for (var i = 0; i < cols.length; i++) {
				var col1 = cols[i];
				var col2 = cols[i];
				if (col2.colcode == "isedit") {
					col2.fn = function (i, j, rs, v) {
						var html = [];
						html.push('<span style ="text-align: center;line-height:31px;";><input type="checkbox" ' + (v == 1 ? 'checked=true' : '') + ' /></span>');
						return html.join('');
					}
					col2.onclick = function (table, el, l, c, d) {
						ischange = true;
						var select = menuQTree.getSelected();
						if (d.isedit == 1) {
							d.isedit = 0;
						} else {
							d.isedit = 1;
						}
						if (!select || select.length == 0) {
							alert('请先选择系统菜单！');
							uidatatabledr.reflash();
							return;
						}
						uidatatabledr.redraw('viewdata');
					}
				}
				if (col1.colcode == "isvisiable") {
					col1.fn = function (i, j, rs, v) {
						var html = [];
						html.push('<span style ="text-align: center;line-height:31px;";><input type="checkbox" ' + (v == 1 ? 'checked=true' : '') + ' /></span>');
						return html.join('');
					}
					col1.onclick = function (table, el, l, c, d) {
						ischange = true;
						var select = menuQTree.getSelected();
						if (d.isvisiable == 1) {
							d.isvisiable = 0;
						} else {
							d.isvisiable = 1;
						}
						if (!select || select.length == 0) {
							alert('请先选择系统菜单！');
							uidatatabledr.reflash();
							return;
						}
						uidatatabledr.redraw('viewdata');
					}
				}
			}
		}
	}
);


/**
 * 构建角色.
 * @param selectedroletype
 */
function caruletypeChange(selectedroletype) {
	var roletype = $('#roletypeselect').val();
	roleSelect = null;//选中角色置空;
	Ext.lt.ui.loadingShow();
	if(roletype){
		Ext.lt.RCP.call(serverid, "getRoleTree", [roletype],
			function(resp){
				if(resp){
					createRoleTree(resp);
					var lefttreediv=document.getElementById('lefttreediv');
					roleQTree.draw(lefttreediv);
					drawMenuAndDR();
				}
				Ext.lt.ui.loadingClose();
			});
	}
}

/**
 * 构建操作按钮
 * @param selectedroletype
 */
function operationTypeButton(selectedroletype) {
	var operationtype = $('#operationtypeselect').val();
	if(operationtype.length > 0){
		selectedOpData.componentid=operationtype.split("-")[0].trim();
		selectedOpData.id=operationtype.split("-")[1].trim();
	} else {
		uidatatabledr.setDatas([]);
		return;
	}
	Ext.lt.ui.loadingShow();
	var cols = uidatatabledr.getCols(); //获取列表所有列
	cols.push.apply(cols, _displaycols);
	_displaycols = [];
	for (var i = 0; i < cols.length; i++) {
		var col = cols[i];
		if (col.colcode == "isedit"){
			if (selectedOpData.componentid == 'bustoolbutton' || selectedOpData.componentid == 'bustabpage'){
				_displaycols.push(col); //隐藏前暂存至sfagency;
				col.display = false;
				col.isvisiable = 0;
			} else {
				col.isvisiable = 1;
				col.display = true;
			}
		}
	}
	uidatatabledr.redraw(); //从新绘制表格
	operationSelect = null;//选中置空;
	var roleSelect = roleQTree.getSelected();
	var key = selectNode.url;
	if (key == null){
		key = selectNode.uikey;
	}
	var params = {};
	params.key = key;
	params.roleGuid = roleSelect[0].guid; //角色
	params.compns = selectedOpData.componentid;
	params.id = selectedOpData.id;
	params.menuguid = selectNode.guid;
	if(operationtype){
		Ext.lt.RCP.call(serverid, "getOperation", params, function(uifunction){
				if(uifunction){
					uidatatabledr.setDatas(uifunction.uifunction);
				}
				Ext.lt.ui.loadingClose();
			});
	}
	Ext.lt.ui.loadingClose();
}


// 画菜单树
function drawMenuAndDR() {
	uidatatabledr.mousedrag(false);
	ischange = false;
	var selectrole = roleSelect;
	if (selectrole) {
		Ext.lt.ui.loadingShow();
		var params = {};
		params.roleid = selectrole[0].guid;//角色
		params.appid = appid;
		Ext.lt.RCP.call(serverid,"getRightMenuByRoleId", params,function(dataRights){
			if (dataRights.leftconfig) {
				var leftconfig = dataRights.leftconfig;
				var menudatas = leftconfig.datas;
				drawMenu(menudatas ? menudatas : []);
				datarightmenu = [];
				setDatarightmenu(dataRights.uiMenus);
				reflashMenuColor();
			}
			Ext.lt.ui.loadingClose();
		});
	} else {
		drawMenu([]);
		uidatatabledr.getRecordset().clear();
		uidatatabledr.reflash();
	}
}

/**
 * 保存
 */
Ext.lt.drtemplate.save = function() {
	var roleSelect = roleQTree.getSelected();
	if (roleSelect.length == 0) {
		alert('请选择角色信息！');
		return;
	}
	var menus = menuQTree.getSelected();
	if (menus.length == 0) {
		alert('请选择菜单信息！');
		return;
	}
	var operationtype = $('#operationtypeselect').val();//下拉框选择value值
	if(operationtype.length>0){
		selectedOpData.componentid = operationtype.split("-")[0].trim();
		selectedOpData.id = operationtype.split("-")[1].trim();
	} else {
		alert('请选择类型进行操作！');
		return;
	}
	var datas = uidatatabledr.getRecordset().toArray();
	if (datas.length == 0) {
		alert('列表无数据，不需要保存！');
		return;
	}
	var componentid = selectedOpData.componentid;
	Ext.lt.ui.loadingShow();
	var params = {};
	var menuguid = menus[0]["guid"]; //菜单guid;
	params.roleGuid = roleSelect[0].guid; //角色
	params.datas = datas;
	params.menuguid = menuguid; //菜单guid;
	params.componentid = componentid;
	params.id = selectedOpData.id;
	params.menutype = menus[0].menutype; //绩效拼接菜单;
	params.key = datas[0].key;
	//传入参数  角色guid或用户和角色guid  选中菜单树  选中数据权限
	Ext.lt.RCP.call(serverid, "save", params, function(resp) {
		Ext.lt.ui.alert('保存成功！',function(){
		});
		ischange = false;
		Ext.lt.ui.loadingClose();
		datarightmenu.push(menuguid);
		reflashMenuColor();
		if (componentids.indexOf(componentid) == -1) {
			componentids += "," + componentid;
		}
	},function(){
			Ext.lt.ui.alert('保存失败！',function(){
			});
			Ext.lt.ui.loadingClose();
		});
};

/**
 * 清除保存
 */
Ext.lt.drtemplate.clearsave = function() {
	var roleSelect = roleQTree.getSelected();
	if (roleSelect.length == 0) {
		alert('请选择角色信息！');
		return;
	}
	var menus = menuQTree.getSelected();
	if (menus.length == 0) {
		alert('请选择菜单信息！');
		return;
	}
	var operationtype = $('#operationtypeselect').val();//下拉框选择value值
	if(operationtype.length > 0){
		selectedOpData.componentid=operationtype.split("-")[0].trim();
		selectedOpData.id=operationtype.split("-")[1].trim();
	} else {
		alert('请选择类型进行操作！');
		return;
	}
	var datas = uidatatabledr.getRecordset().toArray();
	if (datas.length == 0) {
		alert('列表无数据，不需要保存！');
		return;
	}
	var componentid = selectedOpData.componentid;
	var params = {};
	var menuguid = menus[0]["guid"];
	params.roleGuid = roleSelect[0].guid; //角色
	params.menuguid = menuguid; //菜单guid;
	params.componentid = componentid;
	params.id = selectedOpData.id;
	params.menutype = menus[0].menutype; //绩效拼接菜单;
	params.key = datas[0].key;
	params.id = selectedOpData.id;
	Ext.lt.ui.confirm('是否删除已选择的数据!', null, function(is){
		if(is){
			Ext.lt.ui.loadingShow();
			Ext.lt.RCP.call(serverid, "clearsave", params, function(resp) {
				Ext.lt.ui.alert('清除成功！',function(){
					//查询列表数据
					operationTypeButton();
					//查询配置组件权限的菜单
					var uiMenus = Ext.lt.RCP.asyncall(serverid , "getDataRult", [roleSelect[0].guid]);
					ischange = false;
					datarightmenu = [];
					setDatarightmenu(uiMenus);
					reflashMenuColor();
					if (componentids.indexOf(componentid) != -1) {
						componentids = componentids.replaceAll(componentid, "");
					}
					Ext.lt.ui.loadingClose();
				});

			},function(){
				Ext.lt.ui.alert('清除失败！',function(){
				});
				Ext.lt.ui.loadingClose();
			});
		}
	});

};

// 最左边的搜索框
function ruleSearch() {
	var msg = document.getElementById('mysearchinput').value;
	ruleSearchnodeid = fasplefttabpanelId.cfg.trees[0].qtree.searchnode([ {
		field : 'code',
		values : [ msg ]
	}, {
		field : 'name',
		values : [ msg ]
	} ], 'contain', ruleSearchnodeid);
}

function reflashMenuColor() {
	for (var i = 0; i < qtreedatas.length; i++) {
		var leftNode = menuQTree.getNode(qtreedatas[i].guid);
		if(datarightmenu.indexOf(qtreedatas[i].guid) != -1){
			$(leftNode).find("FONT").css("color", "red");
		} else {
			if ($(leftNode).find("FONT").length > 0) {
				$(leftNode).find("FONT")[0].color = "";
				if ($(leftNode).find("FONT")[0].style) {
					$(leftNode).find("FONT")[0].style.color = "";
				}
			} else {
				$(leftNode).find("FONT").css("color", "");
			}
		}
	}
}

function setDatarightmenu(datas){
	for(var i=0;i<datas.length;i++){
		if(datarightmenu.indexOf(datas[i].guid) == -1){
			datarightmenu.push(datas[i].guid);
		}
	}
}