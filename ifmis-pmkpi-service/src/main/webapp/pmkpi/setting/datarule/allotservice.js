if (Ext.lt.drtemplate == null) {
	Ext.lt.drtemplate = {};
}
var menuQTree;// 左侧树对象
var searchnodeid;
var roleQTree;
var saveFlag;
var roleSelect;
var selectNodeIndex;

var ischange=false;//是否改变
var datarightmenu={};//缓存以保存到数据库中的数据权限
var qtreedatas;//菜单树菜单
var QTree;

// 最左边的搜素id
var ruleSearchnodeid;
var appid = "";
var acctsystype = "";
Ext.lt.drtemplate.AllotIndex = function(config, serverid) {
	appid = config["app"];
	acctsystype = config["acctsystype"];
	Ext.lt.drtemplate.AllotIndex.serverid = serverid;
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
			sid : "parentid",
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
				roleSelect= roleQTree.getSelected();
				drawMenuAndDR();
			}
		}
	});
	return roleQTree;
}
// 创建系统菜单树v
function createMenuTree(data) {
	qtreedatas = data;
	QTree = new Ext.lt.Qtree({
		data : data,
		classname : "pop",
		selectmode : "n",
		outformart : '#code-#name',
		linkchild:true,
		field : {
			id : "guid",
			name : "name",
			code : "code",
			sid : "parentid",
			level : "levelno",
			isleaf : "isleaf"
		},
		on : {
			'nodeclick' : function() {
				
			},
			'click' : function() {
				var nodeas = QTree.getSelected();
				Ext.lt.drtemplate.loadingShow();
				if (nodeas.length > 0) {
					var dataid = nodeas[0].guid;
					var selectrole = roleQTree.getSelected();
					var roleidvalue = selectrole[0].guid;
					Ext.lt.RCP.call(Ext.lt.drtemplate.AllotIndex.serverid, "getDatarightrp", [roleidvalue, dataid], //角色id,菜单id
							function(resp) {
								if (resp) {
									var drdatas = uidatatabledr.getRecordSet().toArray();
									for (var i = 0; i < drdatas.length; i++) {
										drdatas[i].isenabled = 0;
										for (var j = 0; j < resp.length; j++) {
											if (resp[j].dataruleguid == drdatas[i].guid) {
												drdatas[i].isenabled = 1;
											}
										}
									}
									uidatatabledr.reflash();
								}
								Ext.lt.drtemplate.loadingClose();
					});
				} else {
					var drdatas = uidatatabledr.getRecordSet().toArray();
					for (var i = 0; i < drdatas.length; i++) {
						drdatas[i].isenabled = 0;
					}
					uidatatabledr.reflash();
					Ext.lt.drtemplate.loadingClose();
				}
				reflashMenuColor();
			}
		}
	});
	return QTree;
}
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

Ext.lt.message.hook("datatable",'beforesetcols',function(resp) {
		var cols = resp.cols;
		for ( var i = 0; i < cols.length; i++) {
			var _col = cols[i];
			if (_col.name == 'name' && _col.key == "/buscommon/dr/allot/index/dr") {
				_col.width = 300;
			}
			if (_col.name == 'name' && _col.key == "/buscommon/dr/allot/index/role") {
				_col.width = 300;
			}
			if (_col.name == 'agency') {
				_col.width = 300;
			}
		}
		if ('uidatatabledr' == resp.table.config.id) {
			var col1 = {
					name : 'isenabled',
					alias : '启用',
					style:'text-align:center',
					datatype:'B',
					width : 50
				};
			col1.fn = function(i, j, rs, v) {
				var html = [];
				html.push('<span><input type="checkbox" '+(v==1?'checked=true':'')+' /></span>');
				return html.join('');
			}
			col1.onclick = function(table,el,l,c,d) {
				ischange = true;
				if(d.isenabled == 1){
					d.isenabled = 0;
					var select = QTree.getSelected();
					if (!select || select.length == 0) {
						alert('请先选择系统菜单！');
						uidatatabledr.reflash();
						return;
					}
					uidatatabledr.redraw('viewdata');
				}else{
					d.isenabled = 1;
					var select = QTree.getSelected();
					if (!select || select.length == 0) {
						d.isenabled = 0;
						alert('请先选择系统菜单！');
						uidatatabledr.reflash();
						return;
					}
					uidatatabledr.redraw('viewdata');
				}
				// updateMenuByDatatable();
				// reflashMenuColor();
			}
			cols.push(col1);
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
	Ext.lt.drtemplate.loadingShow();
	if(roletype){
		Ext.lt.RCP.call(Ext.lt.drtemplate.AllotIndex.serverid, "getRoleTree", [roletype],
				function(resp){
					if(resp){
						createRoleTree(resp);
						var lefttreediv=document.getElementById('lefttreediv');
						roleQTree.draw(lefttreediv);
						drawMenuAndDR();
					}
					Ext.lt.drtemplate.loadingClose();
		});
	}
}
// 画菜单树和数据权限表
function drawMenuAndDR() {
	uidatatabledr.mousedrag(false);
	ischange = false;
	var selectrole = roleSelect;
	if (selectrole) {
		var roleidvalue = selectrole[0].guid;//角色
		Ext.lt.drtemplate.loadingShow();
		Ext.lt.RCP.call(Ext.lt.drtemplate.AllotIndex.serverid,"findDataRightByAppid", {
					roleid : roleidvalue,
					appid : appid,
					acctsystype :acctsystype
				},function(dataRights){
					if (dataRights.datatables) {
						uidatatabledr.setDatas(dataRights.datatables);
						uidatatabledr.reflash();
					}
					if (dataRights.leftconfig) {
						var leftconfig = dataRights.leftconfig;
						var midtables = dataRights.midTables;
						var menudatas = leftconfig.datas;
						drawMenu(menudatas);
					}
					if (dataRights.midTables) {
						var midtables = dataRights.midTables;
						datarightmenu = {};
						setDatarightmenu(midtables);
						reflashMenuColor();
					}
					Ext.lt.drtemplate.loadingClose();
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
	var dataRight = uidatatabledr.getRecordset().toArray();
	var selectdataright = [];
	for (var i = 0; i < dataRight.length; i++) {
		if (dataRight[i].isenabled == 1) {
			selectdataright.push(dataRight[i]);
		}
	}
	var menus = QTree.getSelected();
	if (menus.length == 0) {
		alert('请选择菜单信息！');
		return;
	}
	var roleidvalue = roleSelect[0].guid; //角色
	//var menuvalue = menus[0]["guid"]; //菜单
	Ext.lt.drtemplate.loadingShow();
	//传入参数  角色guid或用户和角色guid  选中菜单树  选中数据权限
	Ext.lt.RCP.call(Ext.lt.drtemplate.AllotIndex.serverid, "saveMenuAndDRData", [roleidvalue,selectdataright,menus],
			function(resp) {
				if (resp) {
					Ext.lt.ui.alert('保存成功！',function(){
					});
					ischange = false;
					Ext.lt.drtemplate.loadingClose();
				}
			},function(){
				Ext.lt.ui.alert('保存失败！',function(){
				});
				Ext.lt.drtemplate.loadingClose();
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

/**
 * loading层开始
 */
Ext.lt.drtemplate.loadingShow=function(){
	Ext.lt.ui.loadingShow();
}
/**
 * loading层关闭
 */
Ext.lt.drtemplate.loadingClose=function(){
	Ext.lt.ui.loadingClose();
}

function updateMenuByDatatable(){
	var menus = QTree.getSelected();
	var selectdatas = uidatatabledr.getRecordset().select(function(d){
		if(d.isenabled == 1){
			return true;
		}else{
			return false;
		}
	}).toArray();
	if(selectdatas.length==0){
		for(var i=0;i<menus.length;i++){
			datarightmenu[menus[i].guid]=null;
		}
	}else{
		for(var i=0;i<menus.length;i++){
			datarightmenu[menus[i].guid]=menus[i].guid;
		}
	}
}

function reflashMenuColor() {
	for (var i = 0; i < qtreedatas.length; i++) {
		var leftNode = QTree.getNode(qtreedatas[i].guid);
		if (datarightmenu[qtreedatas[i].guid]) {
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
		if(!datarightmenu[datas[i].guid]){
			datarightmenu[datas[i].guid]=datas[i].guid;
		}
	}
}