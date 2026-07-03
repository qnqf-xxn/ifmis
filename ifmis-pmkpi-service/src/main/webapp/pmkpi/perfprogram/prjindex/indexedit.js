if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
Ext.lt.pmkpi.indexedit = function(config, serviceid) {
	var _cmp = {},
	    _guid = "",
        _sindex = config["sindex"],
        _upguid = config["upguid"], //新增的二级项目
        _modguid = config["modguid"],
        _fromtype = config["fromtype"], //来源树级表格还是合并表格
        _signs = config["signs"], //计算符号
        _tableid,
	    _type = config["type"],
        isZJ = config["isZJ"],
        indmap = config["indmap"],//指标层次分类
        fundguid = config["fundguid"];
        yearflag = config["yearflag"];
    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            computesign:{
                change: function(param){
                    var ecomputesignstr = param._value.value;
                    if(ecomputesignstr == "9"){ // 合肥添加定量(其他)
                        indexform.clear("meterunit");
                        indexform.hide(['meterunit'],false);
                        indexform.clear("indexval");
                        indexform.clear("kpivalsource");
                        indexform.hide(['indexval'],false);
                        indexform.show(['kpivalsource'],false);
                    }else if(ecomputesignstr == "10"){
                        indexform.clear("meterunit");
                        indexform.hide(['meterunit'],false);
                        indexform.clear("indexval");
                        indexform.clear("kpivalsource");
                        indexform.hide(['indexval'],false);
                        indexform.show(['kpivalsource'],false);
                    } else if(ecomputesignstr != "6"){
                        var data = indexform.getEditFormValues();
                        if(!checkReferencepole(data.indexval)) {
                            indexform.clear("indexval");
                            indexform.clear("meterunit");
                        }
                    	indexform.show(['meterunit'],false);
                        indexform.clear("kpivalsource");
                        indexform.show(['indexval'],false);
                        indexform.hide(['kpivalsource'],false);
                    } else { //隐藏计量单位
                    	indexform.clear("meterunit");
                    	indexform.hide(['meterunit'],false);
                        indexform.clear("indexval");
                        indexform.clear("kpivalsource");
                        indexform.show(['indexval'],false);
                        indexform.hide(['kpivalsource'],false);
                    }
                }
            },
            indexval : {
                change: function(param){
                    var data = indexform.getEditFormValues();
                    if(data.computesign != "6" && data.computesign != "9" && data.computesign != "10"){
                        if(!checkReferencepole(data.indexval)) {
                            indexform.clear("indexval");
                        }
                    }
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

	_cmp.save = function(){
		if(!indexform.check()){
			return false;
		}
		var formobj = indexform.getEditFormValues();
        formobj["guid"] = _guid;
        if (formobj["guid"] ==""){
            formobj["guid"] = getCreateguid(serviceid);
        }
        var indflag = 0;
        var parTabid;
        if(isZJ == 1 && "add" == _type){
            parTabid = parent.parent.eval("datatable");
        } else {
            parTabid = parent.eval(_tableid);
        }
        if ("add" == _type){
            if(isZJ == 1){
                var parent_sel_rows;
                if(fundguid){
                    parent_sel_rows = parTabid.getRecordset().query({fundguid:fundguid});
                }else {
                    parent_sel_rows = parTabid.getRecordset().query({guid:formobj["sindex"]});
                }
            } else {
                var parent_sel_rows = parTabid.getRecordset().query({guid:_upguid});
            }
            var parent_sel_obj = parent_sel_rows[0];
            var _sortid = parent_sel_obj._sortid;
            if (parent_sel_obj["levelno"] == 2 && "tree" == _fromtype) {
                parent_sel_obj["check"] = null;
                parent_sel_obj["isleaf"] = 0;
                parent_sel_obj["_isleaf"] = 0;
                parTabid.reflash(_sortid);
            }
            //var _sortid = parent_sel_obj._sortid;
            if(!fundguid){
                formobj["findex"] = parent_sel_obj["findex"];
                formobj["sindex"] = parent_sel_obj["sindex"];
                formobj.superid = parent_sel_obj["sindex"];
            }
            formobj.levelno = 3;
            formobj.isleaf = 1;
            formobj._isleaf = 1;
            formobj.rowtype = "add";
            formobj.kpi_evalstd = "1"; //部标规范字段
            formobj.kpi_content = formobj["name"]; //部标规范字段
            formobj.is_add = "1";
            formobj.yearflag = yearflag;
            if(isZJ == 1) {
                formobj.status = "3";
                formobj.obligate1 = "删除";
                if(fundguid){
                    var tempfund = parent_sel_obj;
                    formobj.xmlx = tempfund.xmlx;
                    formobj.xmlb = tempfund.xmlb;
                    formobj.xmmxnr = tempfund.xmmxnr;
                    formobj.bzy = tempfund.bzy;
                    formobj.bzjs = tempfund.bzjs;
                    formobj.jldw1 = tempfund.jldw1;
                    formobj.sl1 = tempfund.sl1;
                    formobj.jldw2 = tempfund.jldw2;
                    formobj.sl2 = tempfund.sl2;
                    formobj.zjlywy = tempfund.zjlywy;
                    formobj.procode = tempfund.procode;
                    formobj.fundguid = fundguid;
                    // 此处指标guid为空 代表改项目明细测算下无指标
                    if(!tempfund.guid){
                        indflag = 1;
                    }
                }
            }
            if (formobj["computesign"] == "9"){
                formobj["indexval"] = indexform.getCol("kpivalsource").getvalue();
            }
            if (formobj["computesign"] == "10"){
                formobj["indexval"] = indexform.getCol("kpivalsource").getvalue();
            }
            var addarr = [];
            addarr.push(formobj);
            var zbxs_source = [];
            for(var i=0; i<_signs.length; i++){
                var temparr = [];
                temparr.push(_signs[i]["guid"]);
                temparr.push(_signs[i]["code"]);
                temparr.push(_signs[i]["name"]);
                zbxs_source.push(temparr);
            }
            parTabid.addMapperDatas("computesign",zbxs_source);
            if(fundguid){
                //是否新增
                var isadd_source = [];
                var _isadd = [{guid:"2",code:2,name:"否"},{guid:"1",code:1,name:"是"}];
                for(var i=0; i<_isadd.length; i++){
                    var temparr = [];
                    temparr.push(_isadd[i]["guid"]);
                    temparr.push(_isadd[i]["code"]);
                    temparr.push(_isadd[i]["name"]);
                    isadd_source.push(temparr);
                }
                parTabid.addMapperDatas("is_add",isadd_source);

                // 指标层次分类
                var ind_source = [];
                for(var i=0; i<indmap.length; i++){
                    var temparr = [];
                    temparr.push(indmap[i]["guid"]);
                    temparr.push(indmap[i]["code"]);
                    temparr.push(indmap[i]["name"]);
                    ind_source.push(temparr);
                }
                parTabid.addMapperDatas("findex",ind_source);
                parTabid.addMapperDatas("sindex",ind_source);
                if(indflag == 1){
                    parTabid.getRecordSet().delRow(_sortid);
                }
                parTabid.getRecordSet().addData(addarr,_sortid - 1);
            }else {
                parTabid.getRecordSet().addData(addarr,_sortid + parTabid.getRecordset().toArray().length);

            }
            if((!parent_sel_obj["name"] || parent_sel_obj["name"] =="") && "tree" != _fromtype && fundguid == ""){
                parTabid.getRecordset().delRow(_sortid);
            }
        } else {
            var parent_sel_rows = parTabid.getRecordset().query({guid:_modguid});
            var parent_sel_obj = parent_sel_rows[0];
            var _sortid = parent_sel_obj._sortid;
            /*parent_sel_obj["computesign"] = formobj["computesign"];
            parent_sel_obj["guid"] = formobj["guid"];
            parent_sel_obj["indexval"] = formobj["indexval"];
            parent_sel_obj["meterunit"] = formobj["meterunit"];
            parent_sel_obj["kpi_remark"] = formobj["kpi_remark"];
            parent_sel_obj["name"] = formobj["name"];*/
            if (parent_sel_obj["rowtype"] != "add" ){
                parent_sel_obj.rowtype = "mod";
            }
            if (formobj["computesign"] == "9"){
                formobj["indexval"] = indexform.getCol("kpivalsource").getvalue();
            }
            if (formobj["computesign"] == "10"){
                formobj["indexval"] = indexform.getCol("kpicalnotapply").getvalue();
            }
            $.extend(parent_sel_obj, formobj); //合并值集刷新
            parTabid.reflash(_sortid);
        }
        parent.Ext.lt.ui.modalWindow.close();
	}
    /**
     * 窗口取消.
     */
    _cmp.close = function(){
        parent.Ext.lt.ui.modalWindow.close();
    }
    /**
	 * 加载完成后执行.
     */
    $(function(){
        if ("tree" == _fromtype){
            _tableid = "datatable";
        } else {
            _tableid = "indexdatatable";
        }
        if("mod" == _type){
            var parent_sel_rows = parent.eval(_tableid).getRecordset().query({guid:_modguid});
            var row = parent_sel_rows[0];
            _guid = row["guid"];
            indexform.synchEditformByObj(row);
        } else {
            var uuid = getCreateguid(serviceid);
            _guid = uuid;
		}
    });
	return _cmp;
}