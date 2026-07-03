if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.tempdataset)
	Ext.lt.pmkpi.tempdataset = {};
var serviceid;
var _code;
Ext.lt.pmkpi.tempdataset = function(config, service){
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var cmp = {};
	var scrWidth =document.body.clientWidth,
		_tablecode,
		_province = config.province,
		_year = config.year,
		_defquery,
		_leftcode = config.leftcode,
		_delcols,
		_updatecols,
		_leftcodevalue =_province,
		_defyear = config.defyear,
		_defprovince = config.defprovince,
		scrHeight =document.body.clientHeight;
	serviceid = service;
	var _displaycols = [];

	$(function () {
		common.initDatatable();
		cmp.query();
	})
	//重新画
    cmp.draw = function(div) {}

	//查询
	cmp.query = function (){
		Ext.lt.pmkpi.query();
	}

    /**
	 * 查询.
     */
	Ext.lt.pmkpi.query = function(){
		var params = {};
		Ext.lt.ui.loadingShow();
		params.tablecode = _tablecode;
		params.isleaf = Ext.lt.pmkpi.isleaf + "";
		params.tablesql = _defquery;
		params.year = _year; //当前登录年度
		if(_leftcode!=null){
			params.leftcode = _leftcode;
			if (_leftcodevalue != "" &&_leftcodevalue != null && _leftcodevalue != "treeroot"){
				params.leftcodevalue = _leftcodevalue; //左侧选中区划
			}else{
				params.leftcodevalue = _province;  //当前登录区划
			}
		}
		if(_tablecode=="PERF_ENUM"){
			params.querySql = queryform.getQuerySQL();
			params.beanid ="pmkpi.setting.tempdataset.PerfTempDataSetBOTX";
			datatable.queryData(params,function(){
				Ext.lt.ui.loadingClose();
			});
		}else{
			params.beanid = "pmkpi.setting.tempdataset.PerfTempDataSetBOTX";
			datatable.queryData(params,function(){
				Ext.lt.ui.loadingClose();
			});
		}
	}
	Ext.lt.message.hook("queryform", "doquery",function(obj){
		Ext.lt.pmkpi.query();
	});
	/**
	 * 左侧树点击
	 */
	Ext.lt.message.hook("left", "click",function(obj){
		var treeNode = obj.node.data;
		if(treeNode){
			_leftcodevalue = treeNode.code;
			Ext.lt.pmkpi.isleaf = treeNode.isleaf;
		} else {
			_leftcodevalue = "treeroot";
			Ext.lt.pmkpi.isleaf = '0';
		}
		//新增删除按钮显示隐藏
		if (_leftcodevalue == _province){
			if(document.getElementById("add")){
				document.getElementById("add").style.display = "";
			}
			if(document.getElementById("del")){
				document.getElementById("del").style.display = "";
			}
		}else {
			if(document.getElementById("add")){
				document.getElementById("add").style.display = "none";
			}
			if(document.getElementById("del")){
				document.getElementById("del").style.display = "none";
			}
		}
		cmp.setTableColum();
		setTimeout(function() {   //延时查询
			cmp.query();
		}, 100);
	});

	Ext.lt.message.hook("perfcommon", "auditquery",function(){
		Ext.lt.pmkpi.query();
	});

	Ext.lt.message.hook("perfcommon", "tablequery",function(){
		Ext.lt.pmkpi.query();
	});
	/**
	 * 保存数据
	 * @returns {boolean|undefined}
	 */
	cmp.save = function(){
		if (!datatable.checkAll()) return false;//先校验
		if ((_leftcodevalue != "" && _leftcodevalue != "treeroot") && _leftcodevalue != _province){
			Ext.lt.ui.alert('只能保存当前登录区划的数据！',function(){
				return;
			});
		}
		var params = {};
		params.datas = datatable.getRecordSet().toArray();
		params.updatas = datatable.getUpdataData();
		params.deldatas = datatable.getRemoveData();
		params.code = _code;
		params.tablecode = _tablecode;
		Ext.lt.ui.loadingShow();
		Ext.lt.RCP.call(serviceid, "save", params, function(rs){
			if (rs && rs.success) {
				Ext.lt.ui.alert('保存成功！',function(){
					cmp.query();
				});
			}
			Ext.lt.ui.loadingClose();
		}, function(){
			Ext.lt.ui.alert('保存失败！',function(){
			});
			Ext.lt.ui.loadingClose();
		});
	}
	//多主键保存方法
	cmp.savemajorkey = function(){
		if(!datatable.checkAll())return;
		if ((_leftcodevalue != "" && _leftcodevalue != "treeroot") && _leftcodevalue != _province){
			Ext.lt.ui.alert('只能保存当前登录区划的数据！',function(){
			});
			return;
		}
		var params={};
		params.tablecode = _tablecode;
		params.province = _province;
		params.year = _year;
		if(_leftcode!=null){
			params[_leftcode] =_leftcodevalue;
		}
		params.delcols = _delcols;
		params.updatecols =_updatecols;
		params.datas = datatable.getRecordSet().toArray();
		params.deldatas = datatable.getRemoveData();
		Ext.lt.RCP.call(serviceid, "savemajorkey", params, function(rs){
			if (rs && rs.success) {
				Ext.lt.ui.alert('保存成功！',function(){
					cmp.query();
				});
			}
			Ext.lt.ui.loadingClose();
		}, function(){
			Ext.lt.ui.alert('保存失败！',function(){
			});
			Ext.lt.ui.loadingClose();
		});

	}
	cmp.init = function(){
		var params = {};
		params.code = _code;
		var rs = Ext.lt.RCP.asyncall(serviceid , "init", params);
		Ext.lt.ui.loadingClose();
		if(rs.success){
			Ext.lt.ui.alert(rs.code,function(){});
		}
		cmp.query();
		return rs;
	}
	Ext.lt.message.hook("datatable", 'beforesetcols',function(data){
		var uiconfig = data.table.uiconfig;
		_tablecode = uiconfig.tablecode;
		_defquery = uiconfig.defquery;
		var config = data.table.config;
		_delcols = config.delcols;
		_updatecols = config.updatecols;
		var cols = data.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if(col["colcode"]=="isadd"){
				col.fn = function(l,c,data,col){
					var html = "";
					if(data.isleaf == "0"){//层次
						html += '&nbsp;&nbsp;&nbsp;&nbsp';
						html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexadd("'+data.guid+'","'+data.levelno+'","'+data.elementcode+'")\'>新增</a>';
					}else{
						html += '&nbsp;&nbsp;&nbsp;&nbsp';
					}
					html += '&nbsp;&nbsp;&nbsp;&nbsp';
					html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'")\'>删除</a>';
					return html;
				}
			}
			if(col["colcode"]=="elementcode"){
				var guid = "",text = "";
				col.oneditstart = function (table, e, l, c, d) {
					if (d.isleaf != "0"){
						return false;
					}
				}
				col.oneditend = function (table, el, l, c, d) {
					if (d.isleaf == "0"){
						guid = d.guid;
						text = d.elementcode;
						//下级数据类型跟着改变
						setdatas(guid,text);
					}
				}
			}
		}
	});

	//动态配置表格列
	cmp.setTableColum = function(){
		var cols = datatable.getCols(); //获取列表所有列
		cols.push.apply(cols, _displaycols);
		_displaycols = [];
		for (var i = 0, len = cols.length; i < len; i++) {
			var col = cols[i];
			if (_leftcodevalue != _province){
				if (col["colcode"]=="isadd") {
					_displaycols.push(col); //隐藏前暂存至sfagency;
					col.display = false; //display置为false，隐藏
				}else {
					col.display = true;
				}
				col.edit = false;  //字段不可编辑
			}else{
				col.display = true;
				if (col["alias"] == "序号" || col["name"] == "check" || col["alias"] == "操作") {
					col.edit = false;
				}else{
					col.edit = true;  //字段可编辑
				}
			}
		}
		datatable.setSelfdefconfig({config: "{}"});
		datatable.redraw();
	}

    /**
	 * 新增
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.levelno = 1;
        newdata.isleaf = 0;
		newdata.superid = '#';
		newdata.superguid = '#';
		newdata.appid = "pmkpi";
		newdata.rowtype = "add";
        datatable.getRecordSet().addData(newdata,datatable.getRecordSet().toArray().length + 999);
    });
    /**
	 * 刪除表格.
     */
    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
        var datas = datatable.getRecordSet().toArray();
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据,删除父级会删除父级下所有数据？',null,function(is){
            if(is){
				var datas = datatable.getRecordSet().toArray();
                for(var i=0; i<selDatas.length; i++){
                    var levelno = selDatas[i].levelno;
                    if(levelno == 1||levelno == 2){
                        var guid = selDatas[i].guid;
                        for(var i=0; i<datas.length; i++){
                            var superid = datas[i].superid;
                            if(superid == guid){
                                selDatas.push(datas[i]);
                            }
                        }
                    }
                }
                datatable.removeData(selDatas);
            }
        })
    });

	/**
	 * 复制上年数据
	 */
	cmp.copy = function() {
		var datas = datatable.getRecordSet().toArray();
		if(datas.length > 0 && datas != null){
			Ext.lt.ui.confirm('当前年度已存在数据，是否重新复制？',null,function(is){
				if(is){
					indexcopy(_tablecode);
					Ext.lt.pmkpi.query();
				}
			})
		}else{
			indexcopy(_tablecode);
			Ext.lt.pmkpi.query();
		}
	}
	/**
	 * 初始化数据
	 * @param params
	 */
	cmp.initleftset = function(){
		//获取选中的左侧树数据
		_leftcodevalue = "";
		var selDate = lefttree.qtree.getSelected();
		for (var i = 0; i < selDate.size();i++){  //循环
			_leftcodevalue += selDate[i].code+",";  //拼接
		}
		if (_leftcodevalue.length > 0) {  //判断长度
			if (_leftcodevalue.lastIndexOf(",")) {
				_leftcodevalue = _leftcodevalue.substring(0, _leftcodevalue.length - 1); //截取
			}
		}
		if(_leftcodevalue == "") {
			Ext.lt.ui.alert('请选择区划进行初始化！', function () {
			});
			return;
		}
		var params = {};
		params.tablecode = _tablecode;
		params.tablesql = _defquery;
		params.leftcoe = _leftcode;
		params.leftcodevalue = _leftcodevalue;
		params.msg = "初始化";
		Ext.lt.ui.confirm('是否初始化数据？',null,function(is){
			if (is){
				Ext.lt.ui.loadingShow();
				Ext.lt.RCP.call(serviceid , "initleftset", params, function(rs){
					if (rs && rs.success) {
						Ext.lt.ui.alert(params.msg + '成功！',function(){
							cmp.query();
						});
					}else {
						Ext.lt.ui.alert(params.msg + '失败！',function(){
						});
					}
					Ext.lt.ui.loadingClose();
				});
			}
		});
	}

	/**
	 * 复制本区划数据到选中的区划
	 */
	cmp.copydatas = function() {
		//获取选中的左侧树数据
		_leftcodevalue = "";
		var selDate = lefttree.qtree.getSelected();
		for (var i = 0; i < selDate.size();i++){  //循环
			_leftcodevalue += selDate[i].code+",";  //拼接
		}
		if (_leftcodevalue.length > 0) {  //判断长度
			if (_leftcodevalue.lastIndexOf(",")) {
				_leftcodevalue = _leftcodevalue.substring(0, _leftcodevalue.length - 1); //截取
			}
		}
		if(_leftcodevalue == ""){
			Ext.lt.ui.alert('请选择区划进行复制！',function(){
			});
			return;
		}
		//获取表格中当前区划的数据
		var datas = datatable.getRecordSet().toArray();
		var params = {};
		params.datas = datas;
		params.tablecode = _tablecode;
		params.tablesql = _defquery;
		params.leftcoe = _leftcode;
		params.leftcodevalue = _leftcodevalue;
		params.msg = "复制本区划数据";
		Ext.lt.ui.confirm('是否复制本区划数据到选中的区划？',null,function(is) {
			if (is) {
				Ext.lt.ui.loadingShow();
				Ext.lt.RCP.call(serviceid , "copydatas", params, function(rs){
					if (rs && rs.success) {
						Ext.lt.ui.alert(params.msg + '成功！',function(){
							cmp.query();
						});
					}else {
						Ext.lt.ui.alert(params.msg + '失败！',function(){
						});
					}
					Ext.lt.ui.loadingClose();
				});
			}
		});
	}

	return cmp;
}

/**
 * 删除体系
 * @param guid
 */
function indexdel(guid) {
	var datas = datatable.getRecordSet().toArray();
	if (datas != null && datas.length > 0) {
		for (var i = 0; i < datas.length; i++) {
			var selectDatas = datas[i];
			//如果有下级则不可删除
			if(guid ==selectDatas.superid){
				Ext.lt.ui.alert('该数据有下级 不可删除！');
				return;
			}
		}
	}
	Ext.lt.ui.confirm("你确定删除选定的数据？", {icon: "warn"}, function (ret) {
		if (ret) {
			var datas = datatable.getRecordSet().toArray();
			if (datas != null && datas.length > 0) {
				for (var i = 0; i < datas.length; i++) {
					var selectDatas = datas[i];
					if (guid == selectDatas.guid) {
                        datatable.removeData(selectDatas);
					}
				}
			}
		}
	});
}

/**
 * 新增体系
 */
function indexadd(guid, levelno, elementcode) {
	var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
	var newdata ={};
	newdata.guid = newguid;
	newdata.levelno = Number(levelno)+1;
	newdata.isleaf = 0;
	newdata.superid = guid;
	newdata.rowtype = "add";
	newdata.elementcode = elementcode;
	datatable.getRecordSet().addData(newdata,999);
}

function indexcopy(framesystem){
	var params = {};
	params.tablecode = framesystem;
	Ext.lt.ui.loadingShow();
	var rs = Ext.lt.RCP.asyncall(serviceid , "copyIndex", params);
	if(rs && rs.success == true){
		Ext.lt.ui.alert(rs.code,function(){});
	}
	Ext.lt.ui.loadingClose();
	return rs;
}

/**
 * 父级 类型 字段值改变时其子级也随着改变
 */
function setdatas(guid,text){
	//判断新增的数据有没有下级数据
	var data = datatable.getRecordSet().query({superid:guid});
	if (data != null && data.length > 0) {
		for (var i = 0; i < data.length; i++) {
			data[i].elementcode = text;
		}
	}else{
		return;
	}
}