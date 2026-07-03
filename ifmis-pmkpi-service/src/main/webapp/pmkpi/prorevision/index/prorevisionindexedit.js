if(!Ext.lt.pmkpi)
	Ext.lt.pmkpi = {};
Ext.lt.pmkpi.indexedit = function(config, serviceid) {
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
	var _cmp = {},
	    _guid = "",
        _sindex = config["sindex"],
        _upguid = config["upguid"], //新增的二级项目
        _modguid = config["modguid"],
        _fromtype = config["fromtype"], //来源树级表格还是合并表格
        _signs = config["signs"], //计算符号
        _datatype = config.datatype,//数据类型
        _tableid,
        isZJ = config.isZJ,
	    _type = config["type"];

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
        var parTabid;
        if(isZJ == 1 && "add" == _type){
            parTabid = parent.parent.eval("datatable");
        } else {
            parTabid = parent.eval(_tableid);
        }
        if ("add" == _type){
            if(isZJ == 1){
                var parent_sel_rows = parTabid.getRecordset().query({guid:formobj["sindex"]});
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
            formobj["findex"] = parent_sel_obj["findex"];
            formobj["sindex"] = parent_sel_obj["sindex"];
            formobj.superid = parent_sel_obj["sindex"];
            formobj.levelno = 3;
            formobj.isleaf = 1;
            formobj._isleaf = 1;
            formobj.rowtype = "add";
            formobj.status = 3;
            if(isZJ == 1) {
                formobj.is_add = "1";
            }
            if (formobj["computesign"] == "9"){
                formobj["indexval"] = indexform.getCol("kpivalsource").getvalue();
            }
            if (formobj["computesign"] == "10"){
                formobj["indexval"] = indexform.getCol("kpicalnotapply").getvalue();
            }
            var addarr = []; addarr.push(formobj);
            var zbxs_source = [];
            for(var i=0; i<_signs.length; i++){
                var temparr = [];
                temparr.push(_signs[i]["guid"]);
                temparr.push(_signs[i]["code"]);
                temparr.push(_signs[i]["name"]);
                zbxs_source.push(temparr);
            }
            parent.getdataSource();
            parTabid.addMapperDatas("computesign",zbxs_source);
            parTabid.getRecordSet().addData(addarr,_sortid);
            if((!parent_sel_obj["name"] || parent_sel_obj["name"] =="") && "tree" != _fromtype){
                parTabid.getRecordset().delRow(_sortid);
            }
        } else {
            var parent_sel_rows = parTabid.getRecordset().query({guid:_modguid});
            var parent_sel_obj = parent_sel_rows[0];
            var _sortid = parent_sel_obj._sortid;
            if (parent_sel_obj["rowtype"] != "add" ){
                parent_sel_obj.rowtype = "mod";
            }
            if (formobj["computesign"] == "9"){
                formobj["indexval"] = indexform.getCol("kpivalsource").getvalue();
            }
            if (formobj["computesign"] == "10"){
                formobj["indexval"] = indexform.getCol("kpivalsource").getvalue();
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
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        if ("tree" == _fromtype){
            _tableid = "datatable";
        } else {
            _tableid = "indexdatatable";
        }
        if("mod" == _type){
            var row = {};
            var parent_sel_rows = parent.eval(_tableid).getRecordset().query({guid:_modguid});
            var row = parent_sel_rows[0];
            _guid = row["guid"];
            indexform.synchEditformByObj(row);
        } else {
            var uuid = getCreateguid(serviceid);
            _guid = uuid;
		}
    });

    function getdataSource(){
        var datatype_source = [];
        for(var i=0; i<_datatype.length; i++){
            var temparr = [];
            temparr.push(_datatype[i]["guid"]);
            temparr.push(_datatype[i]["code"]);
            temparr.push(_datatype[i]["name"]);
            datatype_source.push(temparr);
        }
        parent.eval(_tableid).addMapperDatas("status",datatype_source);
    }

	return _cmp;
}