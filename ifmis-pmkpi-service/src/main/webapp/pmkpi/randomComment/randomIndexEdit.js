if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.randomIndexEdit){
    Ext.lt.pmkpi.randomIndexEdit = {};
}
var serviceid;
var _mainguid;
var agencyguid;
var _procode;
var _dxzbsource;//定性指标数据源
Ext.lt.pmkpi.randomIndexEdit = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _indextype = config.pagetype,
        _tabtype ="IDEXCOMCLS", //页签标识
        _workflow = config.workflow,
        _tabcode,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _modelguid//指标模板guid
    ;
    var cmp = {};
    serviceid = service;
    agencyguid = config.saveAgency;
    _mainguid = config.mainguid;
    _projguid = config.projguid;
    _procode = config.procode;
    _vcol31 = config.vcol31;
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;
    _dxzbsource = config.dxzbsource;
    var isfirst = true;
    $(function () {
        debugger
        commoncmp.initDatatable();
        cmp.query();
        setTimeout(function(){
            initgatherWeight();
            amtTotal(datatable);
        },2000);
    })
    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        //审核定义guid，perf_t_busauditdefine表budguid
        _busguid = config.busguid;
        _modelguid = config.modelguid;
    });
    cmp.query = function(){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = "v_pm_perf_indicator";
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.procode = _procode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setTimeout(function(){
                initgatherWeight();
                amtTotal(datatable);
            },100);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        //if (!datatable.checkAll()) return false;//先校验
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.busguid = _busguid;
        params.procode = _procode;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        cmp.query();
        return rs;
    }
    
    cmp.closePopupWin = function(){
		parent.Ext.lt.ui.modalWindow.close();
	}
    cmp.recom = function(){
        var url = '/pmkpi/program/prjindex/recomindex.page';
        var params = {};
        params.proguid = _projguid;
        params.saveAgency = _saveAgency; //项目单位
        params.prolev = '2';//项目级别 123
        params.fromtype = "tree";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,1100,600,"指标推荐");
    }
    //导入
    cmp["import"] = function(obj){
        // 暂时写死导入模板的code
        var importcode = "120011004";
        var vchtypeid = "C0EC31E80963F7D9E053B11FA8C07998";
        // if (obj.code == "randomimport") { //共性指标导入
        //     importcode = "120011004";
        //     vchtypeid = "C0EC31E80963F7D9E053B11FA8C07998";
        // }
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.importcode = importcode;
        params.vchtypeid = vchtypeid;
        params.pagetype = "add";
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.procode = _procode;
        window.importparam = params;
        Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(){
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.pmkpi.query();
        });
    }

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        var config = obj.table.config;
        var uiconfig = obj.table.uiconfig;
        _tabcode = config.tabcode;
        _tablecode = uiconfig.tablecode;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="indexval"){
                    col.oneditstart = function (table, el, l, c, d) {
                        if(d.levelno != "3"){
                            return false;
                        }
                        el.innerText =  d.indexval!=undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                        // return;
                    }
                    col.oneditend = function (table, el, l, c, d) {
                        if(d.computesign && d.computesign != '6'){
                            if(!checkReferencepole(d.indexval)){
                                d.indexval = '';
                                return false;
                            }
                            d.indexval = d.indexval!="" ? getPointNum(parseFloat(d.indexval)) : "0";
                        }
                    }
            }
            if(col["colcode"]=="computesign"){
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                }
            }
            if(col["colcode"]=="actualvalue"){
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
            		if(d.computesign=="6"){
            			doMapper(_dxzbsource,table.getCol(c));
						this.config.isMulti=false;
						return;
            		}else{
						el.innerText =  d.actualvalue!=undefined ? d.actualvalue : '';
						table.getCol(c).mapping = null;
						table.nowtype="input";
						table.getCol(c).format = "";
						return;
					}
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6'){
                        if(!checkReferencepole(d.actualvalue)){
                            d.actualvalue = '';
                            return false;
                        }
                        d.actualvalue = d.actualvalue!="" ? getPointNum(parseFloat(d.actualvalue)) : "0";
                    }
                }
            }
            if(col["colcode"]=="score"){
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var score = 0;
                        if(data.score){
                        	score = data.score;
                        }
                        return "<b>"+Math.round(score*100)/100+"</b>";
                    }else{
                        return data.score ? data.score : "";
                    }
                }
                
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                }
                
                col.oneditend = function (table, el, l, c, d) {
                	if(!checkReferencepole(d.score)){
                        d.score = '';
                        return false;
                    }
                	d.score = d.score!="" ? getPointNum(parseFloat(d.score)) : "0";
                	gatherScore(d.superid);
                    amtTotal(datatable);
                }
            }
            
            if(col["colcode"]=="remarks"){
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                }
            }

            if(col["colcode"]=="weight"){
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var weight = 0;
                        if(data.weight){
                            weight = data.weight;
                        }
                        return "<b>"+Math.round(weight*100)/100+"</b>";
                    }else{
                        return data.weight ? data.weight : "";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if(d.levelno != "3"){
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                	if(!checkReferencepole(d.weight)){
                        d.weight = '';
                        return false;
                    }
                	d.weight = d.weight!="" ? getPointNum(parseFloat(d.weight)) : "0";
                    gatherWeight(d.superid);
                    amtTotal(datatable);
                }
            }
    		if(col["colcode"]=="operation"){
    			col.style = " text-align:center;";
    			col.fn = function(l,c,data,col){
    				var html = "";
    				if(data.levelno == "2"){
    						//html ="&nbsp;&nbsp;<a herf='#' title = '新增' style='color:#468ac9;cursor:pointer;' onclick=\"measuresToAdd('"+data.guid+"','"+data.levelno+"','"+data.superid+"','"+_projguid+"','"+data.ordernum+"','"+_mainguid+"','"+agencyguid+"','"+data.findex+"','"+data.sindex+"');\">新增</a>"
    				}else if(data.levelno == "3"){
    						html = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a herf='#' title = '删除' style='color:#468ac9;cursor:pointer' onclick=\"delTableRow('"+data.guid+"','"+data.levelno+"','"+data.superid+"','"+_projguid+"');\">删除</a>";
    				}
    				return html;
    			}
    		}
        }
    });
    function amtTotal(table) {
        if(table.getSumobj()){
            var totalrow = table.getRecordset();
            var sumamt = 0;
            var scoresumamt = 0;
            var rowarr = totalrow.toArray();
            var len = rowarr.length;
            for ( var i = 0; i < len; i++) {
                if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
                    var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0;
                    sumamt += parseFloat(weight);
                    var ownscore = rowarr[i]["score"] ? rowarr[i]["score"] : 0;
                    scoresumamt += parseFloat(ownscore);
                }
            }
            var totalrs = {};
            totalrs["weight"] = (sumamt?sumamt.toFixed(2):"0.00");
            totalrs["score"] = (scoresumamt?scoresumamt.toFixed(2):"0.00");
            totalrs.datatable_do_sum=true;
            table.getClockRowSet().setData(totalrs,0);
            if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
                table.reflashdata();
            }
        }
    }
    function initgatherWeight(){
        var data = datatable.getRecordSet().toArray();
        var datas = data;
        var superid;
        for(var i = 0; i < data.length; i++){
            var selectData = data[i];
            if(selectData.levelno == '3'){
                superid = selectData.superid;
                gatherWeight(superid);
            }
        }
        amtTotal(datatable);
        datatable.reflash();
    }
    function gatherWeight(superid){
        var datas = datatable.getRecordSet().toArray();
        if(superid){
            if(datas!=null && datas.length > 0){
                var supguid = '';
                var sortid = 0;
                var result = 0;
                var sourceResult = 0;
                var guid = '';
                for(var i=0;i<datas.length;i++){
                    var selectDatas = datas[i];
                    if(superid == selectDatas.guid){
                        supguid = selectDatas.superid;
                        guid = selectDatas.guid;
                    }
                    if(selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)){
                        result += parseFloat(selectDatas.weight);
                    }
                    if(selectDatas.superid == superid && selectDatas.score && !isNaN(selectDatas.score)){
                        sourceResult += parseFloat(selectDatas.score);
                    }
                }
                datas.each(function(data,i){
                    if(data.guid == guid){
                        datas[i]['score'] = sourceResult==0 ? "" : sourceResult.toFixed(2);
                        datas[i]['weight'] = result==0 ? "" : result.toFixed(2);
                    }
                });
                gatherWeight(supguid);
            }
        }
        datatable.reflash();
    }

    return cmp;
}

function getPointNum(num){  
    var str = String(num);
	var index = str.split(".");
	var str1 = null;
	if(index.length == 2){
		str1 = index[1].substring(0,2);
		str1 = Number(index[0]+"."+str1);
	} else {
		str1 = Number(index[0]);
	}		
    return str1;
}

function checkReferencepole(referencepole){
	var re = /^\d*\.{0,2}\d{0,2}$/;
	if(!re.test(referencepole)){
		Ext.lt.ui.alert("请填写数字！",{timeout:1},function(){});
		return false;
	}else{
		return true;
	}
}

function doMapper(rs,col){
	var mapping = [];
	var columns = [];
	for(var i =0; i<rs.size() ; i++){
		var arr = [];
		 arr.push(rs[i].guid);
		 arr.push(rs[i].code);
		 arr.push(rs[i].name);
		columns.push(arr);
		 mapping[rs[i].code] = arr;
	}
	col.mapping = mapping;
	col.mapper = {} ;
	col.mapper.columns = ['guid','code','name','supcode','pinyin'];
	col.mapper.datas = columns ;
	col.mapper.regs = ['#guid','#code','#name','#supcode','#pinyin'];
	col.mapper.default_column = 'code';
	col.format = '#name';
}

/**
 * 新增
 */
function measuresToAdd(guid,levelno,superid,projguid,ordernum,mainguid,agencyguid,findex,sindex){
	var url = "/pmkpi/randomcomment/measuresAdd.page";
    var params = {};
    params.guid = guid;
    params.levelno = levelno;
    params.findex = superid;
    params.sindex = guid;
    params.superid = superid;
    params.projguid = projguid;
    params.ordernum = ordernum;
    params.mainguid = mainguid;
    params.agencyguid = agencyguid;
	url = Ext.lt.pmkpi.genPageUrl(url, params);
    Ext.lt.ui.openModalWindow(url,800,530,"新增绩效指标")
}

function selectMeasuresToAdd(guid, levelno, superid, projguid,ordernum,mainguid){
	//var url = "/pmkpi/projPerfGoalApply/chooseMeasuresNew.page";
	var url = "/pmkpi/randomcomment/chooseMeasuresAdd.page";
	var params = {};
	params.levelno=levelno;
	params.guid=guid;
	params.superid=superid;
	params.projguid=projguid;
	params.ordernum = ordernum;
	params.mainguid = mainguid;
	url = Ext.lt.pmkpi.genPageUrl(url, params);
    Ext.lt.ui.openModalWindow(url,1000,530,"选择绩效指标")
}

function delTableRow(guid,levelno,superid,projguid){
	Ext.lt.ui.confirm('是否删除当前的指标信息？',null,function(is){
		if(is){
			var datas = datatable.getRecordSet().toArray();
			if(datas!=null && datas.length > 0){
				for(var i=0;i<datas.length;i++){
					var selectDatas = datas[i];
					if(guid == selectDatas.guid){
						datatable.removeData(selectDatas);
					}
				}
				amtTotal(datatable);
				gatherWeight(superid);
			}
		}
	})
}



function gatherScore(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var sortid = 0;
            var result = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                var selectDatas = datas[i];
                if(superid == selectDatas.guid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(selectDatas.superid == superid && selectDatas.score && !isNaN(selectDatas.score)){
                    result += parseFloat(selectDatas.score);
                }
            }
            datas.each(function(data,i){
                if(data.guid == guid){
                    datas[i]['score'] = result==0 ? "" : result.toFixed(2);
                }
            });
            gatherScore(supguid);
        }
    }
    datatable.reflash();
}

