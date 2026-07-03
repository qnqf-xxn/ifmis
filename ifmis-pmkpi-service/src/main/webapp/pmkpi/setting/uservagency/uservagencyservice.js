if (Ext.lt.uatemplate == null) {
	Ext.lt.uatemplate = {};
}

var menuQTree;// 左侧树对象
var searchnodeid;
var userQTree;
var saveFlag;
var roleSelect;
var selectNodeIndex;
var selectagencydata = [];
var lastyearselectagencydata = [];
var allagencydata = [];

var datarightmenu={};//缓存以保存到数据库中的数据权限
var qtreedatas;//菜单树菜单

// 最左边的搜素id
var userSearchnodeid;
var appid = "";
var acctsystype = "";
Ext.lt.uatemplate.AllotIndex = function(config, serverid) {
	appid = 'pmkpi';
	Ext.lt.uatemplate.AllotIndex.serverid = serverid;
};

//显示全部单位树
function drawAllAgency(datas) {
	var qtreediv = document.getElementById('menudiv');
	agencyQTree = createAgencyTree(datas);
	//agencyQTree.draw(qtreediv);
};

//显示选择的单位树
function drawSelectAgency(datas) {
	var qtreediv = document.getElementById('drdiv');
	agencySelectQTree = createSelectAgencyTree(datas);
	agencySelectQTree.draw(qtreediv);
};

//显示上年选择的单位树
function drawLastYearSelectAgency(datas) {
	var qtreediv = document.getElementById('drdiv');
	agencySelectQTree = createSelectAgencyTree(datas);
	agencySelectQTree.draw(qtreediv);
};

function selectedAgencyData(){
	var userselect = userQTree.getSelected();
	if(userselect.length == 0){
		Ext.lt.ui.alert('请选择用户信息！',function(){
		});
		return;
	}
	var agencyselect = userQTree.getSelected();
	var userguid = agencyselect[0]['guid'];
	Ext.lt.RCP.call(Ext.lt.uatemplate.AllotIndex.serverid, "getselectAgencyTree", userguid,
			function(resp){
				if(resp){
					drawSelectAgency(resp.agencyTree);
					selectagencydata = resp.agencyTree;
					createAgencyTree(allagencydata);
				}
				Ext.lt.uatemplate.loadingClose();
	});
}


/**
 * 同步上年配置
 */
Ext.lt.uatemplate.copy = function(){
	var userselect = userQTree.getSelected();
	if(userselect.length == 0){
		Ext.lt.ui.alert('请选择用户信息！',function(){
		});
		return;
	}
	$("#leftmenudiv").hide();
	$("#同步上年配置").hide();
	$("#保存").hide();

	$("#copymenudiv").show();
	$("#同步").show();
	$("#tip").show();
	var agencyselect = userQTree.getSelected();
	var userguid = agencyselect[0]['guid'];
	var params = {};
	params.userguid = userguid;
	//查询上年配置的单位树
	Ext.lt.RCP.call(Ext.lt.uatemplate.AllotIndex.serverid, "getLastYearAgencyTree", params,
		function(resp){
			if(resp){
				drawLastYearSelectAgency(resp.agencyTree);
				lastyearselectagencydata = resp.agencyTree;
				createLastYearAgencyTree(allagencydata);
			}
			Ext.lt.uatemplate.loadingClose();
		});
}
/**
 * 同步数据
 */
Ext.lt.uatemplate.copydata = function(){
	var userselect = userQTree.getSelected();
	if(userselect.length == 0){
		Ext.lt.ui.alert('请选择用户信息！',function(){
		});
		return;
	}
	var lastagencydata = agencyQTree.getSelected();
	var params = {};
	params.userdata = userselect;
	params.lastagencydata = lastagencydata;
	Ext.lt.ui.confirm("请确认是否同步(不覆盖本年度配置，仅同步增量部分)？",null,function(is) {
		if (is) {
			Ext.lt.RCP.call(Ext.lt.uatemplate.AllotIndex.serverid, "saveCopyUserAndAgencyData", params, function(resp){
				if (resp && resp.success) {
					Ext.lt.ui.alert('同步成功！',function(){
					});
					setTimeout(function(){
						$("#leftmenudiv").show();
						$("#同步上年配置").show();
						$("#保存").show();

						$("#copymenudiv").hide();
						$("#同步").hide();
						$("#tip").hide();
						selectedAgencyData();
					},300);
					Ext.lt.uatemplate.loadingClose();
				}
			});
		}else{

		}
	});
}

/**
 * 保存
 */
Ext.lt.uatemplate.save = function() {
	var userselect = userQTree.getSelected();
	if(userselect.length == 0){
		Ext.lt.ui.alert('请选择用户信息！',function(){
		});
		return;
	}
	var agencyselect = agencyQTree.getSelected();
	/*if(agencyselect.length == 0){
		Ext.lt.ui.alert('请选择单位信息！',function(){
		});
		return;
	}*/
	var params = {};
	params.userdata = userselect;
	params.agencydata = agencyselect;
	Ext.lt.RCP.call(Ext.lt.uatemplate.AllotIndex.serverid, "saveUserAndAgencyData", params, function(resp){
		if (resp && resp.success) {
			Ext.lt.ui.alert('保存成功！',function(){
			});
			selectedAgencyData();
			Ext.lt.uatemplate.loadingClose();
		}
	}); 
};

function caruletypeChange() {
	Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(Ext.lt.uatemplate.AllotIndex.serverid, "getUserTree", null,
				function(resp){
					if(resp){
						createUserTree(resp.userTree);
						var lefttreediv=document.getElementById('lefttreediv');
						userQTree.draw(lefttreediv);
					}
					Ext.lt.ui.loadingClose();
					Ext.lt.uatemplate.loadingClose();
		});
}
//创建角色树
function createUserTree(data){
	userQTree = new Ext.lt.Qtree({
		data : data,
		search:true,
		outformart : '#code-#name',
		doRootSelected: false,
        endlevelselect: false,
        showRootNode: true,
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
				$("#leftmenudiv").show();
				$("#同步上年配置").show();
				$("#保存").show();

				$("#copymenudiv").hide();
				$("#同步").hide();
				$("#tip").hide();
				Ext.lt.ui.loadingShow();
				Ext.lt.RCP.call(Ext.lt.uatemplate.AllotIndex.serverid, "getAgencyTree", null,
					function (resp) {
						if (resp) {
							selectedAgencyData();
							allagencydata = resp.agencyTree;
							//createAgencyTree(resp.agencyTree);
						}
						Ext.lt.ui.loadingClose();
						Ext.lt.uatemplate.loadingClose();
					}, function(rs) {
						Ext.lt.ui.loadingClose();
						Ext.lt.ui.alert('查询失败：' + rs,function(){
						});
					});
			}
		}
	});
	return userQTree;
}

function createAgencyTree(data){
	debugger;
	selectagencydata.each(function(d){
		selectagencydata.push(d['guid']);
	}, 0, 100);
	agencyQTree = new Ext.lt.Qtree({
		data : data,
		outformart : '#code-#name',
		linkchild:true,
		search:true,
		doRootSelected: false,
        endlevelselect: false,
        showRootNode: true,
        selectmode:'n',
        values: selectagencydata,
		field : {
			id : "guid",
			name : "name",
			code : "code",
			sid : "parentid",
			level : "levelno",
			isleaf : "isleaf"
		},
		on:{
		}
	});
	var qtreediv = document.getElementById('menudiv');
	agencyQTree.draw(qtreediv);
	return agencyQTree;
}

function createSelectAgencyTree(data){
	agencySelectQTree = new Ext.lt.Qtree({
		data : data,
		outformart : '#code-#name',
		linkchild:true,
		doRootSelected: false,
        endlevelselect: false,
        showRootNode: true,
		field : {
			id : "guid",
			name : "name",
			code : "code",
			sid : "parentid",
			level : "levelno",
			isleaf : "isleaf"
		},
		on:{
			
		}
	});
	return agencySelectQTree;
}

function createLastYearAgencyTree(data){
	debugger;
	lastyearselectagencydata.each(function(d){
		lastyearselectagencydata.push(d['guid']);
	}, 0, 100);
	agencyQTree = new Ext.lt.Qtree({
		data : data,
		outformart : '#code-#name',
		linkchild:true,
		search:true,
		doRootSelected: false,
		endlevelselect: false,
		showRootNode: true,
		selectmode:'n',
		values: lastyearselectagencydata,
		field : {
			id : "guid",
			name : "name",
			code : "code",
			sid : "parentid",
			level : "levelno",
			isleaf : "isleaf"
		},
		on:{
		}
	});
	var qtreediv = document.getElementById('copymenudiv2');
	agencyQTree.draw(qtreediv);

	return agencyQTree;
}

/**
 * loading层开始
 */
Ext.lt.uatemplate.loadingShow=function(){
	Ext.lt.ui.loadingShow();
}
/**
 * loading层关闭
 */
Ext.lt.uatemplate.loadingClose=function(){
	Ext.lt.ui.loadingClose();
}