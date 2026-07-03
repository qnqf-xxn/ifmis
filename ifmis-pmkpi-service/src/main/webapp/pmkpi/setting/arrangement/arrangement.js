if(!Ext.lt.pmkpi) 
	Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.arrangement)
	Ext.lt.pmkpi.arrangement = {};
var serviceid;
var _code;
Ext.lt.pmkpi.arrangement = function(config, service){
	var common = Ext.lt.pmkpi.perfcommon(config, service);
	var cmp = {};
	var scrWidth =document.body.clientWidth,
		scrHeight =document.body.clientHeight;
	serviceid = service;

	$(function () {
		common.initDatatable();
		var lefts = lefttree.cfg.datas;
		if(lefts!=null && lefts.length > 0){
			_code = lefts[0].guid;
			lefttree.getQtree(0).gotoNode(_code);
		}
		//cmp.query();
	})

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
		params.code = _code;
		params.isleaf = Ext.lt.pmkpi.isleaf + "";
		Ext.lt.RCP.call(serviceid , "getData", params, function(rs){
            datatable.setDatas(rs.data);
			Ext.lt.ui.loadingClose();
		},function() {
			Ext.lt.ui.loadingClose();
			Ext.lt.ui.alert('查询失败！',function(){
			});
		});
	}
    /**
	 * 左侧树点击.
     */
	Ext.lt.message.hook("left", "click",function(obj){
		var treeNode = obj.node.data;
		if(treeNode){
			_code = treeNode.code;
			Ext.lt.pmkpi.isleaf = treeNode.isleaf;
		} else {
			_code = "treeroot";
			Ext.lt.pmkpi.isleaf = '0';
		}
		cmp.query();
	});

	cmp.save = function(){
		if (!datatable.checkAll()) return false;//先校验
		var params = {};
		params.datas = datatable.getRecordSet().toArray();
		params.updatas = datatable.getUpdataData();
		params.deldatas = datatable.getRemoveData();
		params.code = _code;
		params.tablecode = 'PERF_T_FRAME';
		Ext.lt.ui.loadingShow();
		var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
		if(rs && rs.success == true){
			Ext.lt.ui.alert(rs.code,function(){});
		}else{
			Ext.lt.ui.alert(rs.code,function(){});
		}
		Ext.lt.ui.loadingClose();
		Ext.lt.pmkpi.query();
		return rs;
	}

	/**
	 * 初始化
	 */
	cmp.init = function(){
		Ext.lt.ui.confirm('是否已87,2016年数据为标准初始化指标层次分类？',null,function(is){
			if(is){
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
		})
	}

	/**
	 * 复制上年数据
	 */
	cmp.copy = function() {
		var datas = datatable.getRecordSet().toArray();
		if(datas.length > 0 && datas != null){
			Ext.lt.ui.confirm('是否复制上年数据？',null,function(is){
				if(is){
					indexcopy(_code);
					Ext.lt.pmkpi.query();
				}
			})
		}else{
			indexcopy(_code);
			Ext.lt.pmkpi.query();
		}
	}

	Ext.lt.message.hook("datatable", 'beforesetcols',function(data){
		var uiconfig = data.table.uiconfig;
		var cols = data.cols;
		if(!Ext.lt.isArray(cols))
			cols = [cols];
		for(var i=0; i<cols.length; i++){
			var col = cols[i];
			if(col["colcode"]=="obligate"){
				col.fn = function(l,c,data,col){
					var html = "";
					//if(data.levelno == "1"){//层次
						html += '&nbsp;&nbsp;&nbsp;&nbsp';
						html += '<a title = "新增" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexadd("'+data.guid+'","'+data.levelno+'")\'>新增</a>';
					//}else{
						//html += '&nbsp;&nbsp;&nbsp;&nbsp';
					//}
					html += '&nbsp;&nbsp;&nbsp;&nbsp';
					html += '<a title = "删除" style="color:#468ac9;cursor:pointer;" onclick=\'javascript:indexdel("'+data.guid+'")\'>删除</a>';
					return html;
				}
			}
		}
	});
    /**
	 * 新增
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(){
		var datas = datatable.getRecordSet().toArray();
        var params = {};
        params.frametype = _code;
        params.levelno = '1';
		params.superid = '0';
		params.datas = datas;
		var code = Ext.lt.RCP.asyncall(serviceid , "getMaxcode", params);
        var newdata ={};
        newdata.guid = code;
		newdata.code = code;
        newdata.levelno = 1;
        newdata.isleaf = 0;
        newdata.superid = '0';
        newdata.rowtype = "add";
        datatable.getRecordSet().addData(newdata,999);
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
                for(var i=0; i<selDatas.length; i++){
                    var levelno = selDatas[i].levelno;
                    if(levelno == 1){
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
function indexadd(guid, levelno) {
	var datas = datatable.getRecordSet().toArray();
	var params = {};
	params.frametype = _code;
	params.levelno = '2';
	params.superid = guid;
	params.datas = datas;
	var code = Ext.lt.RCP.asyncall(serviceid , "getMaxcode", params);
	var newdata ={};
	newdata.guid = code;
	newdata.code = code;
	newdata.levelno = 2;
	newdata.isleaf = 1;
	newdata.superid = guid;
	newdata.rowtype = "add";
	newdata.weight = 0;
	datatable.getRecordSet().addData(newdata,999);
}

function indexcopy(framesystem){
	var params = {};
	params.code = framesystem;
	params.tablecode = 'PERF_T_FRAME';
	Ext.lt.ui.loadingShow();
	var rs = Ext.lt.RCP.asyncall(serviceid , "copyIndex", params);
	if(rs && rs.success == true){
		Ext.lt.ui.alert(rs.code,function(){});
	}
	Ext.lt.ui.loadingClose();
	return rs;
}
